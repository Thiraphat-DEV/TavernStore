import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Show_Whisky extends StatefulWidget {
  @override
  _Show_WhiskyState createState() => _Show_WhiskyState();
}

class _Show_WhiskyState extends State<Show_Whisky> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show All Whisky Product"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("whisky").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return Container(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: FittedBox(
                      child: Text(
                        doc["stock"],
                      ),
                    ),
                  ),
                  title: Text(
                      "Whisky: " + doc["name"] + "\nBrand: " + doc["brand"]),
                  subtitle: Text("Price: " + doc["price"]),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
