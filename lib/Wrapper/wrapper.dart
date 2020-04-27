import 'package:flutter/material.dart';
import 'package:mcchs/Authentication/login_page.dart';
import 'package:mcchs/Authentication/sign_up_more.dart';
import 'package:mcchs/Authentication/verify_otp.dart';
import 'package:mcchs/Home/home_page.dart';
import 'package:mcchs/Model/user.dart';
import 'package:mcchs/Requisition/requisition_begin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class wrapper extends StatelessWidget {
  String value;
  @override
  Widget build(BuildContext context) {


    void read()async{
      final prefs = await SharedPreferences.getInstance();
      final key = 'deviceid';
      value = prefs.getString(key) ?? '0';

    }

    read();
    final user=Provider.of<User>(context);

    return requisition_begin();

//    if(user==null){
//      return login_page();
//    }
//    else if(user!=null){
//      if(user.uid==value){
//        //print(value+'share');
//        return home_page();
//      }else {
//        print(value);
//        return verifyOtp();
//        // return Verify_OTP();
//      }
//    }
  }
}
