import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'searchchat';
//import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Netcloud.dart';
import 'chat.dart';
import 'splash.dart';
import 'menu.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'search.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'receipt.dart';
import 'dart:core';
import 'dines.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

import 'package:avatar_glow/avatar_glow.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  MpesaFlutterPlugin.setConsumerKey('8MB6JEgt01F0rxfHkQDGQhf6pf6JGgNn');
  MpesaFlutterPlugin.setConsumerSecret('pZSV0W1k4urlQH54');
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
          screen())); /* MyApp()SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black45.withOpacity(0.5), */
}

class MyApp extends StatefulWidget {
  MyApp(
      {Key? key,
      required this.title,
      required this.token,
      required this.userid})
      : super(key: key);

  final String title;
  final String token;
  final String userid;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final titleController2 = TextEditingController();
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd;

  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: userPhone,
              partyB: "174379",
              callBackURL: Uri(
                  scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
              accountReference: "shoe",
              phoneNumber: userPhone,
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey: '0842');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  String _scanBarcode = 'Unknown';
  var tablename;
  List<List> cart = [];
  var chatdata;
  var chatdata2;
  int numeric = 3;
  var name;
  var sky;
  var sky2;
  var sky3;
  String ii = '1';
  var food1;
  //var ii;
  final _controller = ScrollController();

  var food2;
  var food3;
  var quantity;
  var id;
  var value2;
  var value3;
  var valuey;
  var valuez;
  void decrease(String i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity--;
  }

  void _increase(var i) {
    final prev = ii;
    ii = i;

    if (prev != ii) {
      quantity = 1;
    }
    quantity++;
  }

