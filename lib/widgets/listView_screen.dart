import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/models/firestore_helper.dart';
import 'package:flutter_notes/models/listitem_datamodel.dart';

import '../screens/detail_screen.dart';

FirebaseService firebaseService = FirebaseService();

class ListViewWidget extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  // List<DataModel> _items = [];
  // List<Listdata> _items = [];
  final String? collectionName;
  ListViewWidget(
    this.documents, {
    this.collectionName,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  // List<DataModel> _item = [];
  // List _dataKeys = [];

  bool deleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    // _dataKeys = widget.dataBox.keys.toList();
    // print("data keys :$_dataKeys");
    print("list length  :${widget.documents.length}");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.documents.length,
      itemBuilder: (context, index) {
        final document = widget.documents[index];
        final documentData = document.data() as Map<String, dynamic>;
        final documentId = document.id;
        // Create a Note object from Firestore data
        final data = MyDataClass.fromFirestore(documentData, documentId);
        // final item = widget._items[index];
        return list_Item_card(data, index, context);
      },
    );
  }

  Card list_Item_card(item, int index, BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
        ),
        subtitle: Text(
          item.description,
          // 'description',
          maxLines: 3,
        ),
        // trailing: Icon(
        //   item.isFavorite ? Icons.favorite : Icons.favorite_border,
        // ),
        leading: Icon(
          item.isPinned ? Icons.push_pin : null,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => detail_screen(
                item: item, collectionName: widget.collectionName,
                docId: item.id,

                // item_key: item.title,
              ),
            ),
          );
        },
        onLongPress: () {
          print("item pressed :$index  item Key is ");

          _showDeleteDialog(context, widget.collectionName!, item);
        },
      ),
    );
  }

  //
  void _showDeleteDialog(BuildContext context, String name, final data) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                firebaseService.delete(collectionName: name, id: data.id);
                Navigator.pop(dialogContext); // Close the dialog

                // Show a snackbar to indicate item deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(' deleted'),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () async {
                        firebaseService.addData(
                          name,
                          data.title,
                          data.description,
                          isFavorite: data.isFavorite,
                          isPinned: data.isPinned,
                          time: data.time,
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
