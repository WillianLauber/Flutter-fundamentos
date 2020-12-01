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


void findAll() async{
 final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
 final Response response = await client.get('localhost:8080/transactions', headers: {'password': '10000' });

}