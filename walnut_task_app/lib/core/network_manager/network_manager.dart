import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:walnut_task_app/core/enums/enums.dart';
import 'package:walnut_task_app/core/exception/unauthorized_exception.dart';
import 'package:walnut_task_app/core/services/token_service.dart';

//post get delete update for database operations
class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();

  static NetworkManager get instance => _instance;

  NetworkManager._init();


  Future<T> postRequest<T>({
    required String baseUrl,
    required Map<String, dynamic> input,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(input),
    );

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    return fromJson(jsonBody);
  }

  Future<T> postRequestwithJwtToken<T>({
    required String baseUrl,
    required Map<String, dynamic> input,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse(baseUrl);
    final String? token = await TokenService.instance.getToken();

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(input),
    );

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    return fromJson(jsonBody);
  }
  Future<T> putRequestwithJwtToken<T>({
    required String baseUrl,
    required Map<String, dynamic> input,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse(baseUrl);
    final String? token = await TokenService.instance.getToken();

    final response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(input),
    );

    final Map<String, dynamic> jsonBody = json.decode(response.body);

    return fromJson(jsonBody);
  }

  Future<T> getRequest<T>({
    required String baseUrl,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final url = Uri.parse(baseUrl);
    final String? token = await TokenService.instance.getToken();
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == ApiStatusCode.ok.code) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      return fromJson(jsonBody);
    } else if (response.statusCode == ApiStatusCode.unauthorized.code ||
        response.statusCode == ApiStatusCode.forbidden.code) {
      throw UnauthorizedException();
    } else if (response.statusCode == ApiStatusCode.notFound.code) {
      throw Exception('Resource not found');
    } else {
      throw Exception('Error occurred with status code ${response.statusCode}');
    }
  }

  Future<ApiResponseStatus> deleteRequest({
    required String baseUrl,
  }) async {
    final url = Uri.parse(baseUrl);
    final String? token = await TokenService.instance.getToken();
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == ApiStatusCode.ok.code) {
      return ApiResponseStatus.success;
    } else if (response.statusCode == ApiStatusCode.unauthorized.code ||
        response.statusCode == ApiStatusCode.forbidden.code) {
      throw UnauthorizedException();
    } else if (response.statusCode == ApiStatusCode.notFound.code) {
      throw Exception('Resource not found');
    } else {
      throw Exception('Error occurred with status code ${response.statusCode}');
    }
  }
}
