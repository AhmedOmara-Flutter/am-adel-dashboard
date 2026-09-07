class CustomException implements Exception {
  final String errMessage;
  CustomException(this.errMessage);


  @override
  String toString() => errMessage;
}
