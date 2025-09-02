enum ApiResult {
  success,
  failure,
  networkError,
  timeoutError,
  unexpectedError,
  formatError,
}

class NetworkClientModel {
  final ApiResult result;
  final dynamic data;
  final String message;
  final int? statusCode;

  const NetworkClientModel._({
    required this.result,
    this.data,
    required this.message,
    this.statusCode,
  });

  const NetworkClientModel.success({
    required dynamic data,
    required int statusCode,
  }) : this._(
         result: ApiResult.success,
         data: data,
         message: '',
         statusCode: statusCode,
       );

  const NetworkClientModel.failure({
    required String message,
    dynamic data,
    required int statusCode,
  }) : this._(
         result: ApiResult.failure,
         data: data,
         message: message,
         statusCode: statusCode,
       );

  const NetworkClientModel.networkError({
    String message =
        'No internet connection. Please check your network settings.',
  }) : this._(
         result: ApiResult.networkError,
         data: null,
         message: message,
         statusCode: null,
       );

  const NetworkClientModel.timeoutError({
    String message = 'Request timed out. Please try again.',
  }) : this._(
         result: ApiResult.timeoutError,
         data: null,
         message: message,
         statusCode: null,
       );

  const NetworkClientModel.unexpectedError({
    String message = 'An unexpected error occurred. Please try again.',
  }) : this._(
         result: ApiResult.unexpectedError,
         data: null,
         message: message,
         statusCode: null,
       );

  const NetworkClientModel.formatError({
    String message = 'Invalid response format received from server.',
  }) : this._(
         result: ApiResult.formatError,
         data: null,
         message: message,
         statusCode: null,
       );

  bool get isSuccess => result == ApiResult.success;
  bool get isFailure => result == ApiResult.failure;
  bool get isNetworkError => result == ApiResult.networkError;
  bool get isTimeoutError => result == ApiResult.timeoutError;
  bool get isUnexpectedError => result == ApiResult.unexpectedError;
  bool get isFormatError => result == ApiResult.formatError;

  T? dataOrNull<T>() => isSuccess ? data as T? : null;

  String get errorMessage => isSuccess ? '' : message;

  int? get statusCodeOrNull => statusCode;

  @override
  String toString() {
    return 'BaseClientModel(result: $result, message: $message, statusCode: $statusCode, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NetworkClientModel &&
        other.result == result &&
        other.data == data &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode {
    return result.hashCode ^
        data.hashCode ^
        message.hashCode ^
        statusCode.hashCode;
  }
}
