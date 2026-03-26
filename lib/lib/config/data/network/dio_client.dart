import 'package:dio/dio.dart';

import '../../../service/sessionManager/session_controller.dart';

class DioClient {
  DioClient._();

  static final Dio dio =
      Dio(BaseOptions(headers: {'Content-Type': 'application/json'}))
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              await SessionController().getUserFromPreference();
              final token = SessionController().user?.accessToken;

              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }

              return handler.next(options);
            },
          ),
        );
}
