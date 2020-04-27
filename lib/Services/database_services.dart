import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mcchs/models/requisition_list.dart';
import 'package:intl/intl.dart';


class DatabaseService{

  final String uid;


  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection("user");
  final CollectionReference requisitionCollection = Firestore.instance.collection("requisition");

//  //sign up intial data and update the data later
  Future updateUserData(String email,String password,
      String name,String phone,
      String dateofbirth, String address,
      String houseSavingNumber,String userPhotoUrl,String userNidUrl ,String userNidBackUrl)async{
    return await userCollection.document(uid).setData(
        {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
          'dateofbirth':dateofbirth,
          'address':address,
          'houseSavingNumber':houseSavingNumber,
          'userPhotoUrl':userPhotoUrl,
          'userNidUrl': userNidUrl,
          "userNidBackUrl":userNidBackUrl,
          'uid':uid,



        }
    );
  }


  Future updateRequisitionData(

  String name,   String fatherName,  String phone, String dateOfBirth,
  String housingnumber,   String address, String requisitionNidUrlFront,
      String requisitionNidUrlBack,  String requisitionCheckUrlFront,
      String requisitionCheckUrlBack,  String requisitionUserPhotoUrl,
      String transectionType,String bkashNumber,
      String nameOftheBank,String branceName,String accountHolderName,String accountNumber
      )async{
    String requestStatus='pending';
    String adminMsg='';
    String adminPic='';

    return await requisitionCollection.document().setData(
        {
          "name":name,
          'fatherName':fatherName,
          "phone":phone,
          "dateOfBirth":dateOfBirth,
          "housingnumber":housingnumber,
          "address":address,
          "requisitionNidUrlFront":requisitionNidUrlFront,
          "requisitionNidUrlBack":requisitionNidUrlBack,
          "requisitionCheckUrlFront":requisitionCheckUrlFront,
          'requisitionCheckUrlBack':requisitionCheckUrlBack,
          'requisitionUserPhotoUrl':requisitionUserPhotoUrl,
          'transectionType':transectionType,
          'bkashNumber':bkashNumber,
          'nameOftheBank':nameOftheBank,
          'branceName':branceName,
          'accountHolderName':accountHolderName,
          'accountNumber':accountNumber,
          'userId':uid,
          "requestStatus":requestStatus,
          "adminMsg":adminMsg,
          "adminPic":adminPic


        }
    );
  }


  Future updateRequisitionData1(

      String name,   String fatherName,  String phone, String dateOfBirth,
      String housingnumber,   String address,  String requisitionChequePhotoUrl,
      String transectionType,String bkashNumber,
      String nameOftheBank,String branceName,String accountHolderName,String accountNumber,
      )async{
    String requestStatus='pending';
    String adminMsg='';
    String adminPic='';
    String date=DateFormat('dd-MM-yyyy').format(DateTime.now());

    return await requisitionCollection.document().setData(
        {
          "name":name,
          'fatherName':fatherName,
          "phone":phone,
          "dateOfBirth":dateOfBirth,
          "housingnumber":housingnumber,
          "address":address,

          'requisitionChequePhotoUrl':requisitionChequePhotoUrl,
          'transectionType':transectionType,
          'bkashNumber':bkashNumber,
          'nameOftheBank':nameOftheBank,
          'branceName':branceName,
          'accountHolderName':accountHolderName,
          'accountNumber':accountNumber,
          'userId':uid,
          "requestStatus":requestStatus,
          "adminMsg":adminMsg,
          "adminPic":adminPic,



        }
    );
  }





  List<requisitionList> _requisitionrequestSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return requisitionList(
          doc.data['name']??null,
          doc.data['fatherName']??null,
          doc.data['phone']??null,
          doc.data['dateOfBirth']??null,
          doc.data['housingnumber']??null,
          doc.data['address']??null,
          doc.data['requisitionNidUrlFront']??null,
          doc.data['requisitionNidUrlBack']??null,
          doc.data['requisitionCheckUrlFront']??null,
          doc.data['requisitionCheckUrlBack']??null,
          doc.data["requisitionUserPhotoUrl"]??null,
          doc.data["transectionType"]??null,
          doc.data["bkashNumber"]??null,
          doc.data['nameOftheBank']??null,
          doc.data["branceName"]??null,
          doc.data[ "accountHolderName"]??null,
          doc.data[ "accountNumber"]??null,
          doc.data['requestStatus']??null,
          doc.data['adminMsg']??null,
          doc.data['adminPic']??null,
          doc.data['userId']??null,
          doc.documentID
      );



    }).toList();

  }
  Stream <List<requisitionList>> get requisitionrequestlist{
    return requisitionCollection.snapshots()
        .map(_requisitionrequestSnapshot);
  }










}
