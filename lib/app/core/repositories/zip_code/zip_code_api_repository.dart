import '../../models/zip_code_model.dart';
import 'zip_code_repository.dart';

abstract interface class ZipCodeApiRepository implements ZipCodeRepository {
  Future<List<ZipCodeModel>> getAllZipCodes();
  Future<String> insertZipCode(ZipCodeModel newZipCode);
  Future<void> removeZipCode(String zipCodeId);
}
