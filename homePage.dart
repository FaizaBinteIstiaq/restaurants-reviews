
import 'package:cse_ccnust/Pages/myPosts.dart';
import 'package:cse_ccnust/Pages/profilePage.dart';
import 'package:cse_ccnust/Pages/reviewPage.dart';
import 'package:cse_ccnust/Zones/chittagongZone.dart';
import 'package:cse_ccnust/services/Auth_Services.dart';
import 'package:cse_ccnust/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass= AuthClass();

  final List barisal = [
    {'city':'Barisal','desc':'Almost 20 restaurant here','zone':'Barisal'},
    {'city':'Barguna','desc':'Almost 30 restaurant here','zone':'Barisal'},
    {'city':'Bhola','desc':'Almost 50 restaurant here','zone':'Barisal'},
    {'city':'Jhalokathi','desc':'Almost 100 restaurant here','zone':'Barisal'},
    {'city':'Patuakhali,','desc':'Almost 40 restaurant here','zone':'Barisal'},
    {'city':'Pirojpur','desc':'Almost 40 restaurant here','zone':'Barisal'},

  ];
  final List dhaka = [
    {'city':'Dhaka','desc':'Almost 20 restaurant here','zone':'Dhaka'},
    {'city':'Faridpur','desc':'Almost 30 restaurant here','zone':'Dhaka'},
    {'city':'Gazipur','desc':'Almost 50 restaurant here','zone':'Dhaka'},
    {'city':'Gopalganj','desc':'Almost 100 restaurant here','zone':'Dhaka'},
    {'city':'Kishoreganj,','desc':'Almost 40 restaurant here','zone':'Dhaka'},
    {'city':'Madaripur','desc':'Almost 40 restaurant here','zone':'Dhaka'},
    {'city':'Narayanganj','desc':'Almost 66 restaurant here','zone':'Dhaka'},
    {'city':'Narsingdi','desc':'Almost 40 restaurant here','zone':'Dhaka'},
    {'city':'Rajbari','desc':'Almost 22 restaurant here','zone':'Dhaka'},
    {'city':'Shariatpur','desc':'Almost 35 restaurant here','zone':'Dhaka'},
    {'city':'Tangail','desc':'Almost 15 restaurant here','zone':'Dhaka'},
  ];
  final List ctg = [
    {'city':'Bandarban','desc':'Almost 20 restaurant here','zone':'Chittagong'},
    {'city':'Brahmanbaria','desc':'Almost 30 restaurant here','zone':'Chittagong'},
    {'city':'Cumilla','desc':'Almost 50 restaurant here','zone':'Chittagong'},
    {'city':'Chittagong','desc':'Almost 100 restaurant here','zone':'Chittagong'},
    {'city':'Coxs Bazar,','desc':'Almost 40 restaurant here','zone':'Chittagong'},
    {'city':'Chandpur','desc':'Almost 40 restaurant here','zone':'Chittagong'},
    {'city':'Feni','desc':'Almost 66 restaurant here','zone':'Chittagong'},
    {'city':'Khagrachari','desc':'Almost 40 restaurant here','zone':'Chittagong'},
    {'city':'Lakshmipur','desc':'Almost 22 restaurant here','zone':'Chittagong'},
    {'city':'Noakhali','desc':'Almost 35 restaurant here','zone':'Chittagong'},
    {'city':'Rangamati','desc':'Almost 15 restaurant here','zone':'Chittagong'},

  ];

  final List khulna = [
    {'city':'Bagerhat','desc':'Almost 50 restaurant here','zone':'Khulna'},
    {'city':'Chuadanga','desc':'Almost 20 restaurant here','zone':'Khulna'},
    {'city':'Jessore','desc':'Almost 30 restaurant here','zone':'Khulna'},
    {'city':'Jhenaidah','desc':'Almost 100 restaurant here','zone':'Khulna'},
    {'city':'Khulna','desc':'Almost 40 restaurant here','zone':'Khulna'},
    {'city':'Kushtia,','desc':'Almost 40 restaurant here','zone':'Khulna'},
    {'city':'Magura','desc':'Almost 40 restaurant here','zone':'Khulna'},
    {'city':'Meherpur','desc':'Almost 66 restaurant here','zone':'Khulna'},
    {'city':'Narail','desc':'Almost 22 restaurant here','zone':'Khulna'},
    {'city':'Satkhira','desc':'Almost 35 restaurant here','zone':'Khulna'},

  ];

  final List rajshahi = [
    {'city':'Bogra','desc':'Almost 50 restaurant here','zone':'Rajshahi'},
    {'city':'Joypurhat','desc':'Almost 20 restaurant here','zone':'Rajshahi'},
    {'city':'Natore','desc':'Almost 30 restaurant here','zone':'Rajshahi'},
    {'city':'Naogaon','desc':'Almost 100 restaurant here','zone':'Rajshahi'},
    {'city':'Nawabganj','desc':'Almost 40 restaurant here','zone':'Rajshahi'},
    {'city':'Pabna,','desc':'Almost 40 restaurant here','zone':'Rajshahi'},
    {'city':'Rajshahi','desc':'Almost 40 restaurant here','zone':'Rajshahi'},
  ];

  final List rangpur = [
    {'city':'Dinajpur','desc':'Almost 50 restaurant here','zone':'Rangpur'},
    {'city':'Gaibandha','desc':'Almost 20 restaurant here','zone':'Rangpur'},
    {'city':'Kurigram','desc':'Almost 30 restaurant here','zone':'Rangpur'},
    {'city':'Lalmonirhat','desc':'Almost 100 restaurant here','zone':'Rangpur'},
    {'city':'Nilphamari','desc':'Almost 40 restaurant here','zone':'Rangpur'},
    {'city':'Panchagarh,','desc':'Almost 40 restaurant here','zone':'Rangpur'},
    {'city':'Rangpur','desc':'Almost 40 restaurant here','zone':'Rangpur'},
    {'city':'Thakurgaon','desc':'Almost 40 restaurant here','zone':'Rangpur'},
  ];

  final List mymensingh = [
    {'city':'Jamalpur','desc':'Almost 20 restaurant here','zone':'Mymensingh'},
    {'city':'Mymensingh','desc':'Almost 50 restaurant here','zone':'Mymensingh'},
    {'city':'Netrokona','desc':'Almost 30 restaurant here','zone':'Mymensingh'},
    {'city':'Sherpur','desc':'Almost 100 restaurant here','zone':'Mymensingh'},
  ];

  final List sylhet = [
    {'city':'Habiganj','desc':'Almost 30 restaurant here','zone':'Rangpur'},
    {'city':'Maulvibazar','desc':'Almost 100 restaurant here','zone':'Rangpur'},
    {'city':'Sylhet','desc':'Almost 20 restaurant here','zone':'Sylhet'},
    {'city':'Sunamganj','desc':'Almost 50 restaurant here','zone':'Sylhet'},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Image.asset(
          'assets/logo1.png',
          height: 80,
          width: 200,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: ()async{
          //   await authClass.logout();
          //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignUp()), (route) => false);
          // },
          // )
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (builder)=>UserProfile()));
                },
                icon: Icon(Icons.account_circle_outlined,size: 40,color: Colors.black,)),
          )
        ],
      ),
      body: Container(

        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: Container(
                  //height: MediaQuery.of(context).size.height-50,
                  child: Image.asset('assets/image/F.jpg',fit: BoxFit.fill,),
                ),
                ),
                Expanded(child: Container(color: Colors.white60),),
              ],
            ),
            Positioned(
                left :20,
                bottom: 450,
                child: Text('Divisions',style:TextStyle(fontFamily:'Orelega One',fontSize: 25,fontWeight: FontWeight.bold),)),
            Align(
              alignment: Alignment(0, 0.8),
              child: GridView.count(
                crossAxisCount:3,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(barisal)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(
                                child: Image.asset('assets/B.gif',fit: BoxFit.fill,),

                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),

                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(ctg)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/C.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(dhaka)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/D.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(khulna)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/K.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(rajshahi)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/RAJ.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),

                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(rangpur)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/RAN.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),

                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(mymensingh)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/M.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),

                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>Chittagong(sylhet)));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(15.0) ,
                                image:  DecorationImage(

                                  image:  AssetImage("assets/S.gif"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),
                  Container(

                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyReviews()));
                      },

                      child:  Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Colors.white70,
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Center(
                              child:   Container(
                                child: Center(
                                  child: Text('MY REVIEW',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                borderRadius:BorderRadius.circular(15.0) ,

                                // image:  DecorationImage(
                                //
                                //   image:  AssetImage("assets/S.gif"),
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                              ),
                            )),
                        elevation: 5,
                        margin: EdgeInsets.all(15),
                      ),
                    ),

                  ),




                ],
              ),

            ),

          ],
        ),
      ),
    );
  }
  
}
