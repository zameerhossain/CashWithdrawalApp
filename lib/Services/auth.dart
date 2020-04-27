import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcchs/Model/user.dart';

import 'database_services.dart';




class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //Creat useer obj based on firebase
  User _userFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) :null;
  }
  // auth change user stteam
  Stream <User> get user{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user)=> _userFirebaseUser(user));
    //   .map(_userFirebaseUser);
  }












  //register with email and password all fields
  Future Register ( String email,String password,
  String name,String phone,
  String dateofbirth, String address,
      String houseSavingNumber,String userPhotoUrl,String userNidUrl,
      String _userNidBackUrl
      ) async{
    try{
      //Creat User
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;


    //  Creat document for user
      await DatabaseService(uid:user.uid).updateUserData( email, password,
           name, phone,
           dateofbirth,  address,
           houseSavingNumber, userPhotoUrl, userNidUrl,_userNidBackUrl);




      return _userFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }


  }





  //Sign in with email and password
  Future signInWithEmailAndPassword(String email,String password ) async{
    String PhoneNumberfromDb;
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return _userFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  //sign out annn
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

//request for leave


//
//  //getting user phonenumber from database
//  UserPhoneNumber _userPhoneNumberFromSnapshot(DocumentSnapshot snapshot){
//    return UserPhoneNumber(
//
//        phonenumber: snapshot.data["phone"],
//    );
//  }
//



}
