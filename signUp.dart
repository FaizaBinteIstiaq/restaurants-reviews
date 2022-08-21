import 'package:cse_ccnust/PhoneAuthPage.dart';
import 'package:cse_ccnust/homePage.dart';
import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:cse_ccnust/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwdcontroller = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1d1e26),Color(0xff252041)]
            )
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 34.0,fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 20,),
              ButtonItem("assets/google.svg",'Connect with google',
                      ()async{
                await authClass.googleSignIn(context);
              }),
              SizedBox(height: 10,),
              ButtonItem("assets/phone.svg",'Connect with phone',(){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
              }),
              SizedBox(height: 10,),
              Text('or',style: TextStyle(color: Colors.white,fontSize: 20),),
              SizedBox(height: 10,),
              inputField('Email...',false,_emailcontroller),
              SizedBox(height: 10,),
              inputField('Password',true,_pwdcontroller),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Admin of Ki Khabo?',style: TextStyle(color: Colors.white,fontSize: 18),),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
                    },
                      child: Text(' Log In',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                  )
                ],
              )

            ],

          ),
        ),
      ),
    );
  }
  Widget ButtonItem(String btnimage, String btntext,void Function() onTap){
    return InkWell(
      onTap: onTap ,
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

  Widget inputField(String labeltext,bool obscuretext,TextEditingController controller){
    return Container(
      width: MediaQuery.of(context).size.width-70,
      child: TextField(
        enabled: false,
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
          circular=true;
        });
        try{
         firebase_auth.UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: _emailcontroller.text, password: _pwdcontroller.text);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
         setState(() {
           circular=false;
         });
        }
        catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
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
        child:  Center(
          child: circular? CircularProgressIndicator(): Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
