import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Requisition/requisition_details.dart';

class requisition_begin extends StatefulWidget {
  @override
  _requisition_beginState createState() => _requisition_beginState();
}

class _requisition_beginState extends State<requisition_begin> {



  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;

    Widget _buildSocialBtn( String logo) {
      return GestureDetector(
        child: Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF61d622),
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
            image: DecorationImage(
                fit: BoxFit.fill,
                image:AssetImage(logo)
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Stack(
            children: <Widget>[
              Container(
                height: _height,
                width: _width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/back.png",
                        ),fit: BoxFit.cover
                    )
                ),
              ),
              Container(

                height: _height,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 110,right: 25,left: 25,bottom:60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(


                          child: Center(
                            child: Container(
                              height: 120.0,
                              width: 120.0,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red,

                                    blurRadius: 6.0,
                                  ),
                                ],
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:AssetImage("assets/images/demo_logo.png"),
                                ),
                              ),
                            ),
                          )
                      ),SizedBox(height: 20,),
                      Center(
                        child: Text(
                          'The MCCHS Ltd.',
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Colors.red[800],
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.red[800],
                        thickness: 1,
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.only(left: 70,right:30),


                        child: Text(
                          'Saving Withdrawal  Requisition Maximum  20000/= taka only ',
                          style: TextStyle(

                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 23.0,

                            fontWeight: FontWeight.w400,

                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),


                      Container(
                        child:  MaterialButton(
                          padding: EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
                          onPressed: ()async{
                            FirebaseAuth _mauth=FirebaseAuth.instance;
                            _mauth.signInAnonymously();


                            Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>requisition_details())
                            );

                          },


                          child: Text("Requisition Form",
                            style: TextStyle(

                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all( color: Colors.white,),

                            gradient: LinearGradient(

                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [

                                Color(0xFF6349b8),
                                Color(0xFF993fd9),
                                Color(0xFFa70dd1),
                                Color(0xFFcb0dd1),
                              ],
                              stops: [0.1, 0.4, 0.7, 0.9],
                            ), boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(0.0, 1.5),
                            blurRadius: 1.5,
                          ),
                        ]),
                      ),



                      ],
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
