import 'dart:convert';

import 'package:dio/dio.dart';

import '../../exceptions/internal_exception.dart';
import '../../exceptions/zip_code_exception.dart';
import '../../exceptions/zip_code_not_found_exception.dart';
import '../../models/zip_code_model.dart';
import 'zip_code_api_repository.dart';

class DioBack4appZipCodeRepositoryImpl implements ZipCodeApiRepository {
  DioBack4appZipCodeRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<ZipCodeModel> getZipCodeData(String zipCode) async {
    if (!zipCode.contains('-')) {
      zipCode = '${zipCode.substring(0, 5)}-${zipCode.substring(5)}';
    }
    try {
      final response = await _dio.get(
        '/zip_codes',
        queryParameters: {
          'where': jsonEncode(
            {'cep': zipCode},
          ),
        },
      );
      final results = response.data['results'] as List;
      if (results.isEmpty) {
        throw ZipCodeNotFoundException();
      } else {
        return ZipCodeModel.fromMap(results.first);
      }
    } on DioException catch (e) {
      throw ZipCodeException(e.message);
    } on ZipCodeNotFoundException {
      rethrow;
    } catch (e) {
      throw InternalException(e.toString());
    }
  }

  @override
  Future<List<ZipCodeModel>> getAllZipCodes() async {
    try {
      final response = await _dio.get(
        '/zip_codes',
      );
      return (response.data['results'] as List)
          .map((zipCodeMap) => ZipCodeModel.fromMap(zipCodeMap))
          .toList();
    } on DioException catch (e) {
      throw ZipCodeException(e.message);
    } catch (e) {
      throw InternalException(e.toString());
    }
  }

  @override
  Future<String> insertZipCode(ZipCodeModel newZipCode) async {
    try {
      final response = await _dio.post(
        '/zip_codes',
        data: newZipCode.toMap(),
      );
      return response.data['objectId'];
    } on DioException catch (e) {
      throw ZipCodeException(e.message);
    } catch (e) {
      throw InternalException(e.toString());
    }
  }

  @override
  Future<void> removeZipCode(String zipCodeId) async {
    try {
      await _dio.delete('/zip_codes/$zipCodeId');
    } on DioException catch (e) {
      throw ZipCodeException(e.message);
    } catch (e) {
      throw InternalException(e.toString());
    }
  }
}
