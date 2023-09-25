import 'package:dio/dio.dart';
import 'package:dio_viacep_back4app/app/core/exceptions/internal_exception.dart';
import 'package:dio_viacep_back4app/app/core/exceptions/zip_code_exception.dart';
import 'package:dio_viacep_back4app/app/core/models/zip_code_model.dart';
import 'package:dio_viacep_back4app/app/core/repositories/zip_code/zip_code_repository.dart';

class DioViaCEPZipCodeRepository implements ZipCodeRepository {
  DioViaCEPZipCodeRepository(Dio? dio) {
    if (dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: 'https://viacep.com.br/ws',
        ),
      );
    } else {
      _dio = dio;
    }
  }

  late final Dio _dio;

  @override
  Future<ZipCodeModel> getZipCodeData(String zipCode) async {
    try {
      final response = await _dio.get('/$zipCode/json');
      final data = ZipCodeModel.fromMap(response.data);
      return data;
    } on DioException catch (e) {
      throw ZipCodeException(e.message);
    } catch (e) {
      throw InternalException(e.toString());
    }
  }
}
