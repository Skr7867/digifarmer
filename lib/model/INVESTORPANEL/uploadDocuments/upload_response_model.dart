class UploadResponseModel {
  final bool success;
  final String? uploadUrl;
  final String? fileKey;
  final String? fileUrl;
  final String? message;

  UploadResponseModel({
    required this.success,
    this.uploadUrl,
    this.fileKey,
    this.fileUrl,
    this.message,
  });

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      success: json['success'] ?? false,
      uploadUrl: json['uploadUrl'],
      fileKey: json['fileKey'],
      fileUrl: json['fileUrl'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'uploadUrl': uploadUrl,
      'fileKey': fileKey,
      'fileUrl': fileUrl,
      'message': message,
    };
  }
}