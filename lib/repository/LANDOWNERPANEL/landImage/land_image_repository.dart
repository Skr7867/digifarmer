import 'dart:io';

import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/confirm_upload_response.dart';
import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/presigned_url_request_model.dart';

abstract class LandImagesRepository {
  Future<PresignedUrlResponse> getPresignedUrls(PresignedUrlRequest request);
  Future<ConfirmUploadResponse> confirmUpload(ConfirmUploadRequest request);
  Future<bool> uploadFileToS3(String uploadUrl, File file);
}
