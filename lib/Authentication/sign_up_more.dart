import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcchs/Authentication/sharedwidget/loading.dart';
import 'package:mcchs/Services/auth.dart';
import 'package:path/path.dart' as Path;
import 'login_page.dart';

class sign_up_more extends StatefulWidget {
  String _email,_password,_name,_phone,_dateofbirth,_address,_houseSavingNumber;

  sign_up_more(this._email,this._password, this._name, this._phone,this._dateofbirth, this._address, this._houseSavingNumber);

  @override
  _sign_up_moreState createState() => _sign_up_moreState();
}

class _sign_up_moreState extends State<sign_up_more> {
  AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();
  String error="";
  String errornid="";
  String errornidBack="";
  String uploaderror='';
  File _selectedNidorhouseid;
  File _selectedNidorhouseidBack;
  File _selectedUserPhoto;
  String _userPhotoUrl,_userNidUrl,_userNidBackUrl;
  bool _inProcess=false;
  bool loading=false;

  goSignUp()async{
    if(_selectedUserPhoto!=null&&_selectedNidorhouseid!=null&&_selectedNidorhouseidBack!=null){
      if(_userPhotoUrl==null){

        setState(() {
          uploaderror="Please wait photo is uploading";

        });
      }else if(_userNidUrl==null){
        setState(() {
          uploaderror="Please wait photo is uploading";

        });
      }
      else if(_userNidBackUrl==null){
        setState(() {
          uploaderror="Please wait photo is uploading";

        });
      }

      else if(_userNidUrl!=null&&_userPhotoUrl!=null&&_userNidBackUrl!=null){

        //regiester


        setState(() {
          loading=true;
        });
        dynamic result;
        try {
          result = await _auth.Register(
              widget._email,widget._password,
              widget._name, widget._phone,
              widget._dateofbirth, widget._address,
              widget._houseSavingNumber,_userPhotoUrl,_userNidUrl,_userNidBackUrl
          );
        }
        catch(e){
          error=e;
        }
        if (result==null){
          setState(() {
            loading=false;
            error="please enter a valid email";
          });

        }
        else{
          loading=false;
          Navigator.of(context).pushReplacementNamed('/Verify_OTP');



        }

      }



    }
    else if(_selectedUserPhoto==null&&_selectedNidorhouseid==null&&_selectedNidorhouseidBack==null){
     setState(() {
       error="Please Attach your photo";
       errornid="Please Attach a Nid or Housing Id";
       errornidBack='Please Attach a Nid or Housing Id back';
     });
    }
    else if(_selectedUserPhoto!=null&&_selectedNidorhouseid==null){
      setState(() {
        error="";
        errornid="Please Attach a Nid or Housing Id";
        if(_selectedNidorhouseidBack==null){
          errornidBack="Please Attach a Nid or Housing Id back'";
        }
        else if(_selectedNidorhouseidBack!=null){
          errornidBack="";
        }
      });
    }
    else if(_selectedUserPhoto==null&&_selectedNidorhouseid!=null){
      setState(() {
        error="Please Attach your photo";
        errornid="";

        if(_selectedNidorhouseidBack==null){
          errornidBack="Please Attach a Nid or Housing Id back'";
        }
        else if(_selectedNidorhouseidBack!=null){
          errornidBack="";
        }
      });
    }
  }

