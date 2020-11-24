import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';

import '../app_database.dart';
import 'package:sqflite/sqflite.dart';


class ContactDao {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _account_number = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY,'
      '$_name TEXT,'
      '$_account_number INTEGER)';

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_account_number] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async{
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  List<Contact> _toList(List<Map<String, dynamic>> maps) {
    final List<Contact> contacts = List();
    for (Map<String, dynamic> map in maps) {
      final Contact contact =
      Contact(
          map[_id],
          map[_name],
          map[_account_number]);
      contacts.add(contact);
      debugPrint(contact.toString());
    }
    return contacts;
  }
}