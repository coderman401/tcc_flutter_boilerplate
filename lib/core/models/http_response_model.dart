import 'dart:convert';

CustomHttpResponse responseFromJson(String str) =>
    CustomHttpResponse.fromJson(json.decode(str));

String responseToJson(CustomHttpResponse data) => json.encode(data.toJson());

class CustomHttpResponse {
  CustomHttpResponse(
      {this.status, this.error, this.errors, this.message, this.data});

  bool? status;
  dynamic errors;
  String? error;
  String? message;
  dynamic data;

  factory CustomHttpResponse.fromJson(Map<String, dynamic> json) {
    return CustomHttpResponse(
      status: json['status'],
      error: json['error'],
      errors: json['errors'],
      message: json['message'],
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'error': error,
        'errors': errors,
        'message': message,
        'data': jsonEncode(data),
      };
}
