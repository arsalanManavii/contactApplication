import 'package:contact_application/helper/database_helper.dart';

class Contact {
  int? id;
  String? cName;
  String? cPhoneNumber;
  int? isLiked;

  Contact({
     this.id,
    this.cName,
    this.cPhoneNumber,
    this.isLiked,
  });

  Map<String, Object?> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: cName,
      DatabaseHelper.columnNumber: cPhoneNumber,
      DatabaseHelper.columnIsLiked: isLiked,
    };
  }

  Contact copy({
    int? id,
    String? cName,
    String? cPhoneNumber,
    int? isLiked,
  }) =>
      Contact(
        id: id ?? this.id,
        cName: cName ?? this.cName,
        cPhoneNumber: cPhoneNumber ?? this.cPhoneNumber,
        isLiked: isLiked ?? this.isLiked,
      );

  factory Contact.fromMap(Map<String, Object?> fromMap) {
    return Contact(
      id: fromMap[DatabaseHelper.columnId] as int,
      cName: fromMap[DatabaseHelper.columnName] as String,
      cPhoneNumber: fromMap[DatabaseHelper.columnNumber] as String,
      isLiked: fromMap[DatabaseHelper.columnIsLiked] as int,
    );
  }
}
