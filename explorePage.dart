import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatefulWidget {
  var data;
  ExplorePage(this.data);

  //const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState(this.data);
}

class _ExplorePageState extends State<ExplorePage> {
  var dataa;
  _ExplorePageState(this.dataa);

  Future<List<DocumentSnapshot>> getData() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Review')
        .orderBy('createdAt', descending: true)
        .where('city', isEqualTo: dataa['city'])
        .get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection("Review")
        .where('city', isEqualTo: dataa['city'])
        .snapshots();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo1.png',
            height: 80,
            width: 200,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.black54, Colors.yellow])),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: [
                      Card(
                        child: Container(
                          child: Image.asset(
                            'assets/slider1.jpg',
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          child: Image.asset(
                            'assets/slider2.jpg',
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          child: Image.asset(
                            'assets/slider3.jpg',
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                        autoPlay: true, autoPlayCurve: Curves.easeInOutQuart)),
                Container(
                  height: MediaQuery.of(context).size.height - 300,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                    future: getData(),
                    builder:
                        (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) {
                            DocumentSnapshot data = snapshot.data![index];

                            return Card(
                              color: Colors.white70,
                              child: ListTile(
                                leading: Image.asset('assets/logo.jpg'),
                                title: Text(
                                  data['res_name'],
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          "Restaurant Location: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['res_location'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Item Name: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['food_name'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Price: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['price'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          " /=",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Rating: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['rating'],
                                          style: TextStyle(
                                              fontSize: 22, color: Colors.red),
                                        ),
                                        Text(
                                          " out of 10",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Posted By: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data['post_by'],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Date: ",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${data['date']}/${data['month']}/${data['year']}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: _stream,
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     // if (snapshot.hasError) {
                  //     //   return Text('Something went wrong');
                  //     // }
                  //
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(child: Text("Loading"));
                  //     }
                  //
                  //     return ListView(
                  //       children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  //         Map<String, dynamic> data =
                  //             document.data()! as Map<String, dynamic>;
                  //         return Card(
                  //           color: Colors.white70,
                  //           child: ListTile(
                  //             leading: Image.asset('assets/logo.jpg'),
                  //             title: Text(data['res_name'],style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 23),),
                  //             subtitle: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Restaurant Location: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text(data['res_location'],style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                   ],
                  //                 ),
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Item Name: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text(data['food_name'],style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                   ],
                  //                 ),
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Price: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text(data['price'],style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                     Text(" /=",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                   ],
                  //                 ),
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Rating: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text(data['rating'],style: TextStyle(fontSize: 22,color: Colors.red),),
                  //                     Text(" out of 10",style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                   ],
                  //                 ),
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Posted By: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text(data['post_by'],style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                   ],
                  //                 ),
                  //                 Wrap(
                  //                   children: [
                  //                     Text("Date: ",style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),),
                  //                     Text("${data['date']}/${data['month']}/${data['year']}",style: TextStyle(fontSize: 17,color: Colors.black),),
                  //                   ],
                  //                 ),
                  //
                  //
                  //
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       }).toList(),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        )

        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 30),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //
        //       children: [
        //         Column(
        //
        //           children: [
        //             Text('কি খাবো তে স্বাগতম',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
        //             Text('Good Morning Nahid',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
        //           ],
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.all(10.0),
        //
        //           child: CarouselSlider(
        //               items: [
        //                 Card(
        //                   child: Container(
        //                     child: Image.asset('assets/slider1.jpg',height: 200,fit: BoxFit.fill,),
        //
        //                   ),
        //                 ),
        //                 Card(
        //                   child: Container(
        //                     child: Image.asset('assets/slider2.jpg',height: 200,fit: BoxFit.fill,),
        //
        //                   ),
        //                 ),
        //                 Card(
        //                   child: Container(
        //                     child: Image.asset('assets/slider3.jpg',height: 200,fit: BoxFit.fill,),
        //
        //                   ),
        //                 ),
        //
        //               ],
        //               options: CarouselOptions(
        //                 autoPlay: true,
        //                 autoPlayCurve: Curves.easeInOutQuart
        //               )),
        //         ),
        //
        //
        //
        //
        //       ],
        //     ),
        //   ),
        // ),
        // );
        );
  }
}
