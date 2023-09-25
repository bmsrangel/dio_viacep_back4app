import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/exceptions/internal_exception.dart';
import '../../../../core/exceptions/zip_code_exception.dart';
import '../../../../core/exceptions/zip_code_not_found_exception.dart';
import '../../../../core/models/zip_code_model.dart';
import '../../../../core/repositories/zip_code/zip_code_api_repository.dart';
import '../../../../core/repositories/zip_code/zip_code_repository.dart';

class SearchZipCodeStore extends Store<ZipCodeModel?> {
  SearchZipCodeStore(this._apiRepository, this._viaCEPRepository) : super(null);

  final ZipCodeApiRepository _apiRepository;
  final ZipCodeRepository _viaCEPRepository;

  Future<void> searchByZipCode(String zipCode) async {
    setLoading(true);
    try {
      final zipCodeData = await _apiRepository.getZipCodeData(zipCode);
      update(zipCodeData);
    } on ZipCodeNotFoundException {
      final zipCodeData = await _viaCEPRepository.getZipCodeData(zipCode);
      final zipCodeId = await _apiRepository.insertZipCode(zipCodeData);
      update(zipCodeData.copyWith(id: zipCodeId));
    } on ZipCodeException catch (e) {
      setError(e.message);
    } on InternalException catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }
}
