import 'dart:async';

import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phonecontroller = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              textField(),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width-30,
                child: Row(

                  children: [
                    Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        )
                    ),
                    Container(
                      child: Text('Enter 6-digit OTP',style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                    Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              otpTextField(),
              SizedBox(height: 40,),
              RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Send OTP again in ",style: TextStyle(color: Colors.yellowAccent,fontSize: 16)
                      ),
                      TextSpan(
                        text: "00:$start",style: TextStyle(color: Colors.pinkAccent,fontSize: 16)
                      ),
                      TextSpan(
                          text: " sec ",style: TextStyle(color: Colors.yellowAccent,fontSize: 16)
                      )
                    ]
                  )
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  authClass.signInWithPhoneNumber(verificationIdFinal, smsCode, context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffff9601),
                  ),
                  child: Center(
                    child: Text('Lets Go',style: TextStyle(color: Colors.white,fontSize: 17),),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
  void startTimer(){
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if(start==0){
        setState(() {
          timer.cancel();
          wait=false;
        });
      }else{
        setState(() {
          start--;
        });
      }
    });
  }
  Widget otpTextField(){
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        borderColor: Colors.white,
        backgroundColor: Color(0xff1d1d1d)
      ),
      style: TextStyle(
          fontSize: 17,
        color: Colors.white
      ),

      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }
  Widget textField(){
    return Container(
      width: MediaQuery.of(context).size.width-40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        controller: phonecontroller,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,

        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(

          border: InputBorder.none,
            hintText: "Enter your phone number",

          hintStyle: TextStyle(fontSize: 17,color: Colors.white),
          contentPadding: const EdgeInsets.symmetric(vertical: 19,horizontal: 8),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
            child: Text("(+880)",style: TextStyle(color: Colors.white,fontSize: 17),),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
            child: InkWell(
                onTap: wait? null : ()async{
                  startTimer();
                  setState(() {
                    start = 30;
                    wait = true;
                    buttonName = "Resend";
                  });
                  await authClass.verifyphonenumber("+880 ${phonecontroller.text}", context, setData);
                },
                child: Text(buttonName,style: TextStyle( color: wait? Colors.grey : Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)),
          ),


        ),

      ),
    );
  }
  void setData(verificationId){
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
