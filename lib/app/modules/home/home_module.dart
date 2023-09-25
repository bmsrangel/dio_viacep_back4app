import 'package:dio_viacep_back4app/app/core/core_module.dart';
import 'package:dio_viacep_back4app/app/core/http/custom_clients/back4app_custom_dio.dart';
import 'package:dio_viacep_back4app/app/core/http/custom_clients/viacep_custom_dio.dart';
import 'package:dio_viacep_back4app/app/core/repositories/zip_code/dio_back4app_zip_code_repository_impl.dart';
import 'package:dio_viacep_back4app/app/core/repositories/zip_code/dio_viacep_zip_code_repository_impl.dart';
import 'package:dio_viacep_back4app/app/core/repositories/zip_code/zip_code_api_repository.dart';
import 'package:dio_viacep_back4app/app/core/repositories/zip_code/zip_code_repository.dart';
import 'package:dio_viacep_back4app/app/modules/home/home_page.dart';
import 'package:dio_viacep_back4app/app/modules/home/pages/search_zip_code_page.dart';
import 'package:dio_viacep_back4app/app/modules/home/pages/single_zip_code_page.dart';
import 'package:dio_viacep_back4app/app/modules/home/stores/single_zip_code/search_zip_code_store.dart';
import 'package:dio_viacep_back4app/app/modules/home/stores/zip_codes/zip_codes_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ZipCodeRepository>(
      () => DioViaCEPZipCodeRepository(
        i.get<ViaCEPCustomDio>(),
      ),
    );
    i.addLazySingleton<ZipCodeApiRepository>(
      () => DioBack4appZipCodeRepositoryImpl(
        i.get<Back4appCustomDio>(),
      ),
    );
    i.addLazySingleton<ZipCodesStore>(ZipCodesStore.new);
    i.addLazySingleton<SearchZipCodeStore>(
      () => SearchZipCodeStore(
        i.get<ZipCodeApiRepository>(),
        i.get<ZipCodeRepository>(),
      ),
    );
  }

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => HomePage(
        zipCodesStore: Modular.get<ZipCodesStore>(),
      ),
    );
    r.child(
      '/zip_code',
      child: (_) => SingleZipCodePage(
        zipCodeModel: r.args.data,
      ),
    );
    r.child(
      '/search',
      child: (_) => SearchZipCodePage(
        searchZipCodeStore: Modular.get<SearchZipCodeStore>(),
        zipCodesStore: Modular.get<ZipCodesStore>(),
      ),
    );
  }
}
