import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:digifarmer/repository/INVESTORPANEL/documentUpload/document_upload_repository.dart';

import '../../../model/INVESTORPANEL/uploadDocuments/upload_response_model.dart';

part 'document_upload_event.dart';
part 'document_upload_state.dart';

class DocumentUploadBloc extends Bloc<DocumentUploadEvent, DocumentUploadState> {
  final DocumentUploadRepository repository;

  DocumentUploadBloc({required this.repository}) : super(const DocumentUploadState()) {
    on<UploadPanCard>(_uploadPanCard);
    on<UploadAadhaarFront>(_uploadAadhaarFront);
    on<UploadAadhaarBack>(_uploadAadhaarBack);
    on<UploadSelfie>(_uploadSelfie);
    on<ResetUploadStatus>(_resetUploadStatus);
  }

  Future<void> _uploadPanCard(
    UploadPanCard event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(state.copyWith(panStatus: UploadStatus.loading, errorMessage: null));
    await _uploadDocument(
      event.file,
      'pan_card.jpg',
      'image/jpeg',
      null,
      (response) => emit(state.copyWith(
        panStatus: UploadStatus.completed,
        panFileUrl: response.fileUrl,
      )),
      () => emit(state.copyWith(panStatus: UploadStatus.error)),
    );
  }

  Future<void> _uploadAadhaarFront(
    UploadAadhaarFront event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(state.copyWith(aadhaarFrontStatus: UploadStatus.loading, errorMessage: null));
    await _uploadDocument(
      event.file,
      'aadhaar_front.jpg',
      'image/jpeg',
      'front',
      (response) => emit(state.copyWith(
        aadhaarFrontStatus: UploadStatus.completed,
        aadhaarFrontFileUrl: response.fileUrl,
      )),
      () => emit(state.copyWith(aadhaarFrontStatus: UploadStatus.error)),
    );
  }

  Future<void> _uploadAadhaarBack(
    UploadAadhaarBack event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(state.copyWith(aadhaarBackStatus: UploadStatus.loading, errorMessage: null));
    await _uploadDocument(
      event.file,
      'aadhaar_back.jpg',
      'image/jpeg',
      'back',
      (response) => emit(state.copyWith(
        aadhaarBackStatus: UploadStatus.completed,
        aadhaarBackFileUrl: response.fileUrl,
      )),
      () => emit(state.copyWith(aadhaarBackStatus: UploadStatus.error)),
    );
  }

  Future<void> _uploadSelfie(
    UploadSelfie event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(state.copyWith(selfieStatus: UploadStatus.loading, errorMessage: null));
    await _uploadDocument(
      event.file,
      'selfie.jpg',
      'image/jpeg',
      null,
      (response) => emit(state.copyWith(
        selfieStatus: UploadStatus.completed,
        selfieFileUrl: response.fileUrl,
      )),
      () => emit(state.copyWith(selfieStatus: UploadStatus.error)),
    );
  }

  Future<void> _uploadDocument(
    File file,
    String fileName,
    String fileType,
    String? side,
    Function(UploadResponseModel) onSuccess,
    Function() onError,
  ) async {
    try {
      // Step 1: Get upload URL from backend
      final uploadResponse = await repository.getUploadUrl(fileName, fileType, side: side);
      
      if (!uploadResponse.success || uploadResponse.uploadUrl == null) {
        onError();
        return;
      }

      // Step 2: Upload file to S3
      final uploadSuccess = await repository.uploadToS3(uploadResponse.uploadUrl!, file);
      
      if (uploadSuccess) {
        onSuccess(uploadResponse);
      } else {
        onError();
      }
    } catch (error, stackTrace) {
      log('Error uploading document: $error');
      log(stackTrace.toString());
      onError();
    }
  }

  void _resetUploadStatus(
    ResetUploadStatus event,
    Emitter<DocumentUploadState> emit,
  ) {
    switch (event.documentType) {
      case 'pan':
        emit(state.copyWith(panStatus: UploadStatus.initial, panFileUrl: null));
        break;
      case 'aadhaar_front':
        emit(state.copyWith(aadhaarFrontStatus: UploadStatus.initial, aadhaarFrontFileUrl: null));
        break;
      case 'aadhaar_back':
        emit(state.copyWith(aadhaarBackStatus: UploadStatus.initial, aadhaarBackFileUrl: null));
        break;
      case 'selfie':
        emit(state.copyWith(selfieStatus: UploadStatus.initial, selfieFileUrl: null));
        break;
    }
  }
}