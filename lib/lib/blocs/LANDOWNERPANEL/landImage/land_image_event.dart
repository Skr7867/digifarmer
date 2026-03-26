// blocs/LANDOWNERPANEL/landImages/land_images_event.dart

part of 'land_image_bloc.dart';

abstract class LandImagesEvent extends Equatable {
  const LandImagesEvent();

  @override
  List<Object?> get props => [];
}

class SetTempId extends LandImagesEvent {
  final String tempId;
  const SetTempId(this.tempId);

  @override
  List<Object?> get props => [tempId];
}

class AddLandImage extends LandImagesEvent {
  final int index;
  final File imageFile;
  final ImageType imageType;
  final String description;

  const AddLandImage({
    required this.index,
    required this.imageFile,
    required this.imageType,
    required this.description,
  });

  @override
  List<Object?> get props => [index, imageFile, imageType, description];
}

class RemoveLandImage extends LandImagesEvent {
  final int index;
  const RemoveLandImage(this.index);

  @override
  List<Object?> get props => [index];
}

class GeneratePresignedUrls extends LandImagesEvent {
  const GeneratePresignedUrls();
}

class UploadFilesToS3 extends LandImagesEvent {
  const UploadFilesToS3();
}

class ConfirmUpload extends LandImagesEvent {
  const ConfirmUpload();
}

class ResetLandImagesState extends LandImagesEvent {}
