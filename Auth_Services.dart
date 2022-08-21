import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/Pages/adminHome.dart';
import 'package:cse_ccnust/Pages/userDetails.dart';
import 'package:cse_ccnust/homePage.dart';
import 'package:cse_ccnust/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class AuthClass{
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  Future<void> googleSignIn(BuildContext context)async{
    try{
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount.authentication;

        AuthCredential credential= GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential= await auth.signInWithCredential(credential);
          storeTokenAndData(userCredential);

          //check whether the user is new or not
          FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
          String _uid = _auth.currentUser!.uid.toString();
          FirebaseFirestore.instance.collection("users").doc(_uid).get().then((DocumentSnapshot documentSnapshot)  {
            if(documentSnapshot.exists){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
              showSnackBar(context, "Welcome to KI KHABO");
            }else{
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>UserDetails()), (route) => false);
              showSnackBar(context, "Please fill your info");
            }


          });
          // FirebaseFirestore.instance.collection("users").doc(_uid).get().then((DocumentSnapshot documentSnapshot)  {
          //   if(documentSnapshot.exists){
          //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
          //     showSnackBar(context, "Welcome to KI KHABO");
          //   }else{
          //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>UserDetails()), (route) => false);
          //     showSnackBar(context, "Please fill your info");
          //   }




        }catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }else{
        final snackbar = SnackBar(content: Text('Not able to sign up'));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }

    }catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  // Future<void> emailSignIn(String email, String Password,BuildContext context)async{
  //   try{
  //     // firebase_auth.UserCredential credential=await firebaseAuth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
  //     // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
  //     UserCredential userCredential = await firebase_auth.FirebaseAuth.instance.signInAnonymously();
  //     AuthCredential credential= EmailAuthProvider.credential(
  //        email: 'email',
  //       password: 'Password',
  //     );
  //     storeTokenAndData(userCredential);
  //
  //     FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  //     String _uid = _auth.currentUser!.uid.toString();
  //     FirebaseFirestore.instance.collection("users").doc().where('email',isEqualTo: 'admin@gmail.com').get().then((DocumentSnapshot documentSnapshot)  {
  //       if(documentSnapshot.exists){
  //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>AdminHome()), (route) => false);
  //         showSnackBar(context, "Welcome to KI KHABO");
  //       }else{
  //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
  //         showSnackBar(context, "Please fill your info");
  //       }
  //
  //
  //     });
  //
  //   }catch(e){
  //
  //   }
  // }
  Future storeTokenAndData(UserCredential userCredential)async{
    await storage.write(key: "token", value: userCredential.credential!.token.toString());
    await storage.write(key: "userCredential", value: userCredential.credential.toString());


  }
  Future<String?> getToken()async{
    return await storage.read(key: "token");
  }
  Future<void> logout()async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    }catch(e){

    }
  }
  Future<void> verifyphonenumber(String phoneNumber, BuildContext context,Function setData)async{

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential)async{
          showSnackBar(context, "Verification Completed");
        };
    PhoneVerificationFailed verificationFailed=(FirebaseException exception){
      showSnackBar(context, exception.toString());
    };
    PhoneCodeSent codeSent=(String verificationId, [int? forceResendingtoken]){
      showSnackBar(context, "Verification code send on the number");
      setData(verificationId);
    } as PhoneCodeSent;
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId){
      showSnackBar(context, "Timeout");
    };
    try{
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }catch(e){
      showSnackBar(context, e.toString());
    }
}
void signInWithPhoneNumber(String verificationId,String smsCode,BuildContext context)async{
    try{

      AuthCredential credential = PhoneAuthProvider.credential(

          verificationId: verificationId,
          smsCode: smsCode,
      );


      try{
        UserCredential userCredential= await auth.signInWithCredential(credential);
        storeTokenAndData(userCredential);

        //Check whether the user is new or not
        FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
        String _uid = _auth.currentUser!.uid.toString();
        FirebaseFirestore.instance.collection("users").doc(_uid).get().then((DocumentSnapshot documentSnapshot)  {
          if(documentSnapshot.exists){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
            showSnackBar(context, "Welcome to KI KHABO");
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>UserDetails()), (route) => false);
            showSnackBar(context, "Please fill your info");
          }


        });

      }catch(e){
        final snackbar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }



    }catch(e){
      showSnackBar(context, e.toString());
    }

}
void showSnackBar(BuildContext context,String text){
  final snackbar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
}