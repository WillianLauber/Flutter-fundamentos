import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

const String baseUrl = 'http://172.20.33.12:8080/transactions';
final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);


