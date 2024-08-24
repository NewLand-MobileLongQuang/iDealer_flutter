class ApiError implements Exception {
  String message = "ApiError";
  ApiError();

  ApiError.fromException(Exception ex) {
    message = ex.runtimeType.toString();
  }

  ApiError.fromError(Error ex) {
    message = ex.runtimeType.toString();
  }
}
