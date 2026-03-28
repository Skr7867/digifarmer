import 'dart:io';
import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/repository/INVESTORPANEL/documentUpload/document_upload_repository.dart';
import 'package:http/http.dart' as http;

import '../../../model/INVESTORPANEL/uploadDocuments/upload_response_model.dart';

class DocumentUploadHttpRepository implements DocumentUploadRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<UploadResponseModel> getUploadUrl(
    String fileName,
    String fileType, {
    String? side,
  }) async {
    final Map<String, dynamic> data = {
      'fileName': fileName,
      'fileType': fileType,
    };
    
    if (side != null) {
      data['side'] = side;
    }

    String endpoint;
    if (fileName.contains('pan')) {
      endpoint = ApiUrls.uploadPanUrl;
    } else if (fileName.contains('aadhaar')) {
      endpoint = ApiUrls.uploadAadhaarUrl;
    } else {
      endpoint = ApiUrls.uploadSelfieUrl;
    }

    final response = await _apiServices.postApi(data, endpoint);
    return UploadResponseModel.fromJson(response);
  }

  @override
  Future<bool> uploadToS3(String uploadUrl, File file) async {
    try {
      final fileBytes = await file.readAsBytes();
      final response = await http.put(
        Uri.parse(uploadUrl),
        headers: {
          'Content-Type': 'image/jpeg',
        },
        body: fileBytes,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}