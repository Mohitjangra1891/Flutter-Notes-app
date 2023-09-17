import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/firestore_helper.dart';
import '../widgets/listView_screen.dart';

class favorites_screen extends StatelessWidget {
  String _collectionName = 'basic';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: FirebaseService().stream_Favorites(_collectionName),
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
    );
  }
}
