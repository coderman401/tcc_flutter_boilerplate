// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tcc_flutter_boilerplate/core/models/http_response_model.dart';
import 'package:tcc_flutter_boilerplate/core/utils/constants/app_constants.dart';

enum Flavor { LOCAL, PROD }

class ApiService {
  static final ApiService _apiService = ApiService._internal();
  static late Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  final String _apiUrl =
      _flavor == Flavor.LOCAL ? AppConstants.localAPI : AppConstants.prodAPI;

  factory ApiService() {
    return _apiService;
  }

  ApiService._internal();

  Future<dynamic> getRequest(String path,
      {Map<String, String>? queryParams, Map<String, String>? headers}) async {
    String query = '';
    try {
      if (queryParams != null) {
        query = _generateQueryParams(queryParams);
      }
      final uri = Uri.parse(_apiUrl + path + query);
      http.Response response = await http.get(uri, headers: headers);
      Map<String, dynamic> body = json.decode(response.body);
      final statusCode = response.statusCode;
      if (body.containsKey('status')) {
        return CustomHttpResponse.fromJson(body);
      } else {
        return ApiResponseException(
            'An Error occurred [Status Code: $statusCode]');
      }
    } catch (_, e) {
      print(e);
      return ApiResponseException('Unknown Error...');
    }
  }

  Future<dynamic> postRequest(String path,
      {Map<String, dynamic>? payload,
      Map<String, String>? queryParams,
      Map<String, String>? headers}) async {
    try {
      String query = '';
      if (queryParams != null) {
        query = _generateQueryParams(queryParams);
      }
      final uri = Uri.parse(_apiUrl + path + query);
      (uri);
      http.Response response =
          await http.post(uri, body: payload, headers: headers);
      Map<String, dynamic> body = json.decode(response.body) ?? {};
      final statusCode = response.statusCode;
      if (body.containsKey('status')) {
        return CustomHttpResponse.fromJson(body);
      } else {
        return ApiResponseException(
            'An Error occurred [Status Code: $statusCode]');
      }
    } catch (_, e) {
      print(e);
      return ApiResponseException('Unknown Error...');
    }
  }

  _generateQueryParams(Map<String, String> params) {
    String query = '?';
    int i = 0;
    // params
    params.forEach((key, value) {
      if (i == params.length - 1) {
        query += '$key=$value';
      } else {
        query += '$key=$value&';
      }
      i++;
    });

    return query;
  }
}

class ApiResponseException implements Exception {
  final String? message;

  ApiResponseException([this.message]);

  @override
  String toString() {
    if (message == null) return 'Exception';
    return 'Exception: $message';
  }
}
