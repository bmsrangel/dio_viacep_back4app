import 'package:dio_viacep_back4app/app/core/http/custom_clients/back4app_custom_dio.dart';
import 'package:dio_viacep_back4app/app/core/http/custom_clients/viacep_custom_dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(() => Back4appCustomDio());
    i.addSingleton(() => ViaCEPCustomDio());
  }
}
