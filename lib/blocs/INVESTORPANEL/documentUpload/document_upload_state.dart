part of 'document_upload_bloc.dart';

class DocumentUploadState extends Equatable {
  final UploadStatus panStatus;
  final UploadStatus aadhaarFrontStatus;
  final UploadStatus aadhaarBackStatus;
  final UploadStatus selfieStatus;
  final String? panFileUrl;
  final String? aadhaarFrontFileUrl;
  final String? aadhaarBackFileUrl;
  final String? selfieFileUrl;
  final String? errorMessage;

  const DocumentUploadState({
    this.panStatus = UploadStatus.initial,
    this.aadhaarFrontStatus = UploadStatus.initial,
    this.aadhaarBackStatus = UploadStatus.initial,
    this.selfieStatus = UploadStatus.initial,
    this.panFileUrl,
    this.aadhaarFrontFileUrl,
    this.aadhaarBackFileUrl,
    this.selfieFileUrl,
    this.errorMessage,
  });

  DocumentUploadState copyWith({
    UploadStatus? panStatus,
    UploadStatus? aadhaarFrontStatus,
    UploadStatus? aadhaarBackStatus,
    UploadStatus? selfieStatus,
    String? panFileUrl,
    String? aadhaarFrontFileUrl,
    String? aadhaarBackFileUrl,
    String? selfieFileUrl,
    String? errorMessage,
  }) {
    return DocumentUploadState(
      panStatus: panStatus ?? this.panStatus,
      aadhaarFrontStatus: aadhaarFrontStatus ?? this.aadhaarFrontStatus,
      aadhaarBackStatus: aadhaarBackStatus ?? this.aadhaarBackStatus,
      selfieStatus: selfieStatus ?? this.selfieStatus,
      panFileUrl: panFileUrl ?? this.panFileUrl,
      aadhaarFrontFileUrl: aadhaarFrontFileUrl ?? this.aadhaarFrontFileUrl,
      aadhaarBackFileUrl: aadhaarBackFileUrl ?? this.aadhaarBackFileUrl,
      selfieFileUrl: selfieFileUrl ?? this.selfieFileUrl,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isAllDocumentsUploaded {
    return panStatus == UploadStatus.completed &&
        aadhaarFrontStatus == UploadStatus.completed &&
        aadhaarBackStatus == UploadStatus.completed &&
        selfieStatus == UploadStatus.completed;
  }

  @override
  List<Object?> get props => [
    panStatus,
    aadhaarFrontStatus,
    aadhaarBackStatus,
    selfieStatus,
    panFileUrl,
    aadhaarFrontFileUrl,
    aadhaarBackFileUrl,
    selfieFileUrl,
    errorMessage,
  ];
}

enum UploadStatus {
  initial,
  loading,
  completed,
  error,
}