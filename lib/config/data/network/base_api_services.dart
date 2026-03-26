// In base_api_services.dart

abstract class BaseApiServices {
  Future<dynamic> getApi(String url, {String? token});
  Future<dynamic> postApi(dynamic data, String url, {String? token});
  Future<dynamic> putApi(dynamic data, String url, {String? token}); // Add this
  Future<dynamic> patchApi(
    Map<String, dynamic> data,
    String url, {
    String? token,
  });
  Future<dynamic> deleteApi(String url, {String? token});
}
