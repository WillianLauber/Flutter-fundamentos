import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/models/contact.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';


class LoggingInterceptor implements InterceptorContract {
 @override
 Future<RequestData> interceptRequest({RequestData data}) async {
  print('Request');
  print('Url: ${data.url}');
  print('Headers: ${data.headers}');
  print('Body: ${data.body}');
  return data;
 }

 @override
 Future<ResponseData> interceptResponse({ResponseData data}) async {
  print('Response');
  print('Status: ${data.statusCode}');
  print('Headers: ${data.headers}');
  print('Body: $data.body');
  return data;
 }

}


Future<List<Transaction>> findAll() async{
 final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
 final Response response = await client.get('172.20.33.12:8080/transactions');
 final List<dynamic> decodedJson = jsonDecode(response.body);
 final List<Transaction> transactions = List();
 for(Map<String, dynamic> transactionJson in decodedJson){
  final Map<String, dynamic> contactJson = transactionJson['contact'];
  final Transaction transaction = Transaction(transactionJson['value'], Contact(0, contactJson['name'], contactJson['accountNumber'])
  );
  transactions.add(transaction);
  print('Decoded json $decodedJson');
 }
}