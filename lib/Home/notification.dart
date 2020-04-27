import 'package:flutter/material.dart';
import 'package:mcchs/Authentication/sharedwidget/loading.dart';
import 'package:mcchs/Authentication/sharedwidget/messageFromAdmin.dart';
import 'package:mcchs/Services/database_services.dart';

class notification extends StatefulWidget {
  String useruid;
  notification ( this.useruid );
  @override
  _notificationState createState() => _notificationState();


}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {

    first(){
      return StreamBuilder(
        stream:DatabaseService().requisitionrequestlist,
        builder: (context,snapshot){
          if(snapshot.hasData) {


            return Container(
              child: ListView.separated(
                  physics: ScrollPhysics(),
                  separatorBuilder: (context,index){
                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='accept'){
                      return Divider(
                        color: Color(0xFF9a0202),
                        thickness: 2,
                      );
                    }
                    else{
                      return SizedBox(height: 5,);
                    }
                  },

                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),

                  itemCount: snapshot.data.length,

                  itemBuilder: (BuildContext context, int index) {

                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='accept'

                    ){
                      //block for depeartment head
                      return ListTile(



                        title: Text("Request status : "+snapshot.data[index].requestStatus


                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Transection request by :"+snapshot.data[index].transectionType


                            ),
                            Text("Message From Admin:"+snapshot.data[index].adminMsg


                            ),



                          ],
                        ),
                        onTap: (){
                          print(snapshot.data[index].runtimeType);
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>messageFromadmin(snapshot.data[index])),
                          );

                        },
                        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),



                      );

                    }


                    else{
                      return SizedBox();
                    }

                  }
              ),


            );


          }
          else{
            return Loading();
          }
        },
      );
    }


    second(){
      return StreamBuilder(
        stream:DatabaseService().requisitionrequestlist,
        builder: (context,snapshot){
          if(snapshot.hasData) {


            return Container(
              child: ListView.separated(
                  physics: ScrollPhysics(),
                  separatorBuilder: (context,index){
                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='pending'){
                      return Divider(
                        color: Color(0xFF9a0202),
                        thickness: 2,
                      );
                    }
                    else{
                      return SizedBox(height: 5,);
                    }
                  },

                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),

                  itemCount: snapshot.data.length,

                  itemBuilder: (BuildContext context, int index) {

                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='pending'

                    ){
                      //block for depeartment head
                      return ListTile(

                        title: Text("Request statue : "+snapshot.data[index].requestStatus
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Transection request by :"+snapshot.data[index].transectionType
                            ),

                          ],
                        ),
                        onTap: (){

                          print(snapshot.data[index].runtimeType);

                        },
                        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),



                      );

                    }


                    else{
                      return SizedBox();
                    }

                  }
              ),


            );


          }
          else{
            return Loading();
          }
        },
      );
    }

    third(){
      return StreamBuilder(
        stream:DatabaseService().requisitionrequestlist,
        builder: (context,snapshot){
          if(snapshot.hasData) {


            return Container(
              child: ListView.separated(
                  physics: ScrollPhysics(),

                  shrinkWrap: true,
                  primary: true,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  separatorBuilder: (context,index){
                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='reject'){
                      return Divider(
                        color: Color(0xFF9a0202),
                        thickness: 2,
                      );
                    }
                    else{
                      return SizedBox(height: 5,);
                    }
                  },
                  itemCount: snapshot.data.length,

                  itemBuilder: (BuildContext context, int index) {

                    if(snapshot.data[index].userId==widget.useruid&&
                        snapshot.data[index].requestStatus=='reject'

                    ){
                      //block for depeartment head
                      return ListTile(

                        title: Text("Request statue : "+snapshot.data[index].requestStatus
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Transection request by :"+snapshot.data[index].transectionType


                            ),
                            Text("Message From Admin:"+snapshot.data[index].adminMsg


                            ),




                          ],
                        ),
                        onTap: (){
                          print(snapshot.data[index].runtimeType);


                        },
                        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),



                      );

                    }


                    else{
                      return SizedBox();
                    }

                  }
              ),


            );


          }
          else{
            return Loading();
          }
        },
      );
    }

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: DefaultTabController(
            length: 3,
            child:Scaffold(

              //resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  title: Center(
                    child: Text("Notification"),
                  ),
                  backgroundColor: Colors.green,
                  automaticallyImplyLeading: true,
                  actions: <Widget>[
                  ],

                  bottom: TabBar(
                    labelColor: Colors.black,
                    indicatorPadding: EdgeInsets.only(top: 20),
                    unselectedLabelColor: Colors.grey,
                    labelPadding: EdgeInsets.only(bottom: 10),

                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.green

                    ),

                    tabs: <Widget>[

                      Text("Accepted",),
                      Text("Pending"),
                      Text("Rejected")
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    first(),
                    second(),
                    third()
                  ],
                )
            )
        )
    );
  }
}
