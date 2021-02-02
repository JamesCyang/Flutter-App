import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/MainRoute.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _myHomePageTitle;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId;

  final SmsAutoFill _autoFill = SmsAutoFill();

  void _incrementCounter() {
    print("_incrementCounter");
    setState(() {
      _counter++;
    });
  }

  void _decreasedCounter() {
    setState(() {
      _counter--;
    });
  }

  void _goToSecondPage() {
    Navigator.of(context).pushNamed('/second');
  }

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void verifyPhoneNumber() async{
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser.uid}");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code: " + verificationId);
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: ${e}");
    }
  }

  void signInWithPhoneNumber(){

  }

  @override
  Widget build(BuildContext context) {
    _myHomePageTitle = widget.title;
    print("_MyHomePageState");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: routes.length + 1,
          itemBuilder: (context, index) {
            return createDrawer(index);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Padding(padding: EdgeInsets.all(50), child:
           Column(
                children: [
                  TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                          labelText: 'Phone number (+xx xxx-xxx-xxxx)')
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: RaisedButton(
                        child: Text("Get current number"),
                        onPressed: () async => {
                              _phoneNumberController.text = await _autoFill.hint
                            },
                        color: Colors.greenAccent[700]),
                  ),
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
            Text('$_myHomePageTitle'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: null,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          elevation: 3.0,
          autofocus: true,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _decreasedCounter,
          tooltip: 'Increment',
          child: Icon(Icons.remove),
          backgroundColor: Colors.green,
        ),
        FloatingActionButton(
          heroTag: null,
          onPressed: _goToSecondPage,
          tooltip: 'Increment',
          child: Icon(Icons.arrow_circle_up_sharp),
          backgroundColor: Colors.black,
        ),
      ],
    );
  }

  Widget createDrawer(int index) {
    if (index == 0) {
      return DrawerHeader(
        child: Text('Tune Talk'),
        decoration: BoxDecoration(color: Colors.red),
      );
    }

    return ListTile(
      selectedTileColor: Colors.redAccent,
      title: Text('Index $index'),
      onTap: () {
        Navigator.of(context).pushNamed(routeList.elementAt(index - 1));
      },
    );
  }
}
