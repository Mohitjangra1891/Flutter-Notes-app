import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
//
// @HiveType(typeId: 0)
// class DataModel extends HiveObject {
//   @HiveField(0)
//   String title;
//   @HiveField(1)
//   String description;
//   @HiveField(2)
//   bool isFavorite; // New property
//   @HiveField(3)
//   bool isPinned;
//   DataModel(
//     this.title,
//     this.description,
//     this.isFavorite,
//     this.isPinned,
//   );
// }
//
// class DataModelAdapter extends TypeAdapter<DataModel> {
//   @override
//   final int typeId = 1;
//
//   @override
//   DataModel read(BinaryReader reader) {
//     return DataModel(
//       reader.readString(),
//       reader.readString(),
//       reader.readBool() ?? false,
//       reader.readBool() ?? false,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, DataModel obj) {
//     writer.writeString(obj.title);
//     writer.writeString(obj.description);
//     writer.writeBool(obj.isFavorite); // Write isFavorite
//     writer.writeBool(obj.isPinned); // Write isFavorite
//   }
// }

// @HiveType(typeId: 0)
// class notes_Data extends HiveObject {
//   @HiveField(0)
//   late String title;
//
//   @HiveField(1)
//   late String text;
//
//   @HiveField(2)
//   late String subtext;
// }

class MyDataClass {
  String id;
  String title;
  String description;
  bool isFavorite;
  bool isPinned;
  Timestamp? time;

  MyDataClass({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.isPinned,
    required this.time,
  });

  // Factory constructor to convert Firestore data to a Note object
  factory MyDataClass.fromFirestore(
      Map<String, dynamic> data, String documentId) {
    return MyDataClass(
      title: data['title'],
      description: data['description'],
      isPinned: data['pin'],
      isFavorite: data['isFavorite'],
      time: data['createdAt'],
      id: documentId,
    );
  }
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'isFavorite': isFavorite});
    result.addAll({'isPinned': isPinned});
    result.addAll({'time': time});

    return result;
  }

  factory MyDataClass.fromMap(Map<String, dynamic> map) {
    return MyDataClass(
      id: map['id'],
      time: map['time'],
      isFavorite: map['isFavorite'] ?? false,
      isPinned: map['isPinned'] ?? false,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyDataClass.fromJson(String source) =>
      MyDataClass.fromMap(json.decode(source));
}
