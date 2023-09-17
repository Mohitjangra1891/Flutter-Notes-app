import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/models/listitem_datamodel.dart';

import 'detail_screen.dart';

class searchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<searchScreen> {
  List<MyDataClass> searchResults = [];
  List<MyDataClass> results = [];
  String collectionName = 'basic';
  String _searchQuery = '';

  // git commit confirmed
  //  FOR SEARCHING ONLY THE FIRST WORD

  // void performSearch(String query) {
  //   if (query.isNotEmpty) {
  //     FirebaseFirestore.instance
  //         .collection('basic')
  //         .where('title', arrayContains: query)
  //         // .where('title', isLessThanOrEqualTo: query + '\uf8ff')
  //         .get()
  //         .then((querySnapshotTitle) {
  //       FirebaseFirestore.instance
  //           .collection('basic')
  //           .where('description', arrayContains: query)
  //           // .where('description', isLessThanOrEqualTo: query + '\uf8ff')
  //           .get()
  //           .then((querySnapshotDescription) {
  //         setState(() {
  //           // Combine the results from both queries
  //           searchResults = [
  //             ...querySnapshotTitle.docs,
  //             ...querySnapshotDescription.docs,
  //           ];
  //         });
  //       }).catchError((error) {
  //         print('Error performing search: $error');
  //       });
  //     }).catchError((error) {
  //       print('Error performing search: $error');
  //     });
  //   } else {
  //     setState(() {
  //       searchResults.clear();
  //     });
  //   }
  // }
  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy('pin', descending: true)
        .orderBy('createdAt', descending: true)
        .get();

    for (var document in querySnapshot.docs) {
      var id = document.id;
      var title = document['title'];
      var description = document['description'];
      var isFavorite = document['isFavorite'];
      var isPinned = document['pin'];
      var time = document['createdAt'];
      results.add(MyDataClass(
          id: id,
          title: title,
          description: description,
          isFavorite: isFavorite,
          isPinned: isPinned,
          time: time));
    }
  }

  void filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    setState(() {
      _searchQuery = query;
      searchResults = results
          .where((item) =>
              item.title.toLowerCase().contains(query.toLowerCase()) ||
              item.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            filterData(query.toLowerCase());
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          MyDataClass item = searchResults[index];
          return Card(
            color: Colors.white,
            elevation: 2,
            shadowColor: Colors.black,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.black87, // Customize the highlight color
                ),
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
                      item: item, collectionName: collectionName,
                      docId: item.id,

                      // item_key: item.title,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
