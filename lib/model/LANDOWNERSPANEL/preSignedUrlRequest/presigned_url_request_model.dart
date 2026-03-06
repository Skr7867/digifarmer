import 'dart:io';

// Request Model for Presigned URLs
class PresignedUrlRequest {
  final String tempId;
  final List<LandImageFile> landImages;
  final List<DocumentFile> documents;

  PresignedUrlRequest({
    required this.tempId,
    required this.landImages,
    required this.documents,
  });

  Map<String, dynamic> toJson() {
    return {
      'tempId': tempId,
      'landImages': landImages.map((e) => e.toJson()).toList(),
      'documents': documents.map((e) => e.toJson()).toList(),
    };
  }
}

class LandImageFile {
  final String fileName;
  final String fileType;
  final File? file; // Local file for upload

  LandImageFile({required this.fileName, required this.fileType, this.file});

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'fileType': fileType};
  }
}

class DocumentFile {
  final String fileName;
  final String fileType;
  final File? file;

  DocumentFile({required this.fileName, required this.fileType, this.file});

  Map<String, dynamic> toJson() {
    return {'fileName': fileName, 'fileType': fileType};
  }
}

// Response Model for Presigned URLs
class PresignedUrlResponse {
  final bool success;
  final String message;
  final PresignedUrlData data;

  PresignedUrlResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PresignedUrlResponse.fromJson(Map<String, dynamic> json) {
    return PresignedUrlResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PresignedUrlData.fromJson(json['data']),
    );
  }
}

class PresignedUrlData {
  final String tempId;
  final List<LandImagePresigned> landImages;
  final List<DocumentPresigned> documents;
  final int expiresIn;
  final int currentStep;
  final String nextStep;

  PresignedUrlData({
    required this.tempId,
    required this.landImages,
    required this.documents,
    required this.expiresIn,
    required this.currentStep,
    required this.nextStep,
  });

  factory PresignedUrlData.fromJson(Map<String, dynamic> json) {
    return PresignedUrlData(
      tempId: json['tempId'] ?? '',
      landImages: (json['landImages'] as List? ?? [])
          .map((e) => LandImagePresigned.fromJson(e))
          .toList(),
      documents: (json['documents'] as List? ?? [])
          .map((e) => DocumentPresigned.fromJson(e))
          .toList(),
      expiresIn: json['expiresIn'] ?? 0,
      currentStep: json['currentStep'] ?? 0,
      nextStep: json['nextStep'] ?? '',
    );
  }
}

class LandImagePresigned {
  final String uploadUrl;
  final String fileKey;
  final String fileUrl;
  final String fileName;

  LandImagePresigned({
    required this.uploadUrl,
    required this.fileKey,
    required this.fileUrl,
    required this.fileName,
  });

  factory LandImagePresigned.fromJson(Map<String, dynamic> json) {
    return LandImagePresigned(
      uploadUrl: json['uploadUrl'] ?? '',
      fileKey: json['fileKey'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileName: json['fileName'] ?? '',
    );
  }
}

class DocumentPresigned {
  final String uploadUrl;
  final String fileKey;
  final String fileUrl;
  final String fileName;

  DocumentPresigned({
    required this.uploadUrl,
    required this.fileKey,
    required this.fileUrl,
    required this.fileName,
  });

  factory DocumentPresigned.fromJson(Map<String, dynamic> json) {
    return DocumentPresigned(
      uploadUrl: json['uploadUrl'] ?? '',
      fileKey: json['fileKey'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileName: json['fileName'] ?? '',
    );
  }
}

// Confirm Upload Request Model
class ConfirmUploadRequest {
  final String tempId;
  final List<UploadedImage> uploadedImages;
  final List<UploadedDocument> uploadedDocuments;

  ConfirmUploadRequest({
    required this.tempId,
    required this.uploadedImages,
    required this.uploadedDocuments,
  });

  Map<String, dynamic> toJson() {
    return {
      'tempId': tempId,
      'uploadedImages': uploadedImages.map((e) => e.toJson()).toList(),
      'uploadedDocuments': uploadedDocuments.map((e) => e.toJson()).toList(),
    };
  }
}

class UploadedImage {
  final String fileKey;
  final String fileUrl;
  final String imageType;
  final String description;

  UploadedImage({
    required this.fileKey,
    required this.fileUrl,
    required this.imageType,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileKey': fileKey,
      'fileUrl': fileUrl,
      'imageType': imageType,
      'description': description,
    };
  }
}

class UploadedDocument {
  final String fileKey;
  final String fileUrl;
  final String documentType;
  final String fileName;

  UploadedDocument({
    required this.fileKey,
    required this.fileUrl,
    required this.documentType,
    required this.fileName,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileKey': fileKey,
      'fileUrl': fileUrl,
      'documentType': documentType,
      'fileName': fileName,
    };
  }
}
