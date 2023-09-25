class ZipCodeNotFoundException implements Exception {
  ZipCodeNotFoundException([this.message]);

  final String? message;
}
