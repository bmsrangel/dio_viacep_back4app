import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/exceptions/internal_exception.dart';
import '../../../../core/exceptions/zip_code_exception.dart';
import '../../../../core/models/zip_code_model.dart';
import '../../../../core/repositories/zip_code/zip_code_api_repository.dart';

class ZipCodesStore extends Store<List<ZipCodeModel>> {
  ZipCodesStore(this._apiRepository) : super([]);

  final ZipCodeApiRepository _apiRepository;

  Future<void> fetchZipCodes() async {
    setLoading(true);
    try {
      final zipCodes = await _apiRepository.getAllZipCodes();
      update(zipCodes);
    } on ZipCodeException catch (e) {
      setError(e.message);
    } on InternalException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro desconhecido: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteZipCode(ZipCodeModel zipCode) async {
    try {
      await _apiRepository.removeZipCode(zipCode.id!);
    } on ZipCodeException catch (e) {
      setError(e.message);
    } on InternalException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro desconhecido: $e');
    }
  }
}
