import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';

class screenxc extends StatefulWidget {
  const screenxc({Key? key}) : super(key: key);

  @override
  _screenxcState createState() => _screenxcState();
}

class _screenxcState extends State<screenxc> {
  @override
  void initState() {
    super.initState();
    _navtohome();
  }

  _navtohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    //Navigator.pop(context);
    }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline,size:70),
          SizedBox(height:MediaQuery.of(context).size.height*0.1),
          Text("Thank You"+'\n'+"You'll receive your order in a few.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22), textAlign: TextAlign.center,),
          
          /*Container(
              height: MediaQuery.of(context).size.width * 0.45,
              width: MediaQuery.of(context).size.width * 0.45,
              child: Image.asset('assets/play_store_512.png')),*/
          
              
        ],
      )),
      bottomNavigationBar: Container(
              height: MediaQuery.of(context).size.width * 0.10,
              width: MediaQuery.of(context).size.width * 0.10,
              child: Text("",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}

         
           