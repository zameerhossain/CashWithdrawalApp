
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:mcchs/models/requisition_list.dart';

import 'PopUpMenuBar.dart';
class messageFromadmin extends StatelessWidget {
  requisitionList data;
  messageFromadmin(this.data);




  @override
  Widget build(BuildContext context) {



//    List <String> menu=[
//       a='a',b='Notification',signout='SignOut'
//
//    ];
    double _height = MediaQuery.of(context).size.height;
    double _weight = MediaQuery.of(context).size.width;


    Widget _eventNews(_image_path,_headline){

      return Column(



        crossAxisAlignment: CrossAxisAlignment.start,


        children: <Widget>[


          Container(
            height: _height/2.2,
            width: _weight,
            margin: EdgeInsets.only(left: 20,top: 5,right: 20,bottom: 5),
            child: Image(
                fit: BoxFit.fill,

                image: CacheImage(_image_path)
            ),



//            child: CachedNetworkImage(
//              imageUrl: _image_path,
//              imageBuilder: (context, imageProvider) => Container(
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: imageProvider,
//                      fit: BoxFit.fill,
//                     ),
//                ),
//              ),
//              placeholder: (context, url) => CircularProgressIndicator(),
//              errorWidget: (context, url, error) => Icon(Icons.error),
//            ),


//
//            child:Image.network(
//              "https://firebasestorage.googleapis.com/v0/b/leavemanagement-e7987.appspot.com/o/demo.png?alt=media&token=cd5398bd-b339-45d0-9bf2-8e76fa4a6044",
//              fit: BoxFit.contain,
//            ),
//


//              child: Image.asset(_image_path,
//                fit: BoxFit.contain,),



            //Image.network("https://firebasestorage.googleapis.com/v0/b/leavemanagement-e7987.appspot.com/o/alpha.jpg?alt=media&token=6c9eeba2-86d5-4c9c-9822-e35e3c35e036")


            decoration: BoxDecoration(
//              image: DecorationImage(
//                fit: BoxFit.fill,
//                image: NetworkImage("https://images.app.goo.gl/z6J9Bt4gcxxNaAPq6"),
//              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: Color(0xFF9a0202),style: BorderStyle.solid
              ),

            ),


          ),SizedBox(height: 10,),

          Container(
            margin: EdgeInsets.only(left: 20,top: 5,right: 20,bottom: 5),

            child: Text(_headline,
              //textAlign: TextAlign.start,
              style: TextStyle(

                fontSize: 15,

                fontWeight: FontWeight.bold,

              ),
            ),
          ),

        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: true,


          actions: <Widget>[

            CustomePopUPmenu(),
//         PopupMenuButton(
//           icon: Icon(Icons.menu,size: 35,),padding:EdgeInsets.only(left:40,right: 40),
//           onSelected: CustomeMenuChoice().choiceact,
//
//
//
//           itemBuilder: (BuildContext context){
//             return CustomeMenuItem.choices.map((String Choice){
//               return PopupMenuItem<String>(
//
//                 value: Choice,
//                 child: Text(Choice),
//
//               );
//               }).toList();
//           },
//
//          )
          ],

        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,



          children: <Widget>[
            _eventNews(data.adminPic,data.adminMsg),

          ],
        )
    );
  }
//void choiceact(String choice) async{
//    if(choice==CustomeMenuItem.Notificationpage){
//      print("notification");
//    }
//    else if(choice==CustomeMenuItem.SignOut){
//      await _auth.signOut();
//
//    }
//
//}
}

