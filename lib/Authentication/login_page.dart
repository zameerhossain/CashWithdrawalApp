import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Authentication/sharedwidget/constant.dart';
import 'package:mcchs/Authentication/sign_up.dart';
import 'package:mcchs/Services/auth.dart';

class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  final _formKey = GlobalKey<FormState>();
  String error="";
  bool loading=false;
  AuthService _auth=AuthService();
  String _email,_password;


  Gologin()async{

    if(_formKey.currentState.validate()) {

      setState(() => loading=true);

      dynamic result=await _auth.signInWithEmailAndPassword(_email, _password);

      if(result==null) {
        if (this.mounted) {
          setState(() {
            error = 'Invalid email or password';
            loading = false;
          });
        }
      }



    }
  }

  gosignup(){

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => sign_up())

      );


  }


  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.topCenter,
          decoration: kBoxDecorationStyle,

          child: TextFormField(
            onChanged: (val)=>_email=val,
            validator: (val)=>val.isEmpty? "   \t   \t   Enter an Email":null,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.red,

              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
                errorStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,


                    color: Colors.red[800]
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.topCenter,
          decoration: kBoxDecorationStyle,
          child: TextFormField(
            onChanged: (val)=>_password=val,

            obscureText: true,
            validator: (val)=>val.isEmpty? "   \t   \t   Password can"+"'"+"t be Empty":null,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,

                errorStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,


                    color: Colors.red[800]
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }


  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: Gologin,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSocialBtn( String logo) {
    return GestureDetector(
      child: Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
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



  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: gosignup,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',

              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;

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
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 90.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildSocialBtn("assets/images/demo_logo.png"),
                        SizedBox(height: 20,),

                        Text(
                          'The MCCHS Ltd.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildLoginBtn(),
                        Text(error,
                          style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                        ),



                        _buildSignupBtn(),
                      ],
                    ),
                  ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}
