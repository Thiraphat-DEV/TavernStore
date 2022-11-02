import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/Whisky.dart';
//required validator form field
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final formKey = GlobalKey<FormState>();

  Whisky whisky = Whisky(name: '', price: "", stock: "", brand: "");

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  CollectionReference _whiskycollection =
      FirebaseFirestore.instance.collection("whisky");
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(child: Text("${snapshot.error}")),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text('Remember whisky: ')),
            body: Container(
              padding: EdgeInsets.all(30),
              child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Whisky Name: ",
                        style: TextStyle(
                            fontSize: 24, fontFamily: "cascadie code"),
                      ),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "Please Enter whisky name "),
                        onSaved: (String? name) {
                          whisky.name = name!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Whisky Price: ",
                        style: TextStyle(
                            fontSize: 24, fontFamily: "cascadie code"),
                      ),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "Please Enter whisky price"),
                        onSaved: (String? price) {
                          whisky.price = price!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Whisky Stock: ",
                        style: TextStyle(
                            fontSize: 24, fontFamily: "cascadie code"),
                      ),
                      TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Please Enter whisky stock"),
                        ]),
                        onSaved: (String? stock) {
                          whisky.stock = stock!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Whisky brand: ",
                        style: TextStyle(
                            fontSize: 24, fontFamily: "cascadie code"),
                      ),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "Please Enter whisky brand"),
                        onSaved: (String? brand) {
                          whisky.brand = brand!;
                        },
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              "Save Whisky Data",
                              style: TextStyle(fontSize: 24),
                            ),
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                _whiskycollection.add({
                                  'name': whisky.name,
                                  'price': whisky.price,
                                  'stock': whisky.stock,
                                  'brand': whisky.brand,
                                });
                                formKey.currentState!.reset();
                              }
                            },
                          )),
                    ],
                  )),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
