import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcchs/Authentication/sharedwidget/constant.dart';
import 'package:mcchs/Requisition/requisition_nid_check.dart';
import 'package:mcchs/Requisition/requisition_upload_photo.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:intl/intl.dart';
class requisition_details extends StatefulWidget {
  @override
  _requisition_detailsState createState() => _requisition_detailsState();
}

class _requisition_detailsState extends State<requisition_details> {
  final _formKey = GlobalKey<FormState>();
  String error="";
  String _name,_fatherName,_phone,_dateOFBirth,_housingnumber,_address;


  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:DateTime(1950),
        firstDate: DateTime(1900),
        lastDate: DateTime(2020));
    if (picked != null && picked != selectedDate)
      setState(() {
        _dateOFBirth=DateFormat('dd-MM-yyyy').format(picked);
        _date.value = TextEditingValue(text: _dateOFBirth);
        if(_dateOFBirth!=null){
          error='';
        }

      });
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
     backgroundColor: Color(0xFFe6e3e3),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
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
                      padding: EdgeInsets.only(top: 60,right: 25,left: 25,bottom:60),
                      child: Form(
                        key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                indent: 30,
                                endIndent: 20,
                                thickness: 1.5,
                              ),SizedBox(height: 10,),
                              //User name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(

                                    alignment: Alignment.centerLeft,

                                    padding: EdgeInsets.only(left: 10,right: 10),

                                    child: TextFormField(
                                      validator: (val)=>val.isEmpty?"Enter your name":null,
                                      onChanged: (val)=>_name=val,


                                      style: TextStyle(
                                        color: Colors.black,

                                      ),
                                      decoration: InputDecoration(


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


                              //Father name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(

                                    alignment: Alignment.centerLeft,

                                    padding: EdgeInsets.only(left: 10,right: 10),

                                    child: TextFormField(
                                      onChanged: (val)=>_fatherName=val,

                                      validator: (val)=>val.isEmpty?"Enter your father name":null,

                                      style: TextStyle(
                                        color: Colors.black,

                                      ),
                                      decoration: InputDecoration(


                                        contentPadding: EdgeInsets.only(top: 14.0),
                                        prefixIcon: Icon(
                                          Icons.perm_contact_calendar,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Father Name',
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
                                      validator: (value) =>validator.phone(value)&&value.length==11 ?null:"Please Enter a Valid Phone Number",

                                      onChanged: (val)=>_phone=val,


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
                                    child: GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: AbsorbPointer(

                                        child: TextFormField(

                                          controller: _date,

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

                                    )
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                alignment: Alignment.topLeft,
                                child: Text(error,
                                  style: TextStyle(fontSize: 12,color: Colors.red[800]),
                                ),
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
                                      onChanged: (val)=>_housingnumber=val,

                                      validator: (val)=>val.isEmpty? "Enter your Housing Saving number":null,

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





                              //address

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  SizedBox(height: 10.0),
                                  Container(
                                    alignment: Alignment.centerLeft,


                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: TextFormField(

                                      validator: (val)=>val.isEmpty? "Enter your address":null,
                                      onChanged: (val)=>_address=val,

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
                              SizedBox(height: 20,),
                              Container(
                                alignment: Alignment.topRight,
                                child:GestureDetector(
                                    onTap: (){
                                        if(_formKey.currentState.validate()&&_dateOFBirth!=null) {
//                                          Navigator.push(context,
//                                            MaterialPageRoute(builder: (context) => requisition_nid_check(_name,_fatherName,
//                                                _phone,_dateOFBirth,_housingnumber,_address))
//                                          );
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => reqisition_upload_photo(_name,_fatherName,
                                                  _phone,_dateOFBirth,_housingnumber,_address))
                                          );


                                        }
                                        if(_dateOFBirth==null){
                                          setState(() {
                                            error="Enter your date of birth";
                                          });
                                        }
                                    },
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "Next",
                                          style: TextStyle(

                                              fontSize: 22,
                                              color: Colors.black

                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios,color: Colors.red[800],)
                                      ],
                                    )

                                ),

                              ),

                              SizedBox(height: 20,),





                            ],

                          ),



                      )


                  )

                  )






            )
        )
  );
  }
}
