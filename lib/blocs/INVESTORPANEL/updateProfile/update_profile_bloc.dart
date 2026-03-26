import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../repository/INVESTORPANEL/updateProfile/update_profile_repository.dart';
import '../../../utils/enums.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileRepository updateProfileRepository;

  UpdateProfileBloc({required this.updateProfileRepository})
    : super(const UpdateProfileState()) {
    on<UpdateProfileStarted>(_onUpdateProfileStarted);
    on<ProfileImagePicked>(_onProfileImagePicked);
    on<SubmitUpdateProfile>(_onSubmitUpdateProfile);
  }

  void _onUpdateProfileStarted(
    UpdateProfileStarted event,
    Emitter<UpdateProfileState> emit,
  ) {}

  void _onProfileImagePicked(
    ProfileImagePicked event,
    Emitter<UpdateProfileState> emit,
  ) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  Future<void> _onSubmitUpdateProfile(
    SubmitUpdateProfile event,
    Emitter<UpdateProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading, message: ''));

      // Build FormData so the image is sent as a multipart file
      final formData = FormData.fromMap({
        'profileImage': await MultipartFile.fromFile(
          state.imagePath,
          filename: state.imagePath.split('/').last,
        ),
      });

      final response = await updateProfileRepository.updateProfileApi(formData);

      log("UPDATE PROFILE RESPONSE: ${response.toString()}");

      if (response.success == true) {
        emit(
          state.copyWith(
            message: response.message ?? 'Profile updated successfully',
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message ?? 'Failed to update profile',
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(
        state.copyWith(
          message: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}