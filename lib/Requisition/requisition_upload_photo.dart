import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Requisition/requisition_bank_transfer.dart';
import 'package:mcchs/Requisition/requisition_bkash_transfer.dart';

class reqisition_upload_photo extends StatefulWidget {
  String _name,_fatherName,
      _phone,_dateOfBirth,_housingnumber,_address;

 //String _requisitionNidUrlFront,_requisitionNidUrlBack,_requisitionCheckUrlFront,_requisitionCheckUrlBack;
//  reqisition_upload_photo(this._name, this._fatherName, this._phone,this._dateOfBirth,this._housingnumber,
//      this._address, this._requisitionNidUrlFront, this._requisitionNidUrlBack, this._requisitionCheckUrlFront,
//      this._requisitionCheckUrlBack);

  reqisition_upload_photo(this._name, this._fatherName, this._phone,this._dateOfBirth,this._housingnumber,
      this._address);

  @override
  _reqisition_upload_photoState createState() => _reqisition_upload_photoState();
}

class _reqisition_upload_photoState extends State<reqisition_upload_photo> {
  String _filename;
  File _selectedCheque;
  String  _requisitionChequePhotoUrl;
  String error='';
  String errorupload='';
  bool _inProcess=false;
  String status='';
  String errMessage = 'Error Uploading Image';



  void Gobank(){
//    if(_selectedCheque==null){
//      setState(() {
//        error='please upload your photo';
//      });
//    }
  if(_selectedCheque!=null&&status=='OK'){

//
//      Navigator.push(context,
//        MaterialPageRoute(builder: (context)=>requisition_bank_transfer(
//            widget._name, widget._fatherName, widget._phone,widget._dateOfBirth,widget._housingnumber,
//            widget._address, widget._requisitionNidUrlFront, widget._requisitionNidUrlBack,
//            widget._requisitionCheckUrlFront,
//            widget._requisitionCheckUrlBack,
//            _requisitionUserPhotoUrl
//
//        )),
//      );
//
//
    _requisitionChequePhotoUrl="http://rozarioshop.com/Mcchs_image/"+_filename;
      Navigator.push(context,
        MaterialPageRoute(builder: (context)=>requisition_bank_transfer(
            widget._name, widget._fatherName, widget._phone,widget._dateOfBirth,widget._housingnumber,
            widget._address,_requisitionChequePhotoUrl

        )),
      );




    }
  else{
    print(status);
    setState(() {
      error="Please upload your cheque photo";
    });
  }

//    else if(_selectedCheque!=null&&_requisitionChequePhotoUrl==null){
//      setState(() {
//
//        errorupload='Please wait photo is uploading';
//      });
//      print(_requisitionChequePhotoUrl);
//      uploadrequesterphoto();
//    }
  }


  void Gobkash(){
//    if(_selectedCheque==null){
//      setState(() {
//        error='please upload your photo';
//      });
//    }
    if(_selectedCheque!=null&&status=="OK"){
//

      _requisitionChequePhotoUrl="http://rozarioshop.com/Mcchs_image/"+_filename;

      Navigator.push(context,
        MaterialPageRoute(builder: (context)=>requisition_bkash_transfer(
            widget._name, widget._fatherName, widget._phone,widget._dateOfBirth,widget._housingnumber,
            widget._address, _requisitionChequePhotoUrl

        )),
      );



    }else{
      print(status);
      setState(() {
        error="Please upload your cheque photo";
      });
    }


  }





  ///
  ///
  ///


  //upload photo start
  uploadrequesterphoto()async{
 //   FirebaseUser user=await FirebaseAuth.instance.currentUser();
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('Requisition/Cheque/${widget._housingnumber}${"_"+DateTime.now().toString()}');
//    var fileName=widget._housingnumber+DateTime.now().toString();
////
////    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
////
////    StorageUploadTask uploadTask = storageReference.putFile(_selectedCheque);
////    StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
////
////    print('File Uploaded');
////    var url = await downloadUrl.ref.getDownloadURL();
////    if(uploadTask.isComplete){
////      _requisitionChequePhotoUrl=url.toString();
////    }
////    print(_requisitionChequePhotoUrl);
////    print(await _selectedCheque.length());
////    this.setState(() {
////      errorupload='';
////    });

    _filename=widget._housingnumber+"_"+DateTime.now().millisecondsSinceEpoch.toString();
    http.post("http://rozarioshop.com/abc.php", body: {
      "image": base64Encode(_selectedCheque.readAsBytesSync()),
      "name":_filename ,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });

      setState(() {
        errorupload='';
        error='';
      });


  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  Widget getRequester(){
    if(_selectedCheque!=null){
      return Image.file(
        _selectedCheque,
        fit: BoxFit.fill,
      );

    }
    else{
      return Image.asset(
        "assets/images/upload.png",
        fit: BoxFit.fill,
      );
    }

  }

  getRequesterPic() async{
    this.setState((){
      _inProcess=true;
    });
    File image=await ImagePicker.pickImage(source: ImageSource.camera);
    if(image!=null){
      File cropped=await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1,ratioY: 1
          ),
          compressQuality: 50,
          maxHeight: 700,
          maxWidth: 700,




          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,

          )
      );

