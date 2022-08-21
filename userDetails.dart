import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool circular = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _validateName = false;
  bool _validateAddress= false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(

                  child: Image.asset('assets/logo.jpg',height: 220,width: 220,) ,
                ),
              inputField('Enter your name here',_nameController,_validateName),
              SizedBox(height: 20,),
              inputField('Enter your address here',_addressController,_validateAddress),
              SizedBox(height: 25,),
              colorButton(),


            ],
          ),
        ),
      ),
    );
  }
  Widget inputField(String labelText,TextEditingController controller,bool validate){
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width-70,
        
        child: TextField(
          controller: controller,
          style: TextStyle(

            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
          decoration: InputDecoration(

            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 19,


            ),
            errorText: validate? 'Firld must not be empty': null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 1
              )
            )
          ),

        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: (){


        setState(() {
          _nameController.text.isEmpty? _validateName=true: _validateName=false;
          _addressController.text.isEmpty? _validateAddress=true: _validateAddress=false;
        });
        if(_nameController.text.isNotEmpty && _addressController.text.isNotEmpty){
          setState(() {
            circular = true;
          });
          FirebaseAuth auth = FirebaseAuth.instance;
          String uid = auth.currentUser!.uid.toString();
          String email = auth.currentUser!.email.toString();
          String phone = auth.currentUser!.phoneNumber.toString();
          FirebaseFirestore.instance.collection("users").doc(uid).set({
            'name': _nameController.text,
            'address': _addressController.text,
            'uid': uid.toString(),
            'email': email.toString(),
            'phone': phone.toString()
          });

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);
          setState(() {
            circular = false;
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
          child: circular? CircularProgressIndicator(): Text('Save Info',style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
}
