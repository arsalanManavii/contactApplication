import 'package:contact_application/helper/database_helper.dart';
import 'package:contact_application/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> _contactList = [];
  List<Contact> _favoriteContacts = [];
  bool isLiked = false;
  void addContact(Contact contact) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert(
      DatabaseHelper.table,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    contact.copy(id: id);
    notifyListeners();
  }

  void contacts() async {
    var db = await DatabaseHelper.instance.database;
    var contactMap = await db.query(DatabaseHelper.table);
    var contactList =
        contactMap.map((fromMap) => Contact.fromMap(fromMap)).toList();
    _contactList = contactList;
    notifyListeners();
  }

  void favoriteContacts() async {
    var db = await DatabaseHelper.instance.database;
    var contactMap = await db.rawQuery(
      'SELECT * FROM ${DatabaseHelper.table} WHERE ${DatabaseHelper.columnIsLiked} = 1',
    );
    var favoriteContactsList =
        contactMap.map((fromMap) => Contact.fromMap(fromMap)).toList();
    _favoriteContacts = favoriteContactsList;
    notifyListeners();
  }

  void updateFavoriteContact(Contact contact) async {
    var db = await DatabaseHelper.instance.database;
    if (contact.isLiked == 0) {
      await db.update(
        DatabaseHelper.table,
        {
          DatabaseHelper.columnIsLiked: 1,
        },
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [contact.id],
      );
    } else {
      await db.update(
        DatabaseHelper.table,
        {
          DatabaseHelper.columnIsLiked: 0,
        },
        where: '${DatabaseHelper.columnId} = ?',
        whereArgs: [contact.id],
      );
    }
  }

  void deleteContact(Contact contact) async {
    var db = await DatabaseHelper.instance.database;
    await db.delete(
      DatabaseHelper.table,
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [contact.id],
    );
    notifyListeners();
  }

  void updateContact(int id, String name, String phoneNumber) async {
    var db = await DatabaseHelper.instance.database;
    db.update(
      DatabaseHelper.table,
      {
        DatabaseHelper.columnName: name,
        DatabaseHelper.columnNumber: phoneNumber
      },
      where: '${DatabaseHelper.columnId} = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  List<Contact> get contactList => _contactList;
  List<Contact> get favoriteContactList => _favoriteContacts;
}
