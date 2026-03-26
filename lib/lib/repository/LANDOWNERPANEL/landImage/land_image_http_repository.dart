// repository/LANDOWNERPANEL/landImages/land_images_http_repository.dart

import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../config/apiUrls/api_urls.dart';
import '../../../config/data/network/network_services_api.dart';
import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/confirm_upload_response.dart';
import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/presigned_url_request_model.dart';
import '../../../service/sessionManager/session_controller.dart';
import 'land_image_repository.dart';

class LandImagesHttpRepository implements LandImagesRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<PresignedUrlResponse> getPresignedUrls(
    PresignedUrlRequest request,
  ) async {
    log("📸 Getting presigned URLs");
    log("📦 Request: ${request.toJson()}");

    await SessionController().getUserFromPreference();
    final token = SessionController().user?.accessToken;

    try {
      final response = await _apiServices.postApi(
        request.toJson(),
        ApiUrls.presignedUrlsApi,
        token: token,
      );

      log("✅ Presigned URLs response: $response");
      return PresignedUrlResponse.fromJson(response);
    } catch (e) {
      log("❌ Error getting presigned URLs: $e");
      rethrow;
    }
  }

  @override
  Future<bool> uploadFileToS3(String uploadUrl, File file) async {
    try {
      log("📤 Uploading file to S3: ${file.path}");

      final bytes = await file.readAsBytes();

      final response = await http.put(
        Uri.parse(uploadUrl),
        body: bytes,
        headers: {
          'Content-Type': 'image/jpeg', // Adjust based on file type
        },
      );

      log("📤 S3 Upload Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        log("✅ File uploaded successfully");
        return true;
      } else {
        log("❌ S3 Upload failed: ${response.body}");
        return false;
      }
    } catch (e) {
      log("❌ Error uploading to S3: $e");
      return false;
    }
  }

  @override
  Future<ConfirmUploadResponse> confirmUpload(
    ConfirmUploadRequest request,
  ) async {
    log("✅ Confirming upload");
    log("📦 Confirm request: ${request.toJson()}");

    await SessionController().getUserFromPreference();
    final token = SessionController().user?.accessToken;

    try {
      final response = await _apiServices.postApi(
        request.toJson(),
        ApiUrls.confirmUploadApi,
        token: token,
      );

      log("✅ Confirm upload response: $response");
      return ConfirmUploadResponse.fromJson(response);
    } catch (e) {
      log("❌ Error confirming upload: $e");
      rethrow;
    }
  }
}
