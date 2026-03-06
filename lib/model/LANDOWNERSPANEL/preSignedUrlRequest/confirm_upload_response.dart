class ConfirmUploadResponse {
  final bool success;
  final String message;
  final LandData? land;

  ConfirmUploadResponse({
    required this.success,
    required this.message,
    this.land,
  });

  factory ConfirmUploadResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmUploadResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      land: json['land'] != null ? LandData.fromJson(json['land']) : null,
    );
  }
}

class LandData {
  final String id;
  final String title;
  final String status;
  final String ownerId;
  final String createdBy;
  final String createdByRole;
  final int imagesCount;
  final int documentsCount;

  LandData({
    required this.id,
    required this.title,
    required this.status,
    required this.ownerId,
    required this.createdBy,
    required this.createdByRole,
    required this.imagesCount,
    required this.documentsCount,
  });

  factory LandData.fromJson(Map<String, dynamic> json) {
    return LandData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      ownerId: json['ownerId'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdByRole: json['createdByRole'] ?? '',
      imagesCount: json['imagesCount'] ?? 0,
      documentsCount: json['documentsCount'] ?? 0,
    );
  }
}

// Enum for Image Types
enum ImageType {
  FRONT_VIEW,
  LANDSCAPE,
  ROAD_ACCESS,
  SOIL_QUALITY,
  WATER_SOURCE,
  BOUNDARY,
  ADDITIONAL_VIEW,
  EXTRA;

  String get value {
    switch (this) {
      case ImageType.FRONT_VIEW:
        return 'FRONT_VIEW';
      case ImageType.LANDSCAPE:
        return 'LANDSCAPE';
      case ImageType.ROAD_ACCESS:
        return 'ROAD_ACCESS';
      case ImageType.SOIL_QUALITY:
        return 'SOIL_QUALITY';
      case ImageType.WATER_SOURCE:
        return 'WATER_SOURCE';
      case ImageType.BOUNDARY:
        return 'BOUNDARY';
      case ImageType.ADDITIONAL_VIEW:
        return 'ADDITIONAL_VIEW';
      case ImageType.EXTRA:
        return 'EXTRA';
    }
  }
}
