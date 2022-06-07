

import 'package:flutter/material.dart';
import 'menu.dart';

class searchQ extends StatefulWidget {
  searchQ(
      {Key? key,
      required this.misearch,
      required this.username,
      required this.token})
      : super(key: key);
  List misearch;
  String username;
  String token;
  @override
  State<searchQ> createState() => _searchQState();
}

class _searchQState extends State<searchQ> {
  final titleController = TextEditingController();
  List ronox = [];

  /* */
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List rono = widget.misearch;
    bool woz = true; //yea i was listening to steve wozniak

    void sq(List x) {
      setState(() => ronox = x);
      print(ronox);

      //rono was here 5/20/22~2:29am
    }

    @override
    void initState() {
      super.initState();
      titleController.text = '';
      print('search bar' + titleController.text);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Container(),
            centerTitle: true,
            flexibleSpace: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onTap: () {
                          woz = true;

                          sq(rono
                              .where(
                                (x) => x['name'].toLowerCase().contains(''),
                                //print(x);
                              )
                              .toList());
                        },
                        //actions:[],
                        onChanged: (text) {
                          //print(rono[0]['food'][0]['name']);

                          //print("can't get this" + rono.toString());

                          woz = true;
                          
                          sq(rono
                              .where(
                                (x) => x['food'][0]['name'].toLowerCase().contains(text),
                                //print(x);
                              )
                              .toList());
                          print(ronox.first);
                        },

                        autofocus: false,
                        controller: titleController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: woz
                                ? InkWell(
                                    child: Icon(Icons.close),
                                    onTap: () {
                                      //woz = true;

                                      titleController.clear();
                                      titleController.text = '';
                                      print('was here');
                                    },
                                  )
                                : Container(),
                            filled: true,
                            fillColor: Colors.grey[100],
                            //fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            //labelText: 'Search',
                            hintText: 'Type to Search and see suggestions'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: ronox != ''
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    //Text(ronox.toString()),
                    ...ronox.map((e) => ListTile(
                      leading: InkWell(child:Container(
                  
                  width:50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
        Radius.circular(10.0) //                 <--- border radius here
    ),
          image: DecorationImage(
            image: NetworkImage(e['food'][0]['image_url'].toString()),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),onTap:(){}),
      subtitle: Text(''),
                      title: Text(e['food'][0]['name'].toString()),
                    ))
                    //Text('xcd' + ronox.toString()),
                    
                    ],
                ),
              )
            : Scaffold(
                body: Column(
                children: [
                  ListTile(
                    title: Text(''),
                  ),
                ],
              )));
  }
}
