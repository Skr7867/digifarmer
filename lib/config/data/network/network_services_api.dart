import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../exception/app_exception.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;
import 'dio_client.dart';

class NetworkApiServices extends BaseApiServices {
  void apiLog(String tag, dynamic message) {
    if (kDebugMode) {
      log("$tag => $message");
    }
  }

  String extractMessage(dynamic data, int statusCode) {
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    if (data is String) {
      return data;
    }
    return "Error: $statusCode";
  }

  /// 🔥 GET API
  @override
  Future<dynamic> getApi(String url, {String? token}) async {
    try {
      apiLog("GET URL", url);
      apiLog("GET TOKEN", token);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );

      apiLog("GET STATUS", response.statusCode);
      apiLog("GET RESPONSE", response.body);

      return returnResponse(response);
    } on SocketException {
      throw InternetException();
    }
  }

  /// 🔥 POST API
  @override
  Future<dynamic> postApi(
    dynamic data,
    String url, {
    String? token,
    bool isFileUpload = false,
  }) async {
    try {
      apiLog("POST URL", url);
      apiLog("POST DATA", data);
      apiLog("POST TOKEN", token);

      final response = await DioClient.dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      apiLog("POST STATUS", response.statusCode);
      apiLog("POST RESPONSE", response.data);

      return response.data;
    } on DioException catch (e) {
      apiLog("POST ERROR STATUS", e.response?.statusCode);
      apiLog("POST ERROR DATA", e.response?.data);

      final statusCode = e.response?.statusCode ?? 500;
      final resData = e.response?.data;

      final message = extractMessage(resData, statusCode);

      if (statusCode >= 500) {
        throw ServerException(message);
      } else {
        throw FetchDataException(message);
      }
    }
  }

  /// 🔥 PATCH API
  @override
  Future<dynamic> patchApi(
    Map<String, dynamic> data,
    String url, {
    String? token,
  }) async {
    try {
      apiLog("PATCH URL", url);
      apiLog("PATCH DATA", data);

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );

      apiLog("PATCH STATUS", response.statusCode);
      apiLog("PATCH RESPONSE", response.body);

      return returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet');
    }
  }

  /// 🔥 DELETE API
  @override
  Future<dynamic> deleteApi(String url, {String? token}) async {
    try {
      apiLog("DELETE URL", url);

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );

      apiLog("DELETE STATUS", response.statusCode);
      apiLog("DELETE RESPONSE", response.body);

      return returnResponse(response);
    } on SocketException {
      throw InternetException('No Internet');
    }
  }

  /// 🔥 RESPONSE PARSER
  dynamic returnResponse(http.Response response) {
    apiLog("RETURN STATUS", response.statusCode);
    apiLog("RETURN BODY", response.body);

    dynamic responseJson;

    if (response.body.isNotEmpty) {
      try {
        responseJson = jsonDecode(response.body);
      } catch (_) {
        throw FetchDataException("Invalid response (${response.statusCode})");
      }
    }

    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return responseJson;

      case 400:
      case 401:
      case 403:
      case 404:
        throw FetchDataException(
          extractMessage(responseJson, response.statusCode),
        );

      case 500:
      case 502:
      case 503:
        throw ServerException(
          extractMessage(responseJson, response.statusCode),
        );

      default:
        throw FetchDataException("Unexpected error ${response.statusCode}");
    }
  }
}
