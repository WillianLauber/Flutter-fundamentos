import 'dart:io';

import 'package:bytebank/database/dao/contacts.dart';
import 'package:bytebank/http/webClients/transaction_webClient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao{
}

class MockWebClient extends Mock implements TransactionWebClient{}
