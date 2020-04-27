import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Authentication/sharedwidget/constant.dart';
import 'package:mcchs/Authentication/sign_up_more.dart';
import 'package:regexed_validator/regexed_validator.dart';

import 'login_page.dart';

class sign_up extends StatefulWidget {
  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final _formKey = GlobalKey<FormState>();
  String error="";
  String _email,_password,_confirmPassword,_name,_phone,_dateofbirth,_address,_houseSavingNumber;

  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;


    goNextPage(){

      if(_formKey.currentState.validate()) {
        print(_email+_password+_confirmPassword+_name+_phone+_dateofbirth+_address+_houseSavingNumber);
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=>sign_up_more(_email,_password,_name,_phone,_dateofbirth,_address,_houseSavingNumber)),
        );
      }
    }


    Widget _headline(){


      return  Row(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),alignment: Alignment.centerLeft,


              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>login_page())

                );
              }
          ),

          Container(
            width: _width/1.6,
            alignment: Alignment.center,


            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.red[800],
                  fontFamily: 'OpenSans',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    }



    Widget _buildEmailTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,

            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextFormField(
              validator: (_email) =>EmailValidator.validate(_email) ?null:"Please Enter Correct Email",

              onChanged: (val)=>_email=val,

              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black45,
                ),
                hintText: 'Enter Email',
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
      );
    }

    bool passwordvalid(String _match) {
      Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
      RegExp regex = new RegExp(pattern);
      return regex.hasMatch(_match);


    }


    Widget _buildPasswordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,

            padding: EdgeInsets.only(left: 10,right: 10),
            child: TextFormField(
              onChanged: (val)=>_password=val,

              validator: (value) => passwordvalid(value) ?null:"Must contain upper case,"
                  " lower case and a digit"
                  "\natleast 6 character",
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black45,
                ),
                hintText: 'Password',
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
      );
    }

    Widget _buildConfirmPasswordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            alignment: Alignment.centerLeft,

            child: TextFormField(
              onChanged: (val)=>_confirmPassword=val,
              validator: (val)=>_password==val? null:"Password didn"+"'"+"t match",
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(

                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black45,
                ),
                hintText: 'Re-Password',
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
      );
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: _height,
                  width: _width,
                  decoration: BoxDecoration(
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
                ),
                Container(
                  height: _height,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 40,right: 25,left: 25,bottom:60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Center(
                          child: Text(
                            'The MCCHS Ltd.',
                            style: TextStyle(
                              color: Colors.red[800],
                              fontFamily: 'OpenSans',
                              fontSize: 27.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.white,
                          thickness: 1,
                        ),

                        _headline(),

                        SizedBox(height: 10,),

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
                        ),SizedBox(height: 10,),

                        Container(


                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)

                          ),

                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20,),
                              _buildEmailTF(),
                              _buildPasswordTF(),
                              _buildConfirmPasswordTF(),
                              SizedBox(height: 15,),

                              Divider(
                                color: Color(0xFF9a0202),
                                thickness: 2,
                                indent: 25,
                                endIndent: 25,
                              ),  SizedBox(height: 15,),

                              //User name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(
                                      onChanged: (val)=>_name=val,
                                      validator: (val)=>val.isEmpty? " Enter your name":null,

                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.perm_contact_calendar,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Name',
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






                              //Mobile Phone Number
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(

                                      onChanged: (val)=>_phone=val,
                                      validator: (value) =>validator.phone(value)&&value.length==11 ?null:"Please Enter a Valid Phone Number",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Mobile Number',
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

                              //Date Of birth
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(
                                      onChanged: (val)=>_dateofbirth=val,

                                      validator: (val)=>val.isEmpty? "Enter your Date of birth":null,

                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Date of Birth',
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

                              //address

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(
                                      onChanged: (val)=>_address=val,
                                      validator: (val)=>val.isEmpty? "  Enter your address":null,

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
                                        hintText: 'Address',
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




                              //Saving number


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(
                                      onChanged: (val)=>_houseSavingNumber=val,
                                      validator: (val)=>val.isEmpty? "Enter housing savings number":null,

                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'OpenSans',
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.spellcheck,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Housing savings number',
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
                              SizedBox(height: 20,),










                            ],
                          ),






                        ),
                        SizedBox(height: 10,),


                        Container(
                          alignment: Alignment.topRight,
                          child:GestureDetector(
                              onTap: goNextPage,
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Next",
                                    style: TextStyle(

                                        fontSize: 22,
                                        color: Colors.white

                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              )

                          ),

                        ),
                        SizedBox(height: 20,),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    //color: Color(0xFF9a0202),
                                    fontFamily: 'Montserrat',

                                  )

                              ),
                              InkWell(
                                onTap: (){


                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>login_page()),
                                  );
                                },
                                child: Text("Sign In ",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF9a0202),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),

                            ],
                          ),
                        )









                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
