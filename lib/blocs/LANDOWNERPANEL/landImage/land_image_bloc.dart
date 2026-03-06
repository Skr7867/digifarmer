// blocs/LANDOWNERPANEL/landImages/land_images_bloc.dart

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/confirm_upload_response.dart';
import '../../../model/LANDOWNERSPANEL/preSignedUrlRequest/presigned_url_request_model.dart';
import '../../../repository/LANDOWNERPANEL/landImage/land_image_repository.dart';

part 'land_image_event.dart';
part 'land_image_state.dart';

class LandImagesBloc extends Bloc<LandImagesEvent, LandImagesState> {
  final LandImagesRepository landImagesRepository;

  LandImagesBloc(this.landImagesRepository) : super(const LandImagesState()) {
    on<SetTempId>(_onSetTempId);
    on<AddLandImage>(_onAddLandImage);
    on<RemoveLandImage>(_onRemoveLandImage);
    on<GeneratePresignedUrls>(_onGeneratePresignedUrls);
    on<UploadFilesToS3>(_onUploadFilesToS3);
    on<ConfirmUpload>(_onConfirmUpload);
    on<ResetLandImagesState>(_onReset);
  }

  void _onSetTempId(SetTempId event, Emitter<LandImagesState> emit) {
    emit(state.copyWith(tempId: event.tempId));
  }

  void _onAddLandImage(AddLandImage event, Emitter<LandImagesState> emit) {
    final updatedImages = List<LandImageFile?>.from(state.landImages);

    final landImageFile = LandImageFile(
      fileName: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      fileType: 'image/jpeg',
      file: event.imageFile,
    );

    updatedImages[event.index] = landImageFile;

    emit(state.copyWith(landImages: updatedImages));
  }

  void _onRemoveLandImage(
    RemoveLandImage event,
    Emitter<LandImagesState> emit,
  ) {
    final updatedImages = List<LandImageFile?>.from(state.landImages);
    updatedImages[event.index] = null;

    emit(state.copyWith(landImages: updatedImages));
  }

  Future<void> _onGeneratePresignedUrls(
    GeneratePresignedUrls event,
    Emitter<LandImagesState> emit,
  ) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      // Filter out null images
      final nonNullImages = state.landImages
          .where((img) => img != null)
          .map((img) => img!)
          .toList();

      if (nonNullImages.isEmpty) {
        emit(
          state.copyWith(
            message: 'Please add at least one image',
            postApiStatus: PostApiStatus.error,
          ),
        );
        return;
      }

      // Create request (documents array can be empty for now)
      final request = PresignedUrlRequest(
        tempId: state.tempId,
        landImages: nonNullImages,
        documents: [], // Add documents if needed
      );

      final response = await landImagesRepository.getPresignedUrls(request);

      if (response.success) {
        emit(
          state.copyWith(
            presignedData: [response.data],
            message: response.message,
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message,
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (e) {
      log("❌ Generate presigned URLs error: $e");
      emit(
        state.copyWith(
          message: e.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }

  Future<void> _onUploadFilesToS3(
    UploadFilesToS3 event,
    Emitter<LandImagesState> emit,
  ) async {
    if (state.presignedData.isEmpty) {
      emit(
        state.copyWith(
          message: 'Generate presigned URLs first',
          postApiStatus: PostApiStatus.error,
        ),
      );
      return;
    }

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      final presignedData = state.presignedData.first;
      final nonNullImages = state.landImages
          .where((img) => img != null)
          .toList();

      Map<int, bool> uploadStatus = {};
      int successCount = 0;

      // Upload each image to its corresponding presigned URL
      for (int i = 0; i < nonNullImages.length; i++) {
        final image = nonNullImages[i];
        if (image?.file != null && i < presignedData!.landImages.length) {
          final presigned = presignedData.landImages[i];
          final success = await landImagesRepository.uploadFileToS3(
            presigned.uploadUrl,
            image!.file!,
          );

          uploadStatus[i] = success;
          if (success) successCount++;
        }
      }

      final allComplete = successCount == nonNullImages.length;

      emit(
        state.copyWith(
          uploadStatus: uploadStatus,
          totalUploadedCount: successCount,
          allUploadsComplete: allComplete,
          postApiStatus: PostApiStatus.success,
          message: allComplete
              ? 'All files uploaded successfully'
              : 'Some files failed to upload',
        ),
      );
    } catch (e) {
      log("❌ Upload to S3 error: $e");
      emit(
        state.copyWith(
          message: e.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }

  Future<void> _onConfirmUpload(
    ConfirmUpload event,
    Emitter<LandImagesState> emit,
  ) async {
    if (!state.allUploadsComplete || state.presignedData.isEmpty) {
      emit(
        state.copyWith(
          message: 'Complete all uploads first',
          postApiStatus: PostApiStatus.error,
        ),
      );
      return;
    }

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      final presignedData = state.presignedData.first;
      final nonNullImages = state.landImages
          .where((img) => img != null)
          .toList();

      // Prepare uploaded images list
      final uploadedImages = <UploadedImage>[];
      for (int i = 0; i < nonNullImages.length; i++) {
        if (i < presignedData!.landImages.length) {
          final presigned = presignedData.landImages[i];
          uploadedImages.add(
            UploadedImage(
              fileKey: presigned.fileKey,
              fileUrl: presigned.fileUrl,
              imageType: _getImageTypeFromIndex(i).value,
              description: _getDescriptionFromIndex(i),
            ),
          );
        }
      }

      final request = ConfirmUploadRequest(
        tempId: state.tempId,
        uploadedImages: uploadedImages,
        uploadedDocuments: [], // Add documents if needed
      );

      final response = await landImagesRepository.confirmUpload(request);

      if (response.success) {
        emit(
          state.copyWith(
            confirmResponse: response,
            message: response.message,
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message,
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (e) {
      log("❌ Confirm upload error: $e");
      emit(
        state.copyWith(
          message: e.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }

  void _onReset(ResetLandImagesState event, Emitter<LandImagesState> emit) {
    emit(const LandImagesState());
  }

  // Helper methods
  ImageType _getImageTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return ImageType.FRONT_VIEW;
      case 1:
        return ImageType.LANDSCAPE;
      case 2:
        return ImageType.ROAD_ACCESS;
      case 3:
        return ImageType.SOIL_QUALITY;
      case 4:
        return ImageType.WATER_SOURCE;
      case 5:
        return ImageType.BOUNDARY;
      case 6:
      default:
        return ImageType.FRONT_VIEW;
    }
  }

  String _getDescriptionFromIndex(int index) {
    const descriptions = [
      'Front view of land',
      'Landscape view',
      'Road access point',
      'Soil quality',
      'Water source',
      'Boundary markers',
      'Extra view',
    ];
    return index < descriptions.length ? descriptions[index] : 'Land image';
  }
}
