class DocumentUploadModel {
  final String fileName;
  final String fileType;
  final String? side; // For Aadhaar front/back

  DocumentUploadModel({
    required this.fileName,
    required this.fileType,
    this.side,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'fileName': fileName,
      'fileType': fileType,
    };
    if (side != null) {
      data['side'] = side;
    }
    return data;
  }
}