import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Authentication/sharedwidget/PopUpMenuBar.dart';
import 'package:mcchs/Authentication/sharedwidget/constant.dart';
import 'package:mcchs/Authentication/sharedwidget/loading.dart';
import 'package:mcchs/Requisition/requisition_begin.dart';


class home_page extends StatefulWidget {
  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  FirebaseUser user;
  String username;

  getusername()async{

    try {
      user = await FirebaseAuth.instance.currentUser();
      Firestore.instance.collection('user').document(user.uid)
          .snapshots()
          .listen(
              (data) {
               setState(() {
                 username = data.data['name'];
               });
              }
      );

    }catch(e){
      print(e);
    }
    return username;
  }
@override
void initState() {
    // TODO: implement initState
  getusername();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    if(username!=null){
      return Scaffold(
          backgroundColor: Color(0xFFbffdff),
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),

                child:  Container(
                    height: _height,
                    child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),

                        child: Column(

                            children: <Widget>[

                              //Appbar
                              Container(
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(10),

                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [

                                      Color(0xFF61d622),
                                      Color(0xFF148f0b),
                                      Color(0xFF0b8f19),
                                      Color(0xFF0b8f49),
                                    ],
                                    stops: [0.1, 0.4, 0.7, 0.9],
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom:60),

                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,


                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          width: MediaQuery.of(context).size.width/7,
                                          child: Image.asset(
                                              "assets/images/demo_logo.png"
                                          ),
                                        ),
                                        Container(

                                          child: Text(
                                            'The MCCHS Ltd.',
                                            style: TextStyle(
                                              color: Colors.red[800],
                                              fontFamily: 'OpenSans',
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(

                                            color: Colors.red[800],

                                            alignment: Alignment.topRight,
                                            child: CustomePopUPmenu()
                                        ),

                                      ],
                                    ),SizedBox(height: 10,),
                                    Divider(
                                      color: Colors.white,

                                      thickness: 1.5,
                                    ),


                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        SizedBox(height: 10.0),
                                        Container(

                                            alignment: Alignment.centerLeft,
                                            color: Colors.white,

                                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom:5),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.person),
                                                SizedBox(width: 10,),
                                                Text(
                                                  username,
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.red[800],
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),SizedBox(height: 8,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Saving A/C        :"+"25174",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,


                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Last Balance     :"+"25174",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,


                                        ),
                                      ),
                                    ),





                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),


                              //withdrow button

                              Container(
                                padding: EdgeInsets.only(right: 25,left: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(left: 25),
                                        child: Column(

                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context)=>requisition_begin()),
                                                );
                                              },
                                              child: Container(
                                                width:90,
                                                height:90,
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(10.5),
                                                ),
                                                child: Image.asset("assets/images/bkash.png",fit: BoxFit.fill,),
                                              ),

                                            ),SizedBox(height: 3,),
                                            Text(
                                                "Withdrawal"
                                            )
                                          ],
                                        )
                                    ),



                                    Container(
                                        padding: EdgeInsets.only(right: 25),
                                        child: Column(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: (){
                                                print("object");
                                              },
                                              child: Container(
                                                width:90,
                                                height:90,
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(10.5),
                                                ),
                                                child: Image.asset("assets/images/bkash.png",fit: BoxFit.fill,),
                                              ),

                                            ),SizedBox(height: 3,),
                                            Text(
                                                "A/C Statement"
                                            )
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(height: 20,),



                              Container(
                                padding: EdgeInsets.only(right: 25,left: 40),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Recent News",
                                  style: TextStyle(
                                      fontSize: 18
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.red[800],
                                endIndent: 200,
                                thickness: 1.5,
                                indent: 30,
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 25,left: 40),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: <Widget>[
                                    Text("1 Happy NewYear 2020"),
                                    SizedBox(height: 5,),
                                    Text("2 Happy NewYear 2020"),
                                    SizedBox(height: 5,),

                                    Text("3 Happy NewYear 2020"),
                                    SizedBox(height: 5,),

                                  ],
                                ),
                              )

                            ]
                        )
                    )
                ),
              )
          )
      );
    }
    else{
      return Loading();
    }
  }
}

