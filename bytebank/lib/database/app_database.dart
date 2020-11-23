import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');

    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'account_number INTEGER)');
    }, version: 2,
        onDowngrade: onDatabaseDowngradeDelete);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['id'] = contact.id;
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDatabase().then((db) => db.query('contacts').then((maps) {
        final List<Contact> contacts = List();
        for (Map<String, dynamic> map in maps) {
          final Contact contact =
              Contact(
                  map['id'],
                  map['name'],
                  map['account_number']);
          contacts.add(contact);
        }
        return contacts;
      }));
}
