import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json'},
      extra: {'withCredentials': true},
    ),
  );
}
