import 'package:http/http.dart';
import 'package:path/path.dart';

void findAll() async{
 final Response response = await get('localhost:8080/transactions', headers: {'password': '10000' });
 print(response.body);
}