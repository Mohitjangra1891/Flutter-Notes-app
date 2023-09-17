import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/firestore_helper.dart';
import '../widgets/addList_dailog.dart';
import '../widgets/listView_screen.dart';

class basic_tab extends StatefulWidget {
  VoidCallback? onRefresh;

  basic_tab({this.onRefresh});

  @override
  State<basic_tab> createState() => _basic_tabState();
}

class _basic_tabState extends State<basic_tab> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _collectionName = "basic";
  FirebaseService firebaseService = FirebaseService();

  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('basic');

  // void refreshItems_basic() {
  //   List<DataModel> loaded_data = basic_Box.values.toList();
  //   // You can use this list as needed in your app
  //   print('Loaded notes in basic tab: $loaded_data');
  //
  //   _pinnedItems = loaded_data.where((item) => item.isPinned).toList();
  //   _unpinnedItems = loaded_data.where((item) => !item.isPinned).toList();
  //   _basic_items = [..._pinnedItems.reversed, ..._unpinnedItems.reversed];
  //   // we use "reversed" to sort items in order from the latest to the oldest
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: FirebaseService().stream(_collectionName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No notes available.'),
            );
          } else {
            final notes = snapshot.data!;

            return ListViewWidget(notes!, collectionName: _collectionName);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialogWidget(
                formKey: _formKey,
                onSave: (title, description) {
                  if (_formKey.currentState!.validate()) {
                    firebaseService.addData(
                      _collectionName,
                      title,
                      description,
                    );
                    // setState(() {});
                    Navigator.pop(context);
                  }
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
