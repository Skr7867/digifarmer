

import 'dart:io';

import '../../../model/INVESTORPANEL/uploadDocuments/upload_response_model.dart';

abstract class DocumentUploadRepository {
  Future<UploadResponseModel> getUploadUrl(String fileName, String fileType, {String? side});
  Future<bool> uploadToS3(String uploadUrl, File file);
}