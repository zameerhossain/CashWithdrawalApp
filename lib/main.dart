import 'package:flutter/material.dart';
import 'package:mcchs/Authentication/verify_otp.dart';
import 'package:mcchs/Home/home_page.dart';
import 'package:mcchs/Wrapper/wrapper.dart';
import 'package:provider/provider.dart';
import 'Authentication/login_page.dart';
import 'Model/user.dart';
import 'Services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: wrapper(),
        routes: <String, WidgetBuilder> {
//          '/SignUp':(_)=>SignUp(),
//          "/Verify_OTP":(_)=>Verify_OTP(),
//          "/Leave_Request":(_)=>Leave_Request(),
//          "/Other_Request":(_)=>Othre_Request_Form(),
            "/home":(_)=>home_page(),
          "/Verify_OTP":(_)=>verifyOtp(),
//          "/Login":(_)=>Login_Page(),
//
//
//
//
//
//
       },
      ),

    );
  }








}


