import 'package:dio/dio.dart';

class ViaCEPCustomDio with DioMixin implements Dio {
  ViaCEPCustomDio() {
    httpClientAdapter = HttpClientAdapter();
    final baseOptions = BaseOptions(
      baseUrl: 'https://viacep.com.br/ws',
    );
    options = baseOptions;
  }
}
