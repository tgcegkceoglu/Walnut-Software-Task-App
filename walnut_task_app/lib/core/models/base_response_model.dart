// Common model of success code message errors coming from backend
class BaseResponseModel<T> { 
  final bool? success;
  final String? message;
  final T? data;
  final String? error;

  BaseResponseModel({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json, [
    T Function(dynamic json)? fromJsonT,
  ]) {
    return BaseResponseModel<T>(
      success: json['success'],
      message: json['message'],
      data: (json['data'] != null && fromJsonT != null) ? fromJsonT(json['data']) : null,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson([
    dynamic Function(T data)? toJsonT,
  ]) {
    return {
      'success': success,
      'message': message,
      'data': (data != null && toJsonT != null) ? toJsonT(data as T) : null,
      'error': error,
    };
  }
}
