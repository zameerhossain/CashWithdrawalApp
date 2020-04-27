//import 'dart:io';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:path/path.dart' as Path;
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter/widgets.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:mcchs/Authentication/sharedwidget/constant.dart';
//import 'package:mcchs/Requisition/requisition_upload_photo.dart';
//class requisition_nid_check extends StatefulWidget {
//  String _name,_fatherName,
//      _phone,_dateOfBirth,_housingnumber,_address;
//
//  requisition_nid_check(this._name, this._fatherName,this._phone, this._dateOfBirth,this._housingnumber,
//      this._address);
//
//  @override
//  _requisition_nid_checkState createState() => _requisition_nid_checkState();
//}
//
//class _requisition_nid_checkState extends State<requisition_nid_check> {
//  File _requisitionNidFront,_requisitionNidBack,_requisitionCheckFront,_requisitionCheckBack;
//  String _requisitionNidUrlFront,_requisitionNidUrlBack,_requisitionCheckUrlFront,_requisitionCheckUrlBack;
//  bool _inProcess=false;
//  String errorNidFront='';
//  String errorNidBack='';
//  String errorChequeFront='';
//  String errorChequeBack='';
//  String error='';
//
//
//
//  void GoNextPage(){
//    if(_requisitionNidFront==null){
//      setState(() {
//
//        errorNidFront="Please upload photo Id front";
//      });
//    }
//    if(_requisitionNidBack==null){
//      setState(() {
//
//        errorNidBack="Please upload photo Id back";
//      });
//    }
//    if(_requisitionCheckFront==null){
//      setState(() {
//
//        errorChequeFront="Please upload Cheque front";
//      });
//    }
//    if(_requisitionCheckBack==null){
//      setState(() {
//
//        errorChequeBack="Please upload Cheque back";
//      });
//    }
//    if(_requisitionNidUrlFront!=null&&
//        _requisitionNidUrlBack!=null&&
//        _requisitionCheckUrlFront!=null&&
//        _requisitionCheckUrlBack!=null) {
//      //go next page
//      error='';
//
//
//      print("ready");
//      Navigator.push(context,
//        MaterialPageRoute(builder: (context)=>reqisition_upload_photo(
//
//            widget._name, widget._fatherName,widget._phone, widget._dateOfBirth,widget._housingnumber,
//            widget._address, _requisitionNidUrlFront,_requisitionNidUrlBack,
//            _requisitionCheckUrlFront,_requisitionCheckUrlBack
//        )),
//      );
//    }
//    else if(_requisitionNidFront!=null&&_requisitionNidBack!=null&&
//        _requisitionCheckFront!=null&&_requisitionCheckBack!=null){
//     if (_requisitionNidUrlFront==null||_requisitionNidUrlBack==null||
//     _requisitionCheckUrlFront==null||_requisitionCheckUrlBack==null){
//       setState(() {
//
//         error='Photos are uploading. Please wait a moment';
//       });
//     }
//    }
//
//
//  }
//
//
//
//
//  //cheque front start
//
//  uploadChequeFront()async{
//    FirebaseUser user=await FirebaseAuth.instance.currentUser();
//
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('Requisition/Cheque/${user.uid}${"_"+DateTime.now().toString()+"_front"}${Path.extension(_requisitionCheckFront.path)}');
//
//    StorageUploadTask uploadTask = storageReference.putFile(_requisitionCheckFront);
//    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//    print(Path.basename(_requisitionCheckFront.path));
//    print('File Uploaded');
//    _requisitionCheckUrlFront = (await downloadUrl.ref.getDownloadURL());
//    print(_requisitionCheckUrlFront);
//    this.setState(() {
//      errorChequeFront='';
//    });
//
//  }
//
//  Widget getChequeFront(){
//    if(_requisitionCheckFront!=null){
//      return Image.file(
//        _requisitionCheckFront,
//        fit: BoxFit.fill,
//      );
//
//    }
//    else{
//      return Image.asset(
//        "assets/images/demo_logo.png",
//        fit: BoxFit.fill,
//      );
//    }
//
//  }
//
//  getChequeFrontPic() async{
//    this.setState((){
//      _inProcess=true;
//    });
//    File image=await ImagePicker.pickImage(source: ImageSource.camera);
//    if(image!=null){
//      File cropped=await ImageCropper.cropImage(
//          sourcePath: image.path,
//          aspectRatio: CropAspectRatio(
//              ratioX: 1,ratioY: 1
//          ),
//          compressQuality: 100,
//          maxHeight: 300,
//          maxWidth: 500,
//          compressFormat: ImageCompressFormat.jpg,
//          androidUiSettings: AndroidUiSettings(
//            toolbarColor: Colors.deepOrange,
//            toolbarTitle: "Cropper",
//            statusBarColor: Colors.deepOrange.shade900,
//            backgroundColor: Colors.white,
//          )
//      );
//
//      this.setState((){
//        if(cropped!=null) {
//
//
//
//          _requisitionCheckFront = cropped??_requisitionCheckFront;
//          error='Photos are uploading. Please wait a moment';
//
//          uploadChequeFront();
//          errorChequeFront="";
//          _inProcess = false;
//        }
//        else{
//          this.setState((){
//            _inProcess=false;
//          });
//        }
//      });
//    }else{
//      this.setState((){
//        _inProcess=false;
//      });
//    }
//
//  }
//
//
//
//  //cheque front end
//
//
//
//  //cheque back Start
//
//
//  uploadChequeBack()async{
//    FirebaseUser user=await FirebaseAuth.instance.currentUser();
//
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('Requisition/Cheque/${user.uid}${"_"+DateTime.now().toString()+"_back"}${Path.extension(_requisitionCheckBack.path)}');
//
//    StorageUploadTask uploadTask = storageReference.putFile(_requisitionCheckBack);
//    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//    print(Path.basename(_requisitionCheckBack.path));
//    print('File Uploaded');
//    _requisitionCheckUrlBack = (await downloadUrl.ref.getDownloadURL());
//    print(_requisitionCheckUrlBack);
//
//    this.setState(() {
//      errorChequeBack='';
//
//    });
//  }
//
//  Widget getChequeBack(){
//    if(_requisitionCheckBack!=null){
//      return Image.file(
//        _requisitionCheckBack,
//        fit: BoxFit.fill,
//      );
//
//    }
//    else{
//      return Image.asset(
//        "assets/images/demo_logo.png",
//        fit: BoxFit.fill,
//      );
//    }
//
//  }
//
//  getChequeBackPic() async{
//    this.setState((){
//      _inProcess=true;
//    });
//    File image=await ImagePicker.pickImage(source: ImageSource.camera);
//    if(image!=null){
//      File cropped=await ImageCropper.cropImage(
//          sourcePath: image.path,
//          aspectRatio: CropAspectRatio(
//              ratioX: 1,ratioY: 1
//          ),
//          compressQuality: 100,
//          maxHeight: 300,
//          maxWidth: 500,
//          compressFormat: ImageCompressFormat.jpg,
//          androidUiSettings: AndroidUiSettings(
//            toolbarColor: Colors.deepOrange,
//            toolbarTitle: "Cropper",
//            statusBarColor: Colors.deepOrange.shade900,
//            backgroundColor: Colors.white,
//          )
//      );
//
//      this.setState((){
//        if(cropped!=null) {
//
//
//
//          _requisitionCheckBack = cropped??_requisitionCheckBack;
//          error='Photos are uploading. Please wait a moment';
//          uploadChequeBack();
//          errorChequeBack="";
//          _inProcess = false;
//        }else{
//          this.setState((){
//            _inProcess=false;
//          });
//        }
//      });
//    }else{
//      this.setState((){
//        _inProcess=false;
//      });
//    }
//
//  }
//
//
//
//
//  //cheque back end
//
//
//
//
//
//
////nid housingid front start
//  uploadNidFront()async{
//    FirebaseUser user=await FirebaseAuth.instance.currentUser();
//
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('Requisition/Id/${user.uid}${"_"+DateTime.now().toString()+"_front"}${Path.extension(_requisitionNidFront.path)}');
//
//    StorageUploadTask uploadTask = storageReference.putFile(_requisitionNidFront);
//    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//    print(Path.basename(_requisitionNidFront.path));
//    print('File Uploaded');
//    _requisitionNidUrlFront = (await downloadUrl.ref.getDownloadURL());
//    print(_requisitionNidUrlFront);
//    this.setState(() {
//      errorNidFront='';
//      error='';
//    });
//
//  }
//
//  Widget getNidFront(){
//    if(_requisitionNidFront!=null){
//      return Image.file(
//        _requisitionNidFront,
//        fit: BoxFit.fill,
//      );
//
//    }
//    else{
//      return Image.asset(
//        "assets/images/demo_logo.png",
//        fit: BoxFit.fill,
//      );
//    }
//
//  }
//
//  getNidFrontPic() async{
//    this.setState((){
//      _inProcess=true;
//    });
//    File image=await ImagePicker.pickImage(source: ImageSource.camera);
//    if(image!=null){
//      File cropped=await ImageCropper.cropImage(
//          sourcePath: image.path,
//          aspectRatio: CropAspectRatio(
//              ratioX: 1,ratioY: 1
//          ),
//          compressQuality: 100,
//          maxHeight: 300,
//          maxWidth: 500,
//          compressFormat: ImageCompressFormat.jpg,
//          androidUiSettings: AndroidUiSettings(
//            toolbarColor: Colors.deepOrange,
//            toolbarTitle: "Cropper",
//            statusBarColor: Colors.deepOrange.shade900,
//            backgroundColor: Colors.white,
//          )
//      );
//
//      this.setState((){
//        if(cropped!=null) {
//
//
//
//          _requisitionNidFront = cropped??_requisitionNidFront;
//          error='Photos are uploading. Please wait a moment';
//          uploadNidFront();
//          errorNidFront="";
//          _inProcess = false;
//        }else{
//          this.setState((){
//            _inProcess=false;
//          });
//        }
//      });
//    }else{
//      this.setState((){
//        _inProcess=false;
//      });
//    }
//
//  }
//  //nid housingid front end
//
//  //nid housing id back start
//
//
//  uploadNidBack()async{
//    FirebaseUser user=await FirebaseAuth.instance.currentUser();
//
//    StorageReference storageReference = FirebaseStorage.instance
//        .ref()
//        .child('Requisition/Id/${user.uid}${"_"+DateTime.now().toString()+"_back"}${Path.extension(_requisitionNidBack.path)}');
//
//    StorageUploadTask uploadTask = storageReference.putFile(_requisitionNidBack);
//    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
//    print(Path.basename(_requisitionNidBack.path));
//    print('File Uploaded');
//    _requisitionNidUrlBack = (await downloadUrl.ref.getDownloadURL());
//    print(_requisitionNidUrlBack);
//    this.setState(() {
//      errorNidFront='';
//      error='';
//    });
//
//  }
//
//  Widget getNidBack(){
//    if(_requisitionNidBack!=null){
//      return Image.file(
//        _requisitionNidBack,
//        fit: BoxFit.fill,
//      );
//
//    }
//    else{
//      return Image.asset(
//        "assets/images/demo_logo.png",
//        fit: BoxFit.fill,
//      );
//    }
//
//  }
//
//  getNidBackPic() async{
//    this.setState((){
//      _inProcess=true;
//    });
//    File image=await ImagePicker.pickImage(source: ImageSource.camera);
//    if(image!=null){
//      File cropped=await ImageCropper.cropImage(
//          sourcePath: image.path,
//          aspectRatio: CropAspectRatio(
//              ratioX: 1,ratioY: 1
//          ),
//          compressQuality: 100,
//          maxHeight: 300,
//          maxWidth: 500,
//          compressFormat: ImageCompressFormat.jpg,
//          androidUiSettings: AndroidUiSettings(
//            toolbarColor: Colors.deepOrange,
//            toolbarTitle: "Cropper",
//            statusBarColor: Colors.deepOrange.shade900,
//            backgroundColor: Colors.white,
//          )
//      );
//
//      this.setState((){
//        if(cropped!=null) {
//
//
//
//          _requisitionNidBack = cropped??_requisitionNidBack;
//          error='Photos are uploading. Please wait a moment';
//          uploadNidBack();
//          errorNidBack="";
//          _inProcess = false;
//        }
//        else{
//          this.setState((){
//            _inProcess=false;
//          });
//        }
//      });
//    }else{
//      this.setState((){
//        _inProcess=false;
//      });
//    }
//
//  }
//
//
//  //nid housing id back end
//
//
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    double _height=MediaQuery.of(context).size.height;
//    double _width=MediaQuery.of(context).size.width;
//    return Scaffold(
//        backgroundColor: Color(0xFFe6e3e3),
//        body: Stack(
//          children: <Widget>[
//            AnnotatedRegion<SystemUiOverlayStyle>(
//                value: SystemUiOverlayStyle.light,
//                child: GestureDetector(
//                    onTap: () => FocusScope.of(context).unfocus(),
//                    child: Container(
//                        height: MediaQuery.of(context).size.height,
//                        child: SingleChildScrollView(
//                          physics: AlwaysScrollableScrollPhysics(),
//                          padding: EdgeInsets.only(top: 60,right: 40,left: 40,bottom:60),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//
//                              Container(
//
//
//                                  child: Center(
//                                    child: Container(
//                                      height: 120.0,
//                                      width: 120.0,
//
//                                      decoration: BoxDecoration(
//                                        shape: BoxShape.circle,
//                                        color: Colors.grey,
//                                        boxShadow: [
//                                          BoxShadow(
//                                            color: Colors.red,
//
//                                            blurRadius: 6.0,
//                                          ),
//                                        ],
//                                        image: DecorationImage(
//                                          fit: BoxFit.fill,
//                                          image:AssetImage("assets/images/demo_logo.png"),
//                                        ),
//                                      ),
//                                    ),
//                                  )
//                              ),
//                              SizedBox(height: 20,),
//
//                              Container(
//                                child: Center(
//                                  child:  Text(
//                                    'The MCCHS Ltd.',
//                                    style: TextStyle(
//                                      wordSpacing: 2,
//                                      color: Colors.red[800],
//                                      fontFamily: 'OpenSans',
//                                      fontSize: 30.0,
//                                      fontWeight: FontWeight.w600,
//                                    ),
//                                  ),
//                                ),
//                              ),SizedBox(height: 15,),
//
//                              Container(
//                                child: Center(
//                                  child:  Text(
//                                    'Saving Withdrawal Requisition',
//                                    style: TextStyle(
//                                      wordSpacing: 2,
//                                      color: Colors.black,
//                                      fontFamily: 'OpenSans',
//                                      fontSize: 20,
//                                      fontWeight: FontWeight.w400,
//                                    ),
//                                  ),
//                                ),
//                              ),SizedBox(height: 10,),
//                              Divider(
//                                color: Colors.red[800],
//                                indent: 20,
//                                endIndent: 20,
//                                thickness: 1.5,
//                              ),SizedBox(height: 10,),
//                              Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "Please upload your photo ID",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ), Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "(NID/Housing ID/Housing saving book front page)",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ),SizedBox(height: 10,),
//
//                              Container(
//                                child: Center(
//                                    child: GestureDetector(
//                                      onTap:getNidFrontPic ,
//                                      child: Container(
//                                        height: _height/3.7,
//                                        width:_width/1,
//                                        child: getNidFront(),
//
//                                        decoration: BoxDecoration(
//                                          shape: BoxShape.rectangle,
//                                          color: Colors.grey,
//                                          border: Border.all( color: Colors.black45,),
//
//                                        ),
//                                      ),
//                                    )
//                                ),
//                              ),SizedBox(height:3 ,),
//
//                              Text(errorNidFront,
//                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
//                              ),SizedBox(height: 10,),
//
//                              Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "(NID/Housing ID/Housing saving book back page)",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ),SizedBox(height: 10,),
//
//                              Container(
//                                child: Center(
//                                    child: GestureDetector(
//                                      onTap:  getNidBackPic ,
//                                      child: Container(
//                                        height: _height/3.7,
//                                        width:_width/1,
//                                        child: getNidBack() ,
//
//                                        decoration: BoxDecoration(
//                                          shape: BoxShape.rectangle,
//                                          color: Colors.grey,
//                                          border: Border.all( color: Colors.black45,),
//
//
//
//                                        ),
//                                      ),
//
//                                    )
//                                ),
//                              ),
//
//
//                              SizedBox(height: 5,),
//                              Text(errorNidBack,
//                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
//                              ),SizedBox(height: 10,),
//
//                              SizedBox(height: 5,),
//                              Container(
//                                alignment: Alignment.topLeft,
//                                child:  Container(
//                                    padding: EdgeInsets.only(left: 10,top:3 ,right:5,bottom: 3 ),
//                                    width: _width/3,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(10),
//                                        border: Border.all(
//                                          color: Colors.red[800],
//                                        )
//
//                                    ),
//
//                                    alignment: Alignment.topLeft,
//                                    child: GestureDetector(
//                                      onTap: (){
//                                        print("asd");
//
//                                      },
//                                      child: Text(
//                                          "Photo ID sample"
//                                      ),
//                                    )
//
//                                ),
//                              ),
//
//                              SizedBox(height: 30,),
//
//
//
//
//
//
//                              Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "Please upload your cheque front page",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ),SizedBox(height: 10,),
//
//                              Container(
//                                child: Center(
//                                    child: GestureDetector(
//                                      onTap: getChequeFrontPic,
//                                      child: Container(
//                                        height: _height/3.7,
//                                        width:_width/1,
//                                        child: getChequeFront(),
//
//                                        decoration: BoxDecoration(
//                                          shape: BoxShape.rectangle,
//                                          color: Colors.grey,
//                                          border: Border.all( color: Colors.black45,),
//
//
//
//                                        ),
//                                      ),
//                                    )
//                                ),
//                              ),SizedBox(height: 10,),
//                              Text(errorChequeFront,
//                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
//                              ),SizedBox(height: 10,),
//
//
//
//
//                              Container(
//                                alignment: Alignment.center,
//
//
//                                child: Text(
//                                  "Please upload your cheque back page",
//                                  style: TextStyle(
//                                    color: Colors.red[800],
//                                  ),
//                                ),
//
//                              ),SizedBox(height: 10,),
//
//                              Container(
//                                child: Center(
//                                    child: GestureDetector(
//                                      onTap: getChequeBackPic,
//
//                                      child: Container(
//                                        height: _height/3.7,
//                                        width:_width/1,
//                                        child:  getChequeBack() ,
//
//                                        decoration: BoxDecoration(
//                                          shape: BoxShape.rectangle,
//                                          color: Colors.grey,
//                                          border: Border.all( color: Colors.black45,),
//
//
//
//                                        ),
//                                      ),
//                                    )
//                                ),
//                              ),
//                              Text(errorChequeBack,
//                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
//                              ) ,
//
//
//
//
//
//
//
//
//                              SizedBox(height: 5,),
//
//
//
//                              Container(
//                                alignment: Alignment.topLeft,
//                                child:  Container(
//                                    padding: EdgeInsets.only(left: 10,top:3 ,right:5,bottom: 3 ),
//                                    width: _width/3,
//                                    decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(10),
//                                        border: Border.all(
//                                          color: Colors.red[800],
//                                        )
//
//                                    ),
//
//                                    alignment: Alignment.topLeft,
//                                    child: GestureDetector(
//                                      onTap: (){
//                                        print("asd");
//
//                                      },
//                                      child: Text(
//                                          "Cheque sample"
//                                      ),
//                                    )
//
//                                ),
//                              ),SizedBox(height: 30,),
//
//                              Text(error,
//                                style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
//                              ) ,
//
//
//
//                              SizedBox(height: 20,),
//                              Container(
//                                alignment: Alignment.topRight,
//                                child:GestureDetector(
//                                    onTap: GoNextPage,
//                                    child:  Row(
//                                      mainAxisAlignment: MainAxisAlignment.end,
//                                      children: <Widget>[
//                                        Text(
//                                          "Next",
//                                          style: TextStyle(
//
//                                              fontSize: 22,
//                                              color: Colors.black
//
//                                          ),
//                                        ),
//                                        Icon(Icons.arrow_forward_ios,color: Colors.red[800],)
//                                      ],
//                                    )
//
//                                ),
//
//                              ),
//                              SizedBox(height: 20,),
//
//
//
//
//
//                            ],
//
//                          ),
//
//
//                        )
//
//                    )
//
//
//
//
//
//
//                )
//            ),
//
//            (_inProcess)?Container(
//              color: Colors.white,
//              height: MediaQuery.of(context).size.height*0.98,
//              child: Center(
//                child:CircularProgressIndicator() ,
//              ),
//            ):Center()
//
//
//
//          ],
//        )
//    );
//  }
//}
