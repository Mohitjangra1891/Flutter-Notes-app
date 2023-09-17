import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DocumentSnapshot>> stream(String collectionName) {
    return _firestore
        .collection(collectionName)
        .orderBy('pin', descending: true) // Pinned items first
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Stream<List<DocumentSnapshot>> stream_Favorites(String collectionName) {
    return _firestore
        .collection(collectionName)
        .where('isFavorite',
            isEqualTo: true) // Filter documents where 'isFavorite' is true
        .orderBy('pin', descending: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  void addData(String collectionName, String title, String description,
      {bool? isFavorite, bool? isPinned, Timestamp? time}) {
    _firestore.collection(collectionName).doc().set({
      'title': title,
      'description': description,
      'isFavorite': isFavorite ?? false,
      'pin': isPinned ?? false,
      'createdAt': time ?? FieldValue.serverTimestamp(),
      // Set 'createdAt' with the current server timestamp
    }).then((value) {
      print("added success:  ");
    }).onError((error, stackTrace) {
      print("error in adding data");
    });
  }

  Future<void> updateUser(
      {required String collectionName,
      required String id,
      String? title,
      String? description,
      bool? pinned,
      bool? favorite}) {
    return _firestore
        .collection(collectionName)
        .doc(id)
        .update({
          'title': title,
          'description': description,
          'isFavorite': favorite,
          'pin': pinned,
          'createdAt': FieldValue.serverTimestamp(),
        })
        .then((value) => print("User updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> delete(
      {required String collectionName, required String id}) async {
    _firestore
        .collection(collectionName)
        .doc(id)
        .delete()
        .then((value) => print("User deleted successfully"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
