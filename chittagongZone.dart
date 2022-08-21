
import 'package:cse_ccnust/Pages/explorePage.dart';
import 'package:cse_ccnust/Pages/reviewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chittagong extends StatefulWidget {
  //const Chittagong({Key? key}) : super(key: key);
  var location;
  Chittagong(this.location);

  @override
  _ChittagongState createState() => _ChittagongState(this.location);
}

class _ChittagongState extends State<Chittagong> {
  var location;
  _ChittagongState(this.location);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,

        title: Center(
          child: Image.asset(
            'assets/T.gif',
            fit: BoxFit.contain,
            height: 40,
          ),
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
        child: ListView.builder(

            itemCount: location.length,
            itemBuilder: (context, index){
              return Card(

                child: ListTile(
                  title: Text(location[index]['city'],style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                  subtitle: Text(location[index]['desc']),
                  trailing: Wrap(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (builder)=>ReviewPage(location[index])));
                      }, icon: Icon(Icons.add)),
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (builder)=>ExplorePage(location[index])));
                      }, icon: Icon(Icons.remove_red_eye)),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
