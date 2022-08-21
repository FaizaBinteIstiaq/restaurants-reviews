import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/Pages/explorePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ReviewPage extends StatefulWidget {
  //const ReviewPage({Key? key}) : super(key: key);
  var data;
  ReviewPage(this.data);

  @override
  _ReviewPageState createState() => _ReviewPageState(this.data);
}

class _ReviewPageState extends State<ReviewPage> {
  var data;
  _ReviewPageState(this.data);


  
  TextEditingController res_name = TextEditingController();
  TextEditingController res_location = TextEditingController();
  TextEditingController food_name = TextEditingController();
  TextEditingController _price = TextEditingController();
  String _rating = "";
  String _userName =  "";
  String uid = "";
  bool validate_res_name = false;
  bool validate_res_loc = false;
  bool validate_food_name = false;
  bool validate_price = false;
  bool validate_rating = false;
  var now = new DateTime.now().microsecondsSinceEpoch;







  


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo,Colors.indigoAccent]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.white,)
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create',style: TextStyle(color: Colors.white,fontSize: 32,letterSpacing: 4),),
                    SizedBox(height: 8,),
                    Text('Food Review',style: TextStyle(color: Colors.white,fontSize: 32,letterSpacing: 2),),
                    SizedBox(height: 12,),
                    label('Restaurant Name'),
                    SizedBox(height: 12,),
                    title('Name here',TextInputType.text, res_name, validate_res_name),
                    SizedBox(height: 12,),
                    label('Restaurant Location'),
                    SizedBox(height: 12,),
                    title('Location here',TextInputType.text, res_location,validate_res_loc),
                    SizedBox(height: 12,),
                    label('Food Name'),
                    SizedBox(height: 12,),
                    title('Name here',TextInputType.text, food_name,validate_food_name),
                    SizedBox(height: 12,),
                    label('Food Price'),
                    SizedBox(height: 12,),
                    title('Price here',TextInputType.number, _price,validate_price),
                    SizedBox(height: 12,),
                    label('Rating'),
                    SizedBox(height: 12,),
                    Wrap(
                      children: [
                        chipData('0', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('1', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('2', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('3', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('4', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('5', 0xff49111c) ,
                        SizedBox(width: 5,),
                        chipData('6', 0xff278511) ,
                        SizedBox(width: 5,),
                        chipData('7', 0xff278511) ,
                        SizedBox(width: 5,),
                        chipData('8', 0xff278511) ,
                        SizedBox(width: 5,),
                        chipData('9', 0xff278511) ,
                        SizedBox(width: 5,),
                        chipData('10', 0xff278511) ,
                      ],
                    ),
                    SizedBox(height: 12,),
                    label('Division & City'),
                    SizedBox(height: 12,),
                    Wrap(
                      children: [
                        chipLoc(data['zone'],0xff01006a),
                        SizedBox(width: 15,),

                        chipLoc(data['city'],0xff4f0080)
                      ],
                    ),
                    SizedBox(height: 18,),


                    colorButton()




                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget chipData(String chipText,int color){
    return InkWell(
      onTap: (){
        FirebaseAuth auth= FirebaseAuth.instance;
        String _uid = auth.currentUser!.uid.toString();
        FirebaseFirestore.instance.collection('users').doc(_uid).get().then((DocumentSnapshot documentSnapshot) async{
          if(await documentSnapshot.exists){
            setState(() {
              _userName= documentSnapshot['name'].toString();
              uid = _uid;

            });
          }
        });
        setState(() {
          _rating = chipText;

        });
      },
      child: Container(

        color: validate_rating? Colors.red: null,
        child: Chip(
          autofocus: true,
          backgroundColor: _rating==chipText? Colors.white : Color(color),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),

            ),
            label: Text(chipText,style: TextStyle( color: _rating==chipText? Colors.black : Colors.white,fontSize: 17),),
          labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
        ),
      ),
    );
  }
  Widget chipLoc(String chipText,int color){
    return Chip(
      backgroundColor: Color(color),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      label: Text(chipText,style: TextStyle(color: Colors.white,fontSize: 17),),
      labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
    );
  }

  Widget title(String hintText, keyboard, TextEditingController _controller,bool validate){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextField(
        controller: _controller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17
        ),
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          errorText: validate? '*Field must not be empty': null,

          errorStyle:  TextStyle(
            color: Colors.red
          ),
          contentPadding: EdgeInsets.only(left: 20,right: 20)
        ),
      ),
    );
  }
  Widget label(String labelText){
    return Text(
      labelText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2
      ),
    );
  }
  Widget colorButton(){
    return InkWell(
      onTap: (){


          setState(() {
            res_name.text.isEmpty? validate_res_name=true: validate_res_name=false;
            res_location.text.isEmpty? validate_res_loc=true : validate_res_loc=false;
            food_name.text.isEmpty? validate_food_name=true: validate_food_name=false;
            _price.text.isEmpty? validate_price= true: validate_price=false;
            _rating.isEmpty? validate_rating=true: validate_rating=false;
          });




        if(res_name.text.isNotEmpty && res_location.text.isNotEmpty && food_name.text.isNotEmpty && _price.text.isNotEmpty && _rating.isNotEmpty){



          FirebaseFirestore.instance.collection('Review').add({
            'res_name': res_name.text,
            'res_location':res_location.text,
            'food_name':food_name.text,
            'price':_price.text,
            'rating': _rating.toString(),
            'division': data['zone'].toString(),
            'city':data['city'].toString(),
            'post_by':_userName.toString(),
            'uid':uid.toString(),
            'date': DateTime.now().day.toString(),
            'month': DateTime.now().month.toString(),
            'year': DateTime.now().year.toString(),
            'createdAt': DateTime.now().microsecondsSinceEpoch

          });
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>ExplorePage(data)));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width-20,

        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [Color(0xfffd746c),Color(0xffff9068),Color(0xfffd746c)]
          ),

        ),
        child:  Center(
          child:  Text('Submit Review',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

}
