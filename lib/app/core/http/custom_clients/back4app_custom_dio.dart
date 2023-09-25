import 'package:dio/dio.dart';

class Back4appCustomDio with DioMixin implements Dio {
  Back4appCustomDio() {
    httpClientAdapter = HttpClientAdapter();
    final baseOptions = BaseOptions(
      baseUrl: 'https://parseapi.back4app.com/classes',
      headers: {
        'X-Parse-Application-Id': 'CKZ6MD3KgKXovL5PHfmD8qFcKBIN2NL39C0nenNr',
        'X-Parse-REST-API-Key': 'XawaVvCSsg2pX4V86Rlrc5r84xCQKdJrxN8QoZ7L',
      },
    );
    options = baseOptions;
  }
}
