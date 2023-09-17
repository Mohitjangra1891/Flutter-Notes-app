import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/models/firestore_helper.dart';

import '../models/listitem_datamodel.dart';

class detail_screen extends StatefulWidget {
  // final title, description;
  final item;
  final collectionName;
  final docId;
  detail_screen(
      {super.key,
      required this.item,
      required this.collectionName,
      required this.docId});

  @override
  State<detail_screen> createState() => _detail_screenState();
}

class _detail_screenState extends State<detail_screen> {
  FirebaseService firebaseService = FirebaseService();
  List<MyDataClass> myList = [];

  late String title, description;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Co11lors.black12,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              // Replace the current route with a new instance of BasicTab
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => home_screen(),
              //   ),
              // ); // Implement back button functionality
            },
          ),
          // title: Text(data!.title),
          actions: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: widget.item.isPinned
                      ? Icon(Icons.push_pin)
                      : Icon(Icons.push_pin_outlined),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection(widget.collectionName)
                        .doc(widget.docId)
                        .update({
                      'pin': !(widget.item.isPinned),
                    }).then((value) {
                      print("User updated");
                      widget.item.isPinned = !(widget.item.isPinned);
                      setState(() {});
                    }).catchError(
                            (error) => print("Failed to update user: $error"));

                    // changeState;
                    // Implement pin functionality
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: widget.item.isFavorite
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection(widget.collectionName)
                        .doc(widget.docId)
                        .update({
                      'isFavorite': !(widget.item.isFavorite),
                    }).then((value) {
                      print("User updated");
                      widget.item.isFavorite = !(widget.item.isFavorite);
                      setState(() {});
                    }).catchError(
                            (error) => print("Failed to update user: $error"));

                    // changeState;
                    // Implement pin functionality
                  },
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  // cursorRadius: Radius.circular(0.5),
                  showCursor: true,
                  cursorColor: Colors.black,
                  cursorWidth: 0.7,
                  // cursorHeight: 5,
                  initialValue: widget.item.title,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: 'title',
// Set this to true to reduce vertical spacing
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none),
                  onChanged: (value) {
                    FirebaseFirestore.instance
                        .collection(widget.collectionName)
                        .doc(widget.docId)
                        .update({
                      'title': value,
                    }).then((value) {
                      print("User title updated");
                    }).catchError(
                            (error) => print("Failed to update user: $error"));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                    showCursor: true,
                    cursorColor: Colors.black,
                    cursorWidth: 0.7,
                    // cursorHeight: 0,
                    initialValue: widget.item.description,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    decoration: InputDecoration(
                        isDense: true,
// Set this to true to reduce vertical spacing
                        hintText: 'description',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none),
                    onChanged: (value) {
                      FirebaseFirestore.instance
                          .collection(widget.collectionName)
                          .doc(widget.docId)
                          .update({
                        'description': value,
                      }).then((value) {
                        print("User description updated");
                      }).catchError((error) =>
                              print("Failed to update user: $error"));
                    }),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ));
  }
}
