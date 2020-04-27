import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Authentication/sharedwidget/constant.dart';
import 'package:mcchs/Services/database_services.dart';
import 'package:regexed_validator/regexed_validator.dart';


class requisition_bkash_transfer extends StatefulWidget {
  String name,  fatherName,  phone,  dateOfBirth,
   housingnumber,  address,  requisitionNidUrlFront,
       requisitionNidUrlBack,  requisitionCheckUrlFront,
       requisitionCheckUrlBack,  requisitionUserPhotoUrl;


//  requisition_bkash_transfer(
//      this.name,   this.fatherName,   this.phone,  this.dateOfBirth,
//      this.housingnumber,   this.address,   this.requisitionNidUrlFront,
//      this.requisitionNidUrlBack,   this.requisitionCheckUrlFront,
//      this.requisitionCheckUrlBack,   this.requisitionUserPhotoUrl
//
//      );
  requisition_bkash_transfer(
      this.name,   this.fatherName,   this.phone,  this.dateOfBirth,
      this.housingnumber,   this.address,   this.requisitionUserPhotoUrl

      );

  @override
  _requisition_bkash_transferState createState() => _requisition_bkash_transferState();
}

class _requisition_bkash_transferState extends State<requisition_bkash_transfer> {
  final _formKey = GlobalKey<FormState>();
  String bkashNumber;
  String nameOftheBank="invalid";
  String  branceName="invalid";
  String  accountHolderName="invalid";
  String  accountNumber="invalid";
  String transectionType="bkash";


  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 4;
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      content: Text("Your request has been submitted successfully"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(

      context: context,
      builder: (BuildContext context) {

        return alert;
      },
    );
  }

  void Gosubmit()async{
    if(_formKey.currentState.validate()) {
      FirebaseUser user=await FirebaseAuth.instance.currentUser();
      DatabaseService().updateRequisitionData1(
          widget.name,   widget.fatherName,   widget.phone,  widget.dateOfBirth,
          widget.housingnumber,   widget.address,   widget.requisitionUserPhotoUrl,
          transectionType,bkashNumber,
          nameOftheBank,branceName,accountHolderName,accountNumber

      );




      showAlertDialog(context);


    }
  }

  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;


    return Scaffold(
        backgroundColor: Color(0xFFe6e3e3),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/back.png",
                            ),fit: BoxFit.cover
                        )
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 60,right: 25,left: 25,bottom:60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(


                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Container(


                                    child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.red,),alignment: Alignment.centerLeft,


                                        onPressed: (){
                                          Navigator.pop(context);
                                        }
                                    ),

                                  ),
                                  Container(

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
                                  Container(


                                    child: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.transparent,),alignment: Alignment.centerLeft,



                                    ),

                                  ),

                                ],
                              )
                          ),
                          SizedBox(height: 20,),

                          Container(
                            child: Center(
                              child:  Text(
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
                          ),SizedBox(height: 15,),

                          Container(
                            child: Center(
                              child:  Text(
                                'Saving Withdrawal Requisition',
                                style: TextStyle(
                                  wordSpacing: 2,
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),SizedBox(height: 10,),
                          Divider(
                            color: Colors.red[800],
                            indent: 30,
                            endIndent: 20,
                            thickness: 1.5,
                          ),


                          Container(
                            height:50,
                            width: _width/3.8,

                            child: Center(
                              child:  Image.asset(
                                "assets/images/bkash.png",
                                fit: BoxFit.fill,
                              )
                            ),
                          ),SizedBox(height: 10,),


                          //Bkash number
                          Form(
                            key: _formKey,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(
                                      onChanged: (val)=>bkashNumber=val,

                                      validator: (value) =>validator.phone(value)&&value.length==11 ?null:"Enter a valid persona bkash number",

                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.home,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Bkash Mobile Number',
                                        hintStyle: kHintTextStyle,


                                        enabledBorder: OutlineInputBorder(

                                          borderSide: BorderSide(
                                              color: Colors.black45, width: 1.5),

                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45, width: 1.5),

                                        ),
                                        focusedErrorBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45, width: 1.5),
                                        ),
                                        errorBorder:  OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black45, width: 1.5),
                                        ),


                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ),SizedBox(height: 20,),

                          Container(
                            child: Text(
                              "Only Personal Bkash account"
                            ),
                          ),


                          SizedBox(height: 30,),




                          //submit button
                          Container(
                            margin: EdgeInsets.only(top: 20,bottom: 5),
                            child:  MaterialButton(
                              padding: EdgeInsets.only(left: 40,right: 40),
                              onPressed: Gosubmit ,

                              child: Text("Submit",
                                style: TextStyle(

                                    color: Colors.white,
                                    fontSize: 20,

                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Montserrat'
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
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
                          )







                        ],

                      ),


                    )

                )






            )
        )
    );
  }
}
