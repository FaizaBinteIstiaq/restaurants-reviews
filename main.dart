
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/Pages/adminHome.dart';
import 'package:cse_ccnust/Pages/userDetails.dart';
import 'package:cse_ccnust/homePage.dart';
import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:cse_ccnust/signIn.dart';
import 'package:cse_ccnust/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MaterialApp(home: AnimatedSplashScreen(
    splash: Container(

      child: Image.asset('assets/logo.jpg'),
    ),
    splashIconSize: 500,
    duration: 3000,
    backgroundColor: Colors.yellow,
    splashTransition: SplashTransition.fadeTransition,
    nextScreen: myApp(),
  ),
  debugShowCheckedModeBanner: false,
  ));
}
class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  Widget currentLogInPage = SignUp();
  AuthClass authClass = AuthClass();
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }
  void checkLogin()async{
    String? token = await authClass.getToken();
    if(token!=null){

      FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
      String _uid = auth.currentUser!.uid.toString();
      FirebaseFirestore.instance.collection("users").doc(_uid).get().then((DocumentSnapshot documentSnapshot)  {
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
          if(data.isNotEmpty){
            print(data["email"]);
            if(data["email"]!="admin@gmail.com"){
              setState(() {
                currentLogInPage= HomePage();
              });
            }else{
              setState(() {

                currentLogInPage= AdminHome();
              });
            }


          }else{
            setState(() {
              print(name);
              currentLogInPage= UserDetails();
            });
          }


      });

    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: currentLogInPage,

      ),
    );
  }
}
