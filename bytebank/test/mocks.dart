import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/models/contact.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao{
  @override
  Future<List<Contact>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<int> save(Contact contact) {
    // TODO: implement save
    throw UnimplementedError();
  }

}