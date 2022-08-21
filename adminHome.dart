import 'package:cse_ccnust/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('assets/logo1.png',height: 200,width: 200,),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-90,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(child: Text('All Posts',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-90,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(child: Text('All Adds',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width-90,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(child: Text('All Users',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),

              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: ()async{
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignIn()), (route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-90,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text('Logout',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
