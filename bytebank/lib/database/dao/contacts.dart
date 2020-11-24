import 'package:bytebank/models/contact.dart';

import '../app_database.dart';
import 'package:sqflite_common/sqlite_api.dart';


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
    final db = await createDatabase();
    return _toMap(contact, db);
  }

  Future<int> _toMap(Contact contact, Database db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_id] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_account_number] = contact.accountNumber;
    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() {
    return createDatabase().then((db) =>
        db.query(_tableName).then((maps) {
          return _toList(maps);
        }
        )
    );
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
    }
    return contacts;
  }
}