import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcchs/Home/notification.dart';
import 'package:mcchs/Services/auth.dart';

import 'CustomeMenuItem.dart';



class CustomePopUPmenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    void choiceact(String choice) async{
      if(choice==CustomeMenuItem.Notificationpage){
        print("notification");


        FirebaseUser user=await FirebaseAuth.instance.currentUser();
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=>notification(user.uid)),
        );

      }
      else if(choice==CustomeMenuItem.SignOut){

        Navigator.of(context).pushNamed("/");
        final AuthService _auth=AuthService();
        await _auth.signOut();


      }
      else if(choice==CustomeMenuItem.Setting){
//        FirebaseUser user=await FirebaseAuth.instance.currentUser();
//
//        Navigator.push(context,
//          MaterialPageRoute(builder: (context)=>edit_profile(user.uid)),
//        );


      }
    }





    return PopupMenuButton(
      icon: Icon(Icons.menu,size: 35,),
      onSelected:choiceact,



      itemBuilder: (BuildContext context){
        return CustomeMenuItem.choices.map((String Choice){
          return PopupMenuItem<String>(

            value: Choice,
            child: Text(Choice),

          );
        }).toList();
      },

    );
  }
}



class CustomePopUPmenuwithoutnotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void choiceactt(String choice) async{

      if(choice==CustomeMenuItem.SignOut){
        Navigator.of(context).pushNamed("/");
        final AuthService _auth=AuthService();
        await _auth.signOut();

      }

    }
    return PopupMenuButton(
      icon: Icon(Icons.menu,size: 35,),
      onSelected: choiceactt,



      itemBuilder: (BuildContext context){
        return CustomeMenuItemwithout.choices.map((String Choice){
          return PopupMenuItem<String>(

            value: Choice,
            child: Text(Choice),

          );
        }).toList();
      },

    );
  }
}

