// blocs/LANDOWNERPANEL/landImages/land_images_state.dart

part of 'land_image_bloc.dart';

class LandImagesState extends Equatable {
  final String tempId;
  final List<LandImageFile?> landImages; // 8 slots, some may be null
  final List<PresignedUrlData?> presignedData;
  final Map<int, bool> uploadStatus; // Track upload success per index
  final int totalUploadedCount;
  final bool allUploadsComplete;
  final ConfirmUploadResponse? confirmResponse;
  final String message;
  final PostApiStatus postApiStatus;

  const LandImagesState({
    this.tempId = '',
    this.landImages = const [null, null, null, null, null, null, null, null],
    this.presignedData = const [],
    this.uploadStatus = const {},
    this.totalUploadedCount = 0,
    this.allUploadsComplete = false,
    this.confirmResponse,
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  LandImagesState copyWith({
    String? tempId,
    List<LandImageFile?>? landImages,
    List<PresignedUrlData?>? presignedData,
    Map<int, bool>? uploadStatus,
    int? totalUploadedCount,
    bool? allUploadsComplete,
    ConfirmUploadResponse? confirmResponse,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return LandImagesState(
      tempId: tempId ?? this.tempId,
      landImages: landImages ?? this.landImages,
      presignedData: presignedData ?? this.presignedData,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      totalUploadedCount: totalUploadedCount ?? this.totalUploadedCount,
      allUploadsComplete: allUploadsComplete ?? this.allUploadsComplete,
      confirmResponse: confirmResponse ?? this.confirmResponse,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    tempId,
    landImages,
    presignedData,
    uploadStatus,
    totalUploadedCount,
    allUploadsComplete,
    confirmResponse,
    message,
    postApiStatus,
  ];
}
