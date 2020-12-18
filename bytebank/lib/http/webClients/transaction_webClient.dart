import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient{

  Future<List<Transaction>> findAll() async {
    final Response response =
    await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(transactionJson['value'],
          Contact(0, contactJson['name'], contactJson['accountNumber']));
      transactions.add(transaction);
      print('Decoded json $decodedJson');
    }
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber
      }
    };
    String transactionJson = jsonEncode(transactionMap);
    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);

    Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(json['value'],
        Contact(0, contactJson['name'], contactJson['accountNumber']));
  }

}