part of 'document_upload_bloc.dart';

abstract class DocumentUploadEvent extends Equatable {
  const DocumentUploadEvent();

  @override
  List<Object> get props => [];
}

class UploadPanCard extends DocumentUploadEvent {
  final File file;
  const UploadPanCard({required this.file});

  @override
  List<Object> get props => [file];
}

class UploadAadhaarFront extends DocumentUploadEvent {
  final File file;
  const UploadAadhaarFront({required this.file});

  @override
  List<Object> get props => [file];
}

class UploadAadhaarBack extends DocumentUploadEvent {
  final File file;
  const UploadAadhaarBack({required this.file});

  @override
  List<Object> get props => [file];
}

class UploadSelfie extends DocumentUploadEvent {
  final File file;
  const UploadSelfie({required this.file});

  @override
  List<Object> get props => [file];
}

class ResetUploadStatus extends DocumentUploadEvent {
  final String documentType;
  const ResetUploadStatus({required this.documentType});

  @override
  List<Object> get props => [documentType];
}