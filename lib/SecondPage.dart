import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Helper/AlertHelper.dart';
import 'package:flutter_app/Helper/WebKit.dart';
import 'package:flutter_app/Http/ServerApi.dart';
import 'package:flutter_app/ObjectResp/SelfCarePromotion.dart';
import 'package:flutter_app/ObjectResp/SelfCareTwo.dart';
import 'package:loading_gifs/loading_gifs.dart';

class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  bool _displayLoading = false;
  bool error = false;
  String errorMessage = "";
  List<SelfCareTwo> selfCarePromotionList = new List();
  List<SelfCarePromotion> dealerPromotionList = new List();

  //MAIN UI
  @override
  Widget build(BuildContext context) {

    print("_MySecondPageState");
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: error ? displayError(errorMessage) : displayBody(),
        persistentFooterButtons: displayFooterButtons());
  }

  displayBody() {
    return !_displayLoading ? displayPromotionViewOrNoData() : Center(child: CircularProgressIndicator());
  }

  displayPromotionViewOrNoData(){
    bool gotData = selfCarePromotionList.isEmpty && dealerPromotionList.isEmpty;
    return  gotData ? displayNoData() : displayPromotionCardView();
  }

  displayNoData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'No Data',
          ),
        ],
      ),
    );
  }

  displayPromotionCardView() {
    //part 1
    // return ListView(children: createEachCardView());
    //part 2
    return RefreshIndicator(
        onRefresh: selfCarePromotionList.isNotEmpty ? _getSelfCarePromotionData : _getDealerCarePromotionData,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: selfCarePromotionList.isNotEmpty ? selfCarePromotionList.length : dealerPromotionList.length,
          itemBuilder: (BuildContext context, int position) {
            return createEachCardView(position);
          },
        ));
  }

  //part 1
  // createEachCardView(){
  //   List<Widget> widgetList = [];
  //   for(var obj in selfCarePromotionList){
  //     var title = obj.title;
  //     widgetList.add(Padding(padding: EdgeInsets.all(10.0), child: Text("$title")));
  //   }
  //   return widgetList;
  // }

  //part 2
  // Widget createEachCardView(int position){
  //   var obj = selfCarePromotionList.elementAt(position);
  //   var title = obj.title;
  //   var imageUrl = obj.banner;
  //   return GestureDetector(
  //     child: Container(
  //       height: 300,
  //       child: Card(
  //         child: Image.network(imageUrl),
  //         shadowColor: Colors.black,
  //           elevation: 5.0
  //       ),
  //       alignment: AlignmentDirectional.center,
  //       margin: EdgeInsets.only(left: 10, right: 10),
  //     ),
  //     onTap: (){
  //       print("Clicked");
  //     },
  //   );
  // }

  Widget createEachCardView(int position) {
    var obj, link, title, imageUrl;

    if (selfCarePromotionList.isNotEmpty){
      //do selfcare
      obj = selfCarePromotionList.elementAt(position);
      imageUrl = FadeInImage.assetNetwork(
        placeholder: circularProgressIndicatorSmall, image: obj.imageUrl);
      link = obj.url;
      title = obj.title;
    }else{
      //do dealer
      obj = dealerPromotionList.elementAt(position);
      imageUrl = FadeInImage.assetNetwork(
        placeholder: circularProgressIndicatorSmall, image: obj.banner);
      link = obj.bannerUrl;
      title = obj.title;
    }

    return GestureDetector(
      child: Card(
          child: Column(
            children: <Widget>[
              imageUrl,
              Text('$title',
                  style: TextStyle(
                      wordSpacing: 3,
                      height: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14))
            ],
          ),
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          elevation: 5.0,
          semanticContainer: false),
      onTap: () {
        if (link != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebKit(url: link ?? "", title: title ?? "")));
        } else {
          return error = !error;
        }
      },
    );
  }

  Widget displayError(String errorMsg){
    return normalAlertMessage('gg',title: "$errorMsg", buttonText1: "Ok", buttonAction1: (){
      setState(() {
        error = !error;
      });
    });
  }

  displayFooterButtons() {
    return [
      FloatingActionButton(
        heroTag: null,
        onPressed: _getSelfCarePromotionData,
        tooltip: 'Call SelfCare Api',
        child: Icon(Icons.card_giftcard),
        backgroundColor: Colors.red,
        foregroundColor: Colors.yellow,
      ),
      FloatingActionButton(
        heroTag: null,
        onPressed: _getDealerCarePromotionData,
        tooltip: 'Call Dealer Api',
        child: Icon(Icons.card_membership),
        backgroundColor: Colors.red,
        foregroundColor: Colors.yellow,
      )
    ];
  }

  //FUNCTION
  // Set is it to load the screen
  _setLoading() {
    setState(() {
      _displayLoading = !_displayLoading;
    });
  }

  _resetAllList(){
    selfCarePromotionList.clear();
    dealerPromotionList.clear();
  }

  Future<void> _getSelfCarePromotionData() async {
    _resetAllList();
    _setLoading();
    var response = await selfCarePromotionApi();
    if (response != null) {
      _setLoading();
      if(response == 200){
        errorMessage = "List is empty";
        error = !error;
        return;
      }
      selfCarePromotionList.addAll(response);
    }
  }

  Future<void> _getDealerCarePromotionData() async {
     _resetAllList();
    _setLoading();
    var response = await dealerPromotionApi();
    if (response != null) {
      dealerPromotionList.addAll(response);
      _setLoading();
    }
  }

}
