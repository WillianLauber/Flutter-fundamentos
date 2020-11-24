import 'package:bytebank/database/dao/contacts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContactDao.tableSql);
  }, version: 1,
      onDowngrade: onDatabaseDowngradeDelete);
}