      this.setState(()  {
        if(cropped!=null) {


          _selectedCheque = cropped??_selectedCheque;


          uploadrequesterphoto();

          _inProcess = false;
        }
        else{
          this.setState((){
            _inProcess=false;
          });
        }
      });
    }else{
      this.setState((){
        _inProcess=false;
      });
    }

  }


 // upload photo end








  @override
  Widget build(BuildContext context) {




    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFFe6e3e3),
        body:Stack(

          children: <Widget>[

            AnnotatedRegion<SystemUiOverlayStyle>(
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
                          padding: EdgeInsets.only(top: 60,right: 30,left: 30,bottom:60),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                indent: 20,
                                endIndent: 20,
                                thickness: 1.5,
                              ),SizedBox(height: 10,),
//                              Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "Please upload your photo ",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ),SizedBox(height: 10,),

//                              Container(
//                                child: Center(
//                                  child: GestureDetector(
//                                    onTap: getRequesterPic,
//                                    child:  CircleAvatar(
//                                      radius: 85,
//                                      backgroundColor: Colors.red[800],
//                                      child: ClipOval(
//                                          child: SizedBox(
//                                            height: 168,
//                                            width: 168,
//                                            child: getRequester(),
//                                          )
//                                      ),
//
//                                    ),
//                                  ),
//                                ),
//                              )
                              Container(
                                alignment: Alignment.center,


                                child: Text(
                                  "Please upload cheque ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[800],
                                  ),
                                ),

                              ),SizedBox(height: 10,),

                              Container(
                                child: Center(
                                    child: GestureDetector(
                                      onTap:  getRequesterPic ,
                                      child: Container(
                                        height: _height/3.7,
                                        width:_width/1,
                                        child: getRequester() ,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey,
                                          border: Border.all( color: Colors.black45,),



                                        ),
                                      ),

                                    )
                                ),
                              ),

                            SizedBox(height: 10,),

                              Text(error,
                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                              ) ,SizedBox(height: 5,),


                              Text(errorupload,
                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                              ) ,
                              SizedBox(height: 30,),



                              Container(
                                alignment: Alignment.center,


                                child: Text(
                                  "How to receive your money? ",
                                  style: TextStyle(
                                    color: Color(0xFF9a0202),
                                  ),
                                ),

                              ),SizedBox(height: 10,),


                              //bank

                              Container(
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child:  MaterialButton(

                                        onPressed: Gobank,


                                        child: Text("Bank transfer",
                                          style: TextStyle(

                                              color: Colors.white,

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


                                    //bkash


                                    Container(

                                      child:  MaterialButton(
                                        padding: EdgeInsets.only(left: 40,right: 40),
                                        onPressed:  Gobkash,


                                        child: Text("Bkash",
                                          style: TextStyle(

                                              color: Colors.white,

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







                            ],

                          ),


                        )

                    )






                )
            ),


            (_inProcess)?Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height*0.98,
              child: Center(
                child:CircularProgressIndicator() ,
              ),
            ):Center()






          ],
        )
    );
  }
}


//upload photo button
//
//
//Container(
//padding: EdgeInsets.only(top:3 ,bottom: 3 ),
//width: _width/3,
//decoration: BoxDecoration(
//
//borderRadius: BorderRadius.circular(10),
//border: Border.all(
//color: Colors.red[800],
//)
//
//),
//
//alignment: Alignment.center,
//child: GestureDetector(
//onTap: (){
//print("asd");
//
//},
//child: Text(
//"Upload photo",
//
//
//),
//)
//
//),
