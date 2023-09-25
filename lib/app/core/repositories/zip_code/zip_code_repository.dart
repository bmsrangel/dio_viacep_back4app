import 'package:dio_viacep_back4app/app/core/models/zip_code_model.dart';

abstract interface class ZipCodeRepository {
  Future<ZipCodeModel> getZipCodeData(String zipCode);
}
