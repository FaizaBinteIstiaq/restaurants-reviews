import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:cse_ccnust/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  //const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {




    Future<List<DocumentSnapshot>> getInfo()async{
      FirebaseAuth auth = FirebaseAuth.instance;
      String uid = auth.currentUser!.uid.toString();
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await firestore.collection('users').where('uid', isEqualTo: uid).get();
      return qn.docs;
    }


    return Scaffold(
      body: Container(

        height: MediaQuery.of(context).size.height,

        padding: EdgeInsets.only(top: 50.0),
        child: Stack(
            children:<Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: getInfo(),
                    builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot){
                      if(!snapshot.hasData){
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (_,index){
                            DocumentSnapshot data = snapshot.data![index];

                            return Container(
                              margin: EdgeInsets.only(top:100.0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFE92C),
                              ),
                              child: Column(children:<Widget> [
                                Container(
                                  padding: EdgeInsets.only(top: 80.0,left: 20.0,right: 20.0),
                                  child: Column(children: <Widget> [
                                    SizedBox(height: 30.0,),

                                    TextField(
                                      enabled: false,

                                      decoration: InputDecoration(
                                        labelText: data['name'],
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 21,

                                        ),
                                        prefixIcon: Icon(Icons.person),
                                        border: myInputBorder(),
                                        enabledBorder: myInputBorder(),
                                        focusedBorder: myFocusBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0,),
                                    TextField(
                                      enabled: false,

                                      decoration: InputDecoration(
                                        labelText: data['phone'].toString()=='null'? 'Not yet added': data['phone'],
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 21,

                                        ),
                                        prefixIcon: Icon(Icons.phone),
                                        border: myInputBorder(),
                                        enabledBorder: myInputBorder(),
                                        focusedBorder: myFocusBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0,),
                                    TextField(
                                      enabled: false,

                                      decoration: InputDecoration(
                                        labelText: data['email'].toString()=='null'? 'Not yet added': data['email'],
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 21,

                                        ),
                                        prefixIcon: Icon(Icons.mail),
                                        border: myInputBorder(),
                                        enabledBorder: myInputBorder(),
                                        focusedBorder: myFocusBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0,),
                                    TextField(
                                      enabled: false,

                                      decoration: InputDecoration(
                                        labelText: data['address'],
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 21,

                                        ),
                                        prefixIcon: Icon(Icons.location_city),
                                        border: myInputBorder(),
                                        enabledBorder: myInputBorder(),
                                        focusedBorder: myFocusBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 20.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: ()async{
                                        AuthClass authClass= AuthClass();
                                        await authClass.logout();
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUp()), (route) => false);

                                      },
                                      child: Text('Log Out'),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.orange,
                                          padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20.0),
                                          textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
                                      ),
                                    )
                                  ],),
                                )
                              ],),
                            );
                          },
                      );
                    }),
              ),
              // Container(
              //   margin: EdgeInsets.only(top:100.0),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height,
              //   decoration: BoxDecoration(
              //     color: Color(0xFFFFE92C),
              //   ),
              //
              //   child: Column(children:<Widget> [
              //     Container(
              //       padding: EdgeInsets.only(top: 80.0,left: 20.0,right: 20.0),
              //       child: Column(children: <Widget> [
              //         SizedBox(height: 30.0,),
              //
              //         TextField(
              //           controller: username,
              //           decoration: InputDecoration(
              //             labelText: 'Username',
              //             prefixIcon: Icon(Icons.person),
              //             border: myInputBorder(),
              //             enabledBorder: myInputBorder(),
              //             focusedBorder: myFocusBorder(),
              //           ),
              //         ),
              //         SizedBox(height: 20.0,),
              //         TextField(
              //           controller: phonenumber,
              //           decoration: InputDecoration(
              //             labelText: 'Phone Number',
              //             prefixIcon: Icon(Icons.phone),
              //             border: myInputBorder(),
              //             enabledBorder: myInputBorder(),
              //             focusedBorder: myFocusBorder(),
              //           ),
              //         ),
              //         SizedBox(height: 20.0,),
              //         TextField(
              //           controller: email,
              //           decoration: InputDecoration(
              //             labelText: 'Email',
              //             prefixIcon: Icon(Icons.mail),
              //             border: myInputBorder(),
              //             enabledBorder: myInputBorder(),
              //             focusedBorder: myFocusBorder(),
              //           ),
              //         ),
              //         SizedBox(height: 20.0,),
              //         TextField(
              //           controller: address,
              //           decoration: InputDecoration(
              //             labelText: 'Address',
              //             prefixIcon: Icon(Icons.location_city),
              //             border: myInputBorder(),
              //             enabledBorder: myInputBorder(),
              //             focusedBorder: myFocusBorder(),
              //           ),
              //         ),
              //         SizedBox(height: 20.0,
              //         ),
              //         ElevatedButton(
              //           onPressed: ()async{
              //               AuthClass authClass= AuthClass();
              //               await authClass.logout();
              //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUp()), (route) => false);
              //
              //           },
              //           child: Text('Log Out'),
              //           style: ElevatedButton.styleFrom(
              //               primary: Colors.orange,
              //               padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 20.0),
              //               textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)
              //           ),
              //         )
              //       ],),
              //     )
              //   ],),
              // ),
               Align(
                alignment:Alignment.topCenter,
                child: Stack(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset('assets/logo.jpg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 15.0,
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.orange, shape: BoxShape.circle
                          ),
                          child: Icon(Icons.edit,size:25.0,)),
                    )
                  ],
                ),
              ),
            ] ),
      ),
    );
  }
  OutlineInputBorder myInputBorder(){
    return OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.black,
          width: 3,
        ));
  }
  OutlineInputBorder myFocusBorder(){
    return OutlineInputBorder(
        borderRadius:BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color:Colors.black,
          width: 3,
        ));
  }
}
