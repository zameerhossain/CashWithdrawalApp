import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcchs/Authentication/sharedwidget/PopUpMenuBar.dart';
import 'package:mcchs/Model/user.dart';
import 'package:otp/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class verifyOtp extends StatefulWidget {
  @override
  _verifyOtpState createState() => _verifyOtpState();
}

class _verifyOtpState extends State<verifyOtp> {
  String PhoneNumberfromDb="22";
  String smsCodeUser;
  String sendCode;//send by system
  bool codesent=false;
  String _text="Send Verification Code";
  FirebaseUser user;
  getimage(){
    return Image.asset(
      "assets/images/demo_logo.png",
      fit: BoxFit.fill,
    );
  }

  Future <String> getdata()async{

    try {
      user = await FirebaseAuth.instance.currentUser();
      Firestore.instance.collection('user').document(user.uid)
          .snapshots()
          .listen(
              (data) {

            PhoneNumberfromDb = data.data['phone'];
          }
      );
    }catch(e){
      print(e);
    }
    return PhoneNumberfromDb;
  }

  Future sendOtp()async {
    // await new Future.delayed(const Duration(seconds: 3));
    PhoneNumberfromDb=await getdata();
    await new Future.delayed(const Duration(seconds: 3));

    print(PhoneNumberfromDb);

    if(PhoneNumberfromDb!='22') {
      sendCode = OTP.generateTOTPCodeString('JBSWY3DPEHPK3PXP', DateTime
          .now()
          .millisecondsSinceEpoch,length: 4, interval: 10);
      print(sendCode);


      String url="http://66.45.237.70/api.php?username=01682823962&password=2KDWSZ7X&number="+"88"+PhoneNumberfromDb+"&message="+"Your rozarioshop.com verification code is "+sendCode;
      http.Response res= await http.get(
          url

      );


      codesent=true;

    }//end of if


  }





  @override
  Widget build(BuildContext context) {
    void save()async{
      final prefs = await SharedPreferences.getInstance();
      final key = 'deviceid';
      String value = user.uid;
      prefs.setString(key, value);
      print(value);
    }


    bool verifyOtp(){
      if(sendCode==smsCodeUser){
        return true;
      }
      else{
        return false;

      }
    }



    showAlertDialog(BuildContext context) {

      // set up the button
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: Text("Otp Code is Wrong"),
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


    double _height = MediaQuery.of(context).size.height;


    double _yourheight = _height * 0.23;


    return Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,
          leading:  IconButton(icon: Icon(Icons.arrow_back,size: 35,color: Colors.green,),padding:EdgeInsets.only(left:10,right: 40), ),


          actions: <Widget>[


            CustomePopUPmenuwithoutnotification(),
          ],

        ),
        body: GestureDetector(


          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Center(

                    child:  CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.green[800],
                      child: ClipOval(
                          child: SizedBox(
                            height: 168,
                            width: 168,
                            child: getimage(),
                          )
                      ),

                    ),

                ),
              ),
             // child: Image.asset('assets/images/demo_logo.jpg'),
              Container(
                  height: _yourheight/1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Verify With OTP",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Montserrat',
                          fontSize: 30,
                          decoration: TextDecoration.underline,


                        ),

                      ),

                    ],
                  )
              ),SizedBox(height: 15,),


              Container(
                padding: EdgeInsets.only(left:30 ,right:30 ),

                child: TextField(
                  onChanged: (val){
                    smsCodeUser=val;

                  },


                  textAlign:TextAlign.center ,
                  decoration: InputDecoration(


                    //contentPadding: EdgeInsets.all(20),
                    //labelText: "Mobile No./Email or Id",
                    hintText: "Enter OTP Code",
                    hintStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 15,
                        color: Colors.black
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.green[400], width: 1.5),

                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.green[400], width: 1.5),

                    ),

                  ),


                ),
              ),SizedBox(height: 20,),


              Container(
                  padding: EdgeInsets.only(left:30 ,right:30 ),



                  child: Container(


                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed:(){
                        if(codesent==true) {
                          setState(() {
                            if (verifyOtp() == true) {
                              save();
                              Navigator.of(context).pushReplacementNamed('/home');
                              // Navigator.of(context).pushNamed('');

                            }
                            else {
                              showAlertDialog(context);
                            }
                          });
                        }
                      },
                      child: Text("Verify Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white, fontWeight: FontWeight.bold)),
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
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(0.0, 1.5),
                            blurRadius: 1.5,
                          ),
                        ]),
                  ),


              ),SizedBox(height: 25.0),

              InkWell(
                  onTap: ()async{


                    //                try {
                    //                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    //                  Firestore.instance.collection('user').document(user.uid)
                    //                      .snapshots()
                    //                      .listen(
                    //                          (data) {
                    //
                    //                        PhoneNumberfromDb = data.data['phone'];
                    //                      }
                    //                  );
                    //                }catch(e){
                    //                  print(e);
                    //                }

                    setState(() {
                      _text='Send again ?';

                    });

                    sendOtp();

                  },
                  child: Center(

                      child:  Text(_text,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 17


                        ),
                      )


                  )

              ),
            ],
          ),
        )
    );





  }

  //getting user phonenumber from database
  UserPhoneNumber _userPhoneNumberFromSnapshot(DocumentSnapshot snapshot){
    return UserPhoneNumber(

      phonenumber: snapshot.data["phone"],
    );
  }





}