  Future getWeather7() async {
    String token = widget.token.toString();

    print('here' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = //http://172.16.12.17:8000/
        await http.get(Uri.parse('http://192.168.100.74:8000/chat/'),
            headers: headers);
    var results = jsonDecode(utf8.decode(responsev.bodyBytes));
    setState(() {
      this.chatdata = results;
      this.chatdata2 = results.where((c) => c).toList();
    });
    print(chatdata2.where((x) => print(x)));
    //print(utf8.decode(chatd));
  }

  Future getWeather3x() async {
    String token = widget.token.toString();

    print('here' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = //http://172.16.12.17:8000/
        await http.get(Uri.parse('http://192.168.100.74:8000/restaurant/'),
            headers: headers);
    var results = jsonDecode(responsev.body);
    setState(() {
      this.sky3 = results;
    });
    print(sky3);
  }

  Future getMe() async {
    String token = widget.token.toString();
    String id = widget.userid.toString();

    print('here' + token);
    print('here' + id);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http
        .get(Uri.parse('http://192.168.100.74:8000/me/$id'), headers: headers);
    var xcv = jsonDecode(responsev.body);
    setState(() {
      this.sky2 = xcv;
    });
    //print(sky2);
  }

  Future getWeather(String k) async {
    String token = widget.token.toString();

    print('here' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http.get(
        Uri.parse('http://192.168.100.74:8000/restaurant/' + k),
        headers: headers);
    var results = jsonDecode(responsev.body);
    setState(() {
      this.sky = results;
    });
    print(sky['username'].toString());
  }

  Future getWealth() async {
    String token = widget.token.toString();
    String id = widget.userid.toString();

    print('here' + token);
    print('here' + id);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http
        .get(Uri.parse('http://192.168.100.74:8000/order/'), headers: headers);
    var xcv = jsonDecode(responsev.body);
    setState(() {
      this.food1 = xcv;
    });
    //print(food1);
  }

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    //_bannerAd * sky3.length;
    _bannerAd.dispose();
    _bannerAd.load();

    this.getWeather3x();
    this.getMe();
    this.getWealth();
  }

  Map<String, BannerAd> ads = <String, BannerAd>{};
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.

    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);

    //here's  functs
    //final _controller = ScrollController();

    void senE(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid "),
          content: Text("Didn't get the qrcode"),
        ),
      );
    }

    void senTT(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("$_scanBarcode Successfully Added"),
        ),
      );
    }

    //add the http request here

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode.toString());
      final id = _scanBarcode.length;
      print(barcodeScanRes.substring(2, id));
      this.getWeather(_scanBarcode.toString());
    });
    //if (barcodeScanRes != true) return _launchURL(_scanBarcode.toString());
    if (barcodeScanRes.toString() != '-1') {
      //senTT(context);
      print(barcodeScanRes.length);
      FlutterBeep.beep();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Rutimetable(
              title: barcodeScanRes.substring(0, 1),
              token: widget.token.toString(),
              user: barcodeScanRes.substring(2, id),
              me: sky2['username'].toString()), // sky2['username']
        ),
      );

      //GetData(barcodeScanRes.toString());
      //senTT(context);
    } else {
      print("Not a good url");
      senE(context);
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
          print('At the top');
          numeric = 5;
        } else {
          //CircleAvatar();
          numeric++;
          print('At the bottom');
          print("hello bedroom dev");

          //getWeather();
          //rono = false;
          print(numeric);
        }
      }
    });
    Widget spacer() {
      return Container(
        width: 5.0,
      );
    }

    Widget line() {
      return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadius.all(
                Radius.circular(10.0) //                 <--- border radius here
                )),
        height: 5.0,
        width: 50.0,
      );
    }

    return sky2 != null
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Chip(
                  label: Text("Ssup ,${sky2['username']}.",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),

              actions: [
                FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    child: Center(
                        child: Stack(children: [
                      Icon(Icons.search, color: Colors.blueGrey[900]),
                    ])),
                    onPressed: () {
                      //search starts here
                      print(sky3.toList());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => searchQ(
                                  misearch: sky3,
                                  username: sky2['username'],
                                  token: widget.token.toString(),
                                )),
                      );
                    }),
                FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    child: Center(
                        child: Stack(children: [
                      Icon(Icons.person_outline, color: Colors.blueGrey[900]),
                    ])),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                                height: MediaQuery.of(context).size.height * .2,
                                child: Column(children: [
                                  SizedBox(height: 10),
                                  ListTile(
                                    onTap: () {
                                      getWealth();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => traktar(
                                                    title: food1.toList(),
                                                    title1: sky2['username']
                                                        .toString(),
                                                  )));
                                    },
                                    leading: Icon(Icons.receipt,
                                        color: Colors.amber),
                                    title: Text('receipt'),
                                    //subtitle: Text(i['city'].toString()),//

                                    //title: Text('name',style:TextStyle(color:Colors.black)),
                                  ),
                                  ListTile(
                                    title: Text('log out'),
                                    //

                                    //title: Text('name',style:TextStyle(color:Colors.black)),
                                  )
                                ]));
                          });
                      //this.getWeather3x();
                      //this.getMe();
                      setState(() {
                        //this.getWealth();
                      });

                      const snackBar = SnackBar(
                        content: Text("Just a moment ...fetching data"),
                      );
                      //// ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    })
              ], //food1
            ),

            /* AppBar(
              backgroundColor:Colors.yellow,
              elevation:0.0,
          centerTitle:true,    
              title: const Text('',style:TextStyle(color:Colors.amber)),
              actions:[
                CircleAvatar(
                  radius:15,
                  child:Icon(
                    Icons.person,
                    size:20
                  )
                ),
                SizedBox(width:5),
              ]"Hello ,${sky2['username']}."
              ),*/

            body: sky3 == null ?Container(child:Center(
              child: CircularProgressIndicator(),
            )):Center(
                child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ListTile(
                      title: Text("Discover Restaurants",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      //trailing:
                    ),
                    //ListView.builder(itemCount: ,itemBuilder: (){})

                    ...sky3.map(
                        (i) => /*((sky3.indexOf(i) + 1) % 4 == 0)
                        ? _isBannerAdReady 
                            ? Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: _bannerAd.size.width.toDouble(),
                                  height: _bannerAd.size.height.toDouble(),
                                  child:
                                      AdWidget(ad:  _bannerAd, key: UniqueKey()),
                                ),
                              )
                            : Container()
                        : */
                            Container(

                                //height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Center(
                                    child: InkWell(
                                        child: Card(
                                            elevation: 0.1,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        i['image_of_restaurant']
                                                            .toString()),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(
                                                          10.0) //                 <--- border radius here
                                                      ),
                                                ),
                                                height: 200,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                //
                                              ),
                                              ListTile(
                                                  title: Text(i['username'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  subtitle: Text(i['location']),
                                                  trailing: Container(
                                                    width: 100,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        FloatingActionButton(
                                                            mini: true,
                                                            backgroundColor:
                                                                Colors.white,
                                                            elevation: 0.0,
                                                            child: Center(
                                                                child: Stack(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .group_outlined,
                                                                      color: Colors
                                                                              .green[
                                                                          400]),
                                                                ])),
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return StatefulBuilder(builder: (BuildContext
                                                                            context,
                                                                        StateSetter
                                                                            setState /*You can rename this!*/) {
                                                                      return Scaffold(
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        appBar:
                                                                            AppBar(
                                                                          centerTitle:
                                                                              true,
                                                                          elevation:
                                                                              0.0,
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          title:
                                                                              Text(
                                                                            i['username'],
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                        ),
                                                                        body:
                                                                            SingleChildScrollView(
                                                                          child: Column(
                                                                              // mainAxisAlignment: MainAxisAlignment.tart,
                                                                              children: [
                                                                                ListTile(
                                                                                  title: Chip(
                                                                                    label: Text("Group Ordering."),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Text(
                                                                                  "Number of Users",
                                                                                  style: TextStyle(fontSize: 20),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 30,
                                                                                ),
                                                                                Container(
                                                                                  width: 163,
                                                                                  // width:50,
                                                                                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                                    Container(
                                                                                      child: InkWell(
                                                                                          child: CircleAvatar(child: Icon(Icons.add, color: Colors.green), radius: 30, backgroundColor: Colors.grey[200]),
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              _increase(i['name']);
                                                                                            });
                                                                                            //print('quant2' + cart.toString());

                                                                                            print(quantity.toString());
                                                                                          }),
                                                                                    ),
                                                                                    Text('\t'),
                                                                                    Text(
                                                                                      //
                                                                                      quantity == null ? '1' : quantity.toString(),
                                                                                      style: TextStyle(fontSize: 22),
                                                                                    ),
                                                                                    Text('\t'),
                                                                                    InkWell(
                                                                                        child: CircleAvatar(child: Icon(Icons.remove, color: Colors.green), radius: 30, backgroundColor: Colors.grey[200]),
                                                                                        onTap: () {
                                                                                          //print(i['name']);
                                                                                          setState(() {
                                                                                            if (quantity > 1) {
                                                                                              decrease(i['name']);
                                                                                            }
                                                                                          });
                                                                                          // print(quantity);
                                                                                        }),
                                                                                  ]),
                                                                                ),
                                                                                ListTile(),
                                                                                SizedBox(
                                                                                  height: 1,
                                                                                ),
                                                                                Text(
                                                                                  "Amount per user:",
                                                                                  style: TextStyle(fontSize: 20),
                                                                                ), //
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Container(
                                                                                    width: MediaQuery.of(context).size.width * 0.5,
                                                                                    child: TextField(
                                                                                      controller: titleController2,
                                                                                      keyboardType: TextInputType.number,
                                                                                      textAlign: TextAlign.center,
                                                                                      decoration: InputDecoration(
                                                                                          filled: true,
                                                                                          fillColor: Colors.grey[100],
                                                                                          //fillColor: Colors.white,

                                                                                          //border: OutlineInputBorder(),

                                                                                          labelText: 'Amount',
                                                                                          hintText: 'eg..300'),
                                                                                    )),

                                                                                ListTile(),
                                                                                Container(
                                                                                  height: 50,
                                                                                  width: 250,
                                                                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                                                                                  child: FlatButton(
                                                                                    child: Text(
                                                                                      'generate group',
                                                                                      style: TextStyle(color: Colors.white, fontSize: 25),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      quantity < 2 && titleController2.text != null
                                                                                          ? Container()
                                                                                          : showModalBottomSheet(
                                                                                              isScrollControlled: true,
                                                                                              context: context,
                                                                                              builder: (context) {
                                                                                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                                                                  return Scaffold(
                                                                                                    backgroundColor: Colors.white,
                                                                                                    appBar: AppBar(
                                                                                                      centerTitle: true,
                                                                                                      elevation: 0.0,
                                                                                                      backgroundColor: Colors.white,
                                                                                                      title: Text(
                                                                                                        '',
                                                                                                        style: TextStyle(color: Colors.black),
                                                                                                      ),
                                                                                                    ),
                                                                                                    body: SingleChildScrollView(
                                                                                                      child: Column(
                                                                                                          // mainAxisAlignment: MainAxisAlignment.tart,
                                                                                                          children: [
                                                                                                            ListTile(
                                                                                                              title: Chip(
                                                                                                                label: Text(sky2['username'].toString() + "'s group"),
                                                                                                              ),
                                                                                                            ),
                                                                                                            ListTile(),
                                                                                                            SizedBox(
                                                                                                                height: MediaQuery.of(context).size.height * .25,
                                                                                                                //width: MediaQuery.of(context).size.width*.75,
                                                                                                                child: QrImage(
                                                                                                                  embeddedImageStyle: QrEmbeddedImageStyle(),
                                                                                                                  //QrEmbeddedImageStyle:

                                                                                                                  data: "${i['id']}/${sky2['username']}|${i['username']}|${titleController2.text}|${quantity}",
                                                                                                                  version: QrVersions.auto,
                                                                                                                  size: 200.0,
                                                                                                                )),

                                                                                                            ListTile(),
                                                                                                            SizedBox(
                                                                                                              height: 1,
                                                                                                            ),
                                                                                                            Text(
                                                                                                              "Scan on Swick App",
                                                                                                              style: TextStyle(fontSize: 20),
                                                                                                            ), //

                                                                                                            ListTile(),
                                                                                                            Container(
                                                                                                              height: 40,
                                                                                                              width: 200,
                                                                                                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                                                                                                              child: FlatButton(
                                                                                                                child: Text(
                                                                                                                  'Share',
                                                                                                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                                                                                                ),
                                                                                                                onPressed: () {
                                                                                                                  Future createAlbum() async {
                                                                                                                    print(utf8.encode(titleController2.text));
                                                                                                                    http.Response response1 = await http.post(
                                                                                                                      Uri.parse('http://192.168.100.74:8000/chat/'),
                                                                                                                      headers: <String, String>{
                                                                                                                        'Content-Type': 'application/json; charset=UTF-8',
                                                                                                                      }, //'id','sender','message_me','receiver','time'
                                                                                                                      body: jsonEncode(<String, String>{
                                                                                                                        //'id': titleController.text,this is an autofield
                                                                                                                        'name': 'GroupOrder', //groupbuy
                                                                                                                        'sender': sky2['username'], //parent user
                                                                                                                        'message_me': '${i['id']}/${sky2['username']}|${i['username']}|${titleController2.text}|${quantity}', //ie '2/rono|re|amount|3
                                                                                                                        'receiver': 'Rono', //you
                                                                                                                        'time': 'current time',
                                                                                                                      }),
                                                                                                                    );
                                                                                                                    //print(jsonDecode(response1.data.toString()) );
                                                                                                                    //works => print(token['token']);

                                                                                                                    if (response1.statusCode == 201) {
                                                                                                                      print("yea it happened");
                                                                                                                      print(jsonDecode(response1.body.toString()));
                                                                                                                    }
                                                                                                                    ;

                                                                                                                    //});
//save the token for next time
                                                                                                                  }

                                                                                                                  ;
                                                                                                                  createAlbum();

                                                                                                                  //print(State);
                                                                                                                },
                                                                                                              ),
                                                                                                            ),
                                                                                                            Text('(on swickchat)')

                                                                                                            //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                                                          ]),
                                                                                                    ),
                                                                                                    bottomNavigationBar: Container(
                                                                                                      width: _bannerAd.size.width.toDouble(),
                                                                                                      height: MediaQuery.of(context).size.height * .3,
                                                                                                      child: AdWidget(ad: _bannerAd, key: UniqueKey()),
                                                                                                    ),
                                                                                                  );
                                                                                                });
                                                                                              });
                                                                                      //print(State);
                                                                                    },
                                                                                  ),
                                                                                ),

                                                                                //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                              ]),
                                                                        ),
                                                                      );
                                                                    });
                                                                  });
                                                            }),
                                                        FloatingActionButton(
                                                            mini: true,
                                                            backgroundColor:
                                                                Colors.white,
                                                            elevation: 0.0,
                                                            child: Center(
                                                                child: Stack(
                                                                    children: [
                                                                  Icon(
                                                                      Icons
                                                                          .storefront,
                                                                      color: Colors
                                                                              .yellow[
                                                                          700]),
                                                                ])),
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height *
                                                                                .2,
                                                                        child: Column(
                                                                            children: [
                                                                              SizedBox(height: 10),
                                                                              ListTile(
                                                                                leading: InkWell(
                                                                                    child: Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                                                            ),
                                                                                        image: DecorationImage(
                                                                                          image: NetworkImage(i['image_of_restaurant'].toString()),
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                      child: null /* add child content here */,
                                                                                    ),
                                                                                    onTap: () {}),
                                                                                title: Text(i['username'].toString()),
                                                                                subtitle: Text(i['location'].toString()), //

                                                                                //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                              ),
                                                                              ListTile(
                                                                                onTap: () {
                                                                                  Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => FriendMess(
                                                                                        imageme: i['image_of_restaurant'],
                                                                                        title: i['username'],
                                                                                        token: widget.token.toString(),
                                                                                        user: sky2['username'],
                                                                                      ), // sky2['username']
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                leading: Icon(Icons.chat_outlined, color: Colors.amber),
                                                                                title: Text("Message"),
                                                                                subtitle: Text(''), //

                                                                                //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                              )
                                                                            ]));
                                                                  });
                                                            })
                                                      ],
                                                    ),
                                                  )),
                                            ])),
                                        onTap: () {
                                          //ccmerudi
                                          print(sky3.indexOf(i) + 1);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Rutimetable(
                                                  title: (sky3.indexOf(i) + 1)
                                                      .toString(),
                                                  token:
                                                      widget.token.toString(),
                                                  user: "Menu",
                                                  me: sky2['username']
                                                      .toString()), // sky2['username']
                                            ),
                                          );
                                        })))),
                    sky3.length >= numeric
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber,
                                  blurRadius: 0.0,
                                  spreadRadius: 0,
                                  //offset: Offset(7, 1), // Shadow position
                                ),
                              ],
                            ),
                            child: LinearProgressIndicator(
                              color: Colors.amber,
                              backgroundColor: Colors.yellow,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.amber),
                            )),
                  ]),
            )),

            //floatingbutton
            bottomNavigationBar: SizedBox(
                height: MediaQuery.of(context).size.height * 0.071,
                width: MediaQuery.of(context).size.height * 0.1,
                child: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 5.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Tab(
                        icon: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.amber[50],
                            elevation: 0.0,
                            child: Center(
                                child: Stack(children: [
                              Icon(Icons.timer_outlined, color: Colors.amber),
                            ])),
                            onPressed: () {
                              //the bag
                              setState(() {
                                getWealth();
                              });

                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Scaffold(
                                      appBar: AppBar(
                                          centerTitle: true,
                                          elevation: 0.0,
                                          backgroundColor: Colors.white,
                                          title: Chip(
                                              label:
                                                  Text('Track your  orders'))),
                                      body: Center(
                                        child: RefreshIndicator(
                                          onRefresh: () async {
                                            setState(() {
                                              getWealth();
                                            });

                                            //print("hello bedroom dev");
                                            //getWeather();
                                            //rono = false;
                                            //Do whatever you want on refrsh.Usually update the date of the listview
                                          },
                                          child: SingleChildScrollView(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ...food1.reversed.take(numeric).map(
                                                  (i)
                                                      //var index = sky.indexOf(i);
                                                      =>
                                                      i['owner'].toString() !=
                                                              sky2['username']
                                                                  .toString()
                                                          ? Container()
                                                          : Card(
                                                              elevation: 0.9,
                                                              child: Column(
                                                                  children: [
                                                                    ListTile(
                                                                        leading: Text(
                                                                            i['time']
                                                                                .toString(),
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 21)),
                                                                        trailing: Text("#" + i['id'].toString())
                                                                        //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                        ),
                                                                    ListTile(
                                                                      leading: Icon(
                                                                          Icons
                                                                              .storefront,
                                                                          color:
                                                                              Colors.amber),
                                                                      title: Text(
                                                                          i['restaurantx']
                                                                              .toString()),
                                                                      subtitle: Text(i['table'].toString() ==
                                                                              'Menu'
                                                                          ? "Pickup order"
                                                                          : i['table']
                                                                              .toString()), //
                                                                      trailing: Chip(
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          avatar: Icon(Icons.timer_outlined,
                                                                              color: Colors
                                                                                  .green),
                                                                          label: Text(i['table'] == 'Menu'
                                                                              ? i['ordertime']
                                                                              : 'Anytime')),
                                                                      //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                    ),
                                                                    ListTile(
                                                                      title: Text(i[
                                                                              'food']
                                                                          .replaceAll(
                                                                              '[[',
                                                                              '(')
                                                                          .replaceAll(
                                                                              ']]',
                                                                              ')')
                                                                          .replaceAll(
                                                                              '],',
                                                                              '),')
                                                                          .replaceAll(
                                                                              '[',
                                                                              '(')
                                                                          .toString()),
                                                                      //title: Text((i['food']. replaceAll('[{'f,'').replaceAll('count:',' '). replaceAll('image_url',''). replaceAll('}]','').split('}')).toString(),style:TextStyle(color:Colors.black)),
                                                                      trailing: Chip(
                                                                          backgroundColor: Colors
                                                                              .white,
                                                                          label:
                                                                              Text(i['totalprice'].toString() + '\tKES')), //apply http patch on swickbusiness side
                                                                    ),
                                                                    ListTile(
                                                                      //leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black)),
                                                                      title: Text(
                                                                          'Timeline'),
                                                                      //subtitle: Text(i['totalprice'].toString()+'\tKES'),//
                                                                      trailing: Chip(
                                                                          backgroundColor: Colors.white,
                                                                          label: Text(
                                                                            i['ordertrak'],
                                                                            style:
                                                                                TextStyle(color: i['ordertrak'] != 'ready' ? Colors.red : Colors.green),
                                                                          )),
                                                                      //title: Text('name',style:TextStyle(color:Colors.black)),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            CircleAvatar(
                                                                                backgroundColor: Colors.amber,
                                                                                radius: 18.0,
                                                                                child: Center(
                                                                                    child: Icon(
                                                                                  Icons.fastfood_outlined,
                                                                                  color: Colors.white,
                                                                                ))),
                                                                            spacer(),
                                                                            line(),
                                                                            spacer(),
                                                                            CircleAvatar(
                                                                              backgroundColor: Colors.amber,
                                                                              radius: 18.0,
                                                                              child: Center(
                                                                                  child: Icon(
                                                                                Icons.shopping_bag_outlined,
                                                                                color: Colors.white,
                                                                              )),
                                                                            ),
                                                                            spacer(),
                                                                            line(),
                                                                            spacer(),
                                                                            CircleAvatar(
                                                                                radius: 25,
                                                                                backgroundColor: Colors.green,
                                                                                child: CircleAvatar(
                                                                                    backgroundColor: i['ordertrak'] != 'ready' ? Colors.amber[100] : Colors.amber,
                                                                                    radius: 18.0,
                                                                                    child: Center(
                                                                                        child: Icon(
                                                                                      Icons.restart_alt,
                                                                                      color: Colors.white,
                                                                                    )))),
                                                                            spacer(),
                                                                            line(),
                                                                            spacer(),
                                                                            CircleAvatar(
                                                                              backgroundColor: i['ordertrak'] != 'ready' ? Colors.grey.withOpacity(0.4) : Colors.green,
                                                                              radius: 18.0,
                                                                              child: Center(
                                                                                  child: Icon(
                                                                                Icons.check_circle_outline,
                                                                                color: Colors.white,
                                                                              )),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                  ]))

                                                  //play within this boundaries
                                                  ),
                                            ],
                                          )),
                                        ),
                                      ),
                                      bottomNavigationBar: Container(
                                        height: 60,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width:
                                                _bannerAd.size.width.toDouble(),
                                            height: _bannerAd.size.height
                                                .toDouble(),
                                            child: AdWidget(
                                                ad: _bannerAd,
                                                key: UniqueKey()),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } //=>scanQR()
                            ),
                      ),
                      SizedBox(width: 48.0),
                      FloatingActionButton(
                          mini: true,
                          backgroundColor: Colors.amber[50],
                          elevation: 0.0,
                          child: Center(
                              child: Stack(children: [
                            Icon(Icons.chat_outlined, color: Colors.amber),
                          ])),
                          onPressed: () {
                            setState(() {
                            getWeather7();  
                            });
                           chatdata == null ?
                            //const snackBar = ,
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Just a moment"),
                      ))
                           : 
                            showModalBottomSheet(
                              isScrollControlled:
                                                                      true,
                                context: context,
                                builder: (context) {
                                  return Scaffold(
                                    appBar: AppBar(centerTitle: true,title:line(),elevation: 0.0,backgroundColor:Colors.white),
                                    body: SingleChildScrollView(
                                        child: Column(children: [
                                           
                                          AppBar(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.message_outlined),
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 0.0,
                                      title: Chip(label: Text("SwickChat")),
                                      actions: [
                                        //weka search hapa
                                        
                                        FloatingActionButton(
                                            mini: true,
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            child: Center(
                                                child: Stack(children: [
                                              Icon(Icons.search,
                                                  color: Colors.blueGrey[900]),
                                            ])),
                                            onPressed: () {
                                              //search starts here
                                              print(sky3.toList());
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        chatQ7(
                                                          misearch: sky3,
                                                          username:
                                                              sky2['username'],
                                                          token: widget.token
                                                              .toString(),
                                                        )),
                                              );
                                            }),
                                      ],
                                    ),
                                      Card(
                                          color: Colors.amber,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ...chatdata.map((x) => x == null
                                                    ? Container
                                                    : x['name'] ==
                                                                'GroupOrder' &&
                                                            x['receiver'] ==
                                                                sky2['username']
                                                        ? ListTile(
                                                            onTap: () =>
                                                                Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Rutimetable(
                                                                        title: x['message_me'].split('|')[0].split('/')[
                                                                            0],
                                                                        token: widget
                                                                            .token
                                                                            .toString(),
                                                                        user: x['message_me'].split('/')[
                                                                            1], //idrestaurant
                                                                        me: sky2['username']
                                                                            .toString()), // sky2['username']
                                                              ),
                                                            ),
                                                            trailing: x[
                                                                            'sender'] ==
                                                                        sky2[
                                                                            'username']?FloatingActionButton(
                                            mini: true,
                                            backgroundColor: Colors.white,
                                            elevation: 0.0,
                                            child: Center(
                                                child: Stack(children: [
                                              Icon(Icons.shopping_bag,
                                                  color: Colors.blueGrey[900]),
                                            ])),
                                            onPressed: () {
                                              //bag
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return Scaffold(
                                                      bottomNavigationBar: FloatingActionButton.extended(onPressed: () {
                                                        
                                                      }, label: Text("Order")),
                                                      appBar: AppBar(leading:Icon(Icons.group_outlined,color: Colors.amber,),elevation: 0.0,backgroundColor: Colors.white,title: Text(x['message_me'].split('|')[0].split('/')[1].toString()+"'s group",style: TextStyle(color: Colors.black),),),
                                                      body: SingleChildScrollView(child:Column(children: [
                                                        
                                                ...chatdata.map((i) => i == null
                                                    ? Container
                                                    : i['name'] ==
                                                                'Groupbuy' &&
                                                            i['receiver'] ==
                                                                sky2['username'] && i['sender'].split('|')[2].toString() == x['message_me'].split('|')[1]
                                                        ? 

                                                        Card(child: Column(children:[ListTile(trailing:Text(i['sender'].split('|')[5].toString()),subtitle: Text(i['message_me']),title: Text(i['sender'].split('|')[0].toString()),)]))
                                                      :Container())],)),
                                                    );
                                                  });
                                            }):Text(''),
                                                            title: Center(
                                                                child: Text(
                                                                    'Tap to join order group created by')),
                                                            subtitle: Center(
                                                                child: Text(x[
                                                                            'sender'] ==
                                                                        sky2[
                                                                            'username']
                                                                    ? 'You'
                                                                    : x['sender'])),
                                                          )
                                                        : Container())
                                              ])),
                                      //countries.where((country) => seen.add(country)).toList();
                                      ...sky3.map((i) => ListTile(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FriendMess(
                                                    imageme: i[
                                                        'image_of_restaurant'],
                                                    title: i['username'],
                                                    token:
                                                        widget.token.toString(),
                                                    user: sky2['username'],
                                                  ), // sky2['username']
                                                ),
                                              );
                                            },
                                            leading: InkWell(
                                                child: Container(
                                                  height: 48.5,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(
                                                            10.0) //                 <--- border radius here
                                                        ),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          i['image_of_restaurant']
                                                              .toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child:
                                                      null /* add child content here */,
                                                ),
                                                onTap: () {}),
                                            subtitle: Text(
                                              "Message",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            title: Text(
                                              "${i['username']}",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            trailing: CircleAvatar(
                                                radius: 13,
                                                backgroundColor:
                                                    Colors.yellow[700],
                                                child: Center(
                                                    child: RotatedBox(
                                                        quarterTurns: 180,
                                                        child: Icon(
                                                          Icons
                                                              .message_outlined,
                                                          size: 12,
                                                          color: Colors.white,
                                                        )))),
                                          ))
                                    ])),
                                    bottomNavigationBar: Container(
                                      height: 60,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width:
                                              _bannerAd.size.width.toDouble(),
                                          height:
                                              _bannerAd.size.height.toDouble(),
                                          child: AdWidget(
                                              ad: _bannerAd, key: UniqueKey()),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                            //this.getWeather3x();
                            //this.getMe();
                            setState(() {
                              //this.getWealth();
                            });

                            const snackBar = SnackBar(
                              content: Text("Just a moment ...fetching data"),
                            );
                            //// ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          })
                    ],
                  ),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
                mini: false,
                backgroundColor: Colors.amber,
                elevation: 0.0,
                child: Center(
                    child: Stack(children: [
                  Icon(Icons.qr_code_scanner, color: Colors.green),
                ])),
                onPressed: () {
                  //FlutterBeep.playSysSound(41);
                  scanQR();
                })

            /*
            FloatingActionButton.extended(
            backgroundColor: Colors.yellow[700],
            icon: Icon(Icons.flatware_outlined),
            label: Text("scan QR to Order"),
            onPressed: () => scanQR(),
            

            // This trailing comma makes auto-formatting nicer for build methods.
        )*/
            )
        : Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Text(''),
                ListTile(title: Text("")),
                Center(
                  child: CircularProgressIndicator(),
                )
              ])));
  }
}
