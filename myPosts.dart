
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_ccnust/Pages/explorePage.dart';
import 'package:cse_ccnust/Pages/reviewPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReviews extends StatefulWidget {


  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {

  Future<List<DocumentSnapshot>> getData()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qs = await firestore.collection('Review').orderBy('createdAt',descending: true).where('uid',isEqualTo: uid).get();
    return qs.docs;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,

        title: Center(
          child: Text('My Reviews',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color:Colors.black,

              )),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.yellow,Colors.yellowAccent]
          ),
        ),
        child: FutureBuilder(
          future: getData(),
          builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if(!snapshot.hasData){
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (_, index){
                  DocumentSnapshot data = snapshot.data![index];


                  return Card(

                    child: ListTile(
                      title: Text(data['res_name'],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Item: ${data['food_name']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          Text("Price: ${data['price']} BDT.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                          Text("Location : ${data['res_location']}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
                                     color: Colors.red),
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
                                "Date: ",
                                style: TextStyle(

                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${data['date']}/${data['month']}/${data['year']}",
                                style: TextStyle(

                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        children: [
                          IconButton(onPressed: (){
                            //Navigator.push(context, CupertinoPageRoute(builder: (builder)=>ReviewPage(location[index])));
                          }, icon: Icon(Icons.edit)),
                          SizedBox(width: 10,),
                          IconButton(onPressed: ()async{
                            await FirebaseFirestore.instance.collection('Review').doc(data.id).delete();
                            showSnackBar(context, "Post Deleted Successfully");
                            Navigator.pop(context);
                          }, icon: Icon(Icons.delete)),

                        ],
                      ),
                    ),
                  );
                });
          }
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context,String text){
    final snackbar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
