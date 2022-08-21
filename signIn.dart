import 'package:cse_ccnust/Pages/adminHome.dart';
import 'package:cse_ccnust/homePage.dart';
import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:cse_ccnust/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool circular = false;
  AuthClass authClass= AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Admin Panel',style: TextStyle(color: Colors.white,fontSize: 34.0,fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 20,),
              ButtonItem("assets/google.svg",'Connect with google',
                  ()async{
                    await authClass.googleSignIn(context);
                  }
              ),
              SizedBox(height: 10,),
              ButtonItem("assets/phone.svg",'Connect with phone',(){}),
              SizedBox(height: 10,),
              Text('or',style: TextStyle(color: Colors.white,fontSize: 20),),
              SizedBox(height: 10,),
              inputField('Email...',false,_email),
              SizedBox(height: 10,),
              inputField('Password',true,_password),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not an admin?',style: TextStyle(color: Colors.white,fontSize: 18),),
                  InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUp()), (route) => false);
                      },
                      child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 10,),

                ],
              ),
              Text('Welcome as Admin',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),

            ],

          ),
        ),
      ),
    );
  }
  Widget ButtonItem(String btnimage, String btntext,void Function() onTap){
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width-60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                  width: 1.0,
                  color: Colors.grey
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(btnimage,height: 25,width: 25,),
              SizedBox(width: 10,),
              Text(btntext,style: TextStyle(color: Colors.white,fontSize: 17),)
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(String labeltext,bool obscuretext, TextEditingController controller){
    return Container(
      width: MediaQuery.of(context).size.width-70,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        obscureText: obscuretext,
        decoration: InputDecoration(

            labelText: labeltext,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.amber
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey
                )
            )
        ),
      ),
    );
  }
  Widget colorButton(){
    return InkWell(
      onTap: ()async{
        setState(() {
          circular = true;
        });
        try{
          firebase_auth.UserCredential credential=await firebaseAuth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
          //await authClass.emailSignIn(_email.text, _password.text,context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>AdminHome()), (route) => false);

          // Future<firebase_auth.UserCredential> userCredential = firebase_auth.FirebaseAuth.instance.signInAnonymously();
          setState(() {
            circular=false;
          });
        }
        catch(e){
          final snackbar = SnackBar(content: Text("User name or password error"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular=false;
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [Color(0xfffd746c),Color(0xffff9068),Color(0xfffd746c)]
          ),

        ),
        child: Center(
          child: circular? CircularProgressIndicator() : Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
