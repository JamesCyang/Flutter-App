import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePhoneAuth extends StatefulWidget {
  FirebasePhoneAuth({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirebasePhoneAuthState createState() => _FirebasePhoneAuthState();
}

class _FirebasePhoneAuthState extends State<FirebasePhoneAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;

  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print(
          "Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
      await _auth.signInWithCredential(phoneAuthCredential);
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print(
          'Please check your phone for the verification code. $verificationId and $forceResendingToken');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print("Failed to Verify Phone Number: $e");
    }
  }

  void signInWithPhoneNumber() async {
    if (_smsController.text != null && _smsController.text.isNotEmpty) {
      AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _smsController.text);
      final User user =
          (await _auth.signInWithCredential(phoneAuthCredential)).user;
      print(user);
    } else {
      print('Insert OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                          labelText: 'Phone number (+xx xxx-xxx-xxxx)')),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Colors.greenAccent[400],
                      child: Text("Verify Number"),
                      onPressed: () async {
                        verifyPhoneNumber();
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _smsController,
                    decoration:
                        const InputDecoration(labelText: 'Verification code'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        color: Colors.greenAccent[200],
                        onPressed: () async {
                          signInWithPhoneNumber();
                        },
                        child: Text("Sign in")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