  //upload




//profile pic
  uploadPhoto()async{
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pic/${widget._email}${Path.extension(_selectedUserPhoto.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(_selectedUserPhoto);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    print(Path.basename(_selectedUserPhoto.path));
    print('File Uploaded');
    _userPhotoUrl = (await downloadUrl.ref.getDownloadURL());
    print(_userPhotoUrl);

  }

  Widget getUserImage(){
    if(_selectedUserPhoto!=null){
      return Image.file(
        _selectedUserPhoto,
        fit: BoxFit.fill,
      );

    }
    else{
      return Image.asset(
        "assets/images/demo_logo.png",
        fit: BoxFit.fill,
      );
    }

  }

  getImage() async{
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
        compressQuality: 100,
        maxHeight: 300,
        maxWidth: 500,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarTitle: "Cropper",
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
        )
      );

      this.setState((){
        if(cropped!=null) {



          _selectedUserPhoto = cropped??_selectedUserPhoto;

          uploadPhoto();
          error="";
          _inProcess = false;
        }
      });
    }else{
      this.setState((){
        _inProcess=false;
      });
    }

  }


  //profile pic ends


  //pic nid
  uploadNidorhousingid()async{

      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('NId_or_HousingID/${widget._email}${Path.extension(_selectedNidorhouseid.path)}');

      StorageUploadTask uploadTask = storageReference.putFile(_selectedNidorhouseid);
      final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
      print(Path.basename(_selectedNidorhouseid.path));
      print('File Uploaded');
      _userNidUrl = (await downloadUrl.ref.getDownloadURL());
      print(_userNidUrl);
      this.setState(() {

        uploaderror="Photo uploaded press sign up";
      });


  }


  Widget getuserNidorHouseId(){
    if(_selectedNidorhouseid!=null){
      return Image.file(
        _selectedNidorhouseid,
        fit: BoxFit.fill,
      );

    }
    else{
      return Image.asset(
        "assets/images/demo_logo.png",
        fit: BoxFit.fill,
      );
    }

  }


  getNidorHouseIdImage() async{
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
          compressQuality: 100,
          maxHeight: 400,
          maxWidth: 600,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );

      this.setState((){
        if(cropped!=null) {
          _selectedNidorhouseid = cropped ?? _selectedNidorhouseid;
          uploadNidorhousingid();
          errornid='';
          _inProcess = false;
        }
      });
    }else{
      this.setState((){
        _inProcess=false;
      });
    }

  }



  //back


  uploadNidorhousingidBack()async{

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('NId_or_HousingID/${widget._email}back${Path.extension(_selectedNidorhouseidBack.path)}');

    StorageUploadTask uploadTask = storageReference.putFile(_selectedNidorhouseidBack);
    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    print(Path.basename(_selectedNidorhouseidBack.path));
    print('File Uploaded');
    _userNidBackUrl = (await downloadUrl.ref.getDownloadURL());
    print(_userNidBackUrl);
    this.setState(() {

      uploaderror="Photo uploaded press sign up";
    });


  }



  Widget getuserNidorHouseIdBack(){
    if(_selectedNidorhouseidBack!=null){
      return Image.file(
        _selectedNidorhouseidBack,
        fit: BoxFit.fill,
      );

    }
    else{
      return Image.asset(
        "assets/images/demo_logo.png",
        fit: BoxFit.fill,
      );
    }

  }

  getNidorHouseIdImageBack() async{
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
          compressQuality: 100,
          maxHeight: 400,
          maxWidth: 600,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )
      );

      this.setState((){
        if(cropped!=null) {
          _selectedNidorhouseidBack = cropped ?? _selectedNidorhouseidBack;
          uploadNidorhousingidBack();
          errornidBack='';
          _inProcess = false;
        }
      });
    }else{
      this.setState((){
        _inProcess=false;
      });
    }

  }





  @override
  Widget build(BuildContext context) {
    double _height=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;





    Widget _headline(){

      return  Row(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),alignment: Alignment.centerLeft,


              onPressed: (){
               Navigator.pop(context);
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

     return loading?Loading():Scaffold(
      body: Stack(
        children: <Widget>[
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
                            width: _width,


                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)

                            ),

                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10,),

                                Container(
                                  child: Text("Attach Your Photo",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),

                                Container(
                                  child:GestureDetector(
                                    onTap: getImage,
                                    child:  CircleAvatar(
                                      radius: 85,
                                      backgroundColor: Colors.red[800],
                                      child: ClipOval(
                                          child: SizedBox(
                                            height: 168,
                                            width: 168,
                                            child: getUserImage(),
                                          )
                                      ),

                                    ),
                                  ),

                                ),
                                Text(error,
                                  style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                                ),

                                SizedBox(height: 10,),


                                Container(
                                  child: Text("Attach Your NID / Housing ID Front photo",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10,),
                                Container(
                                  child: GestureDetector(
                                    onTap: getNidorHouseIdImage,
                                    child: Center(
                                      child: Container(
                                        height: _height/4,
                                        width:_width/1.5,
                                        child: getuserNidorHouseId(),

                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          color: Colors.grey,
                                          border: Border.all( color: Color(0xFF9a0202),),


                                        ),
                                      ),
                                    ),
                                  )
                                ),SizedBox(height: 10,),


                                Text(errornid,
                                  style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                                ),SizedBox(height: 10,),


                                Container(
                                  child: Text("Attach Your NID / Housing ID Back photo",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10,),
                                Container(
                                    child: GestureDetector(
                                      onTap: getNidorHouseIdImageBack,
                                      child: Center(
                                        child: Container(
                                          height: _height/4,
                                          width:_width/1.5,
                                          child: getuserNidorHouseIdBack(),

                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.grey,
                                            border: Border.all( color: Color(0xFF9a0202),),


                                          ),
                                        ),
                                      ),
                                    )
                                ),SizedBox(height: 5,),

                                Text(errornidBack,
                                  style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                                ),SizedBox(height: 10,),
                                Text(uploaderror,
                                  style: TextStyle(fontSize: 14,color: Color(0xFF9a0202)),
                                ),


                                SizedBox(height: 30,),








                              ],
                            ),






                          ),
                          SizedBox(height: 30,),

                          Container(
                            child:  MaterialButton(
                              padding: EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
                              onPressed:goSignUp,


                              child: Text("Sign Up",
                                style: TextStyle(

                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Montserrat'
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all( color: Colors.white,),

                                gradient: LinearGradient(

                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                  colors: [

                                    Color(0xFF6349b8),
                                    Color(0xFF993fd9),
                                    Color(0xFFa33fd9),
                                    Color(0xFFc23fd9),
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
            ),
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
//Container(
//child: Center(
//child: Container(
//height: 120.0,
//width: 120.0,
//
//decoration: BoxDecoration(
//shape: BoxShape.circle,
//color: Colors.grey,
//boxShadow: [
//BoxShadow(
//color: Colors.red,
//
//blurRadius: 6.0,
//),
//],
//image: DecorationImage(
//fit: BoxFit.fill,
//image:AssetImage("assets/images/demo_logo.png"),
//),
//),
//),
//),
//)



//widget._email,widget._password,
//widget._name, widget._phone,
//widget._dateofbirth, widget._address,
//widget._houseSavingNumber,_userPhotoUrl,_userNidUrl