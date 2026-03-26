import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/userProfile/user_profile_model.dart';
import '../../../repository/INVESTORPANEL/userProfile/user_profile_repository.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final UserProfileRepository userProfileRepository;

  UserProfileBloc({required this.userProfileRepository})
      : super(UserProfileState(userProfile: ApiResponse.loading())) {
    on<UserProfileFetched>(_fetchUserProfileApi);
  }

  Future<void> _fetchUserProfileApi(
    UserProfileFetched event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(state.copyWith(userProfile: ApiResponse.loading()));

    try {
      final response = await userProfileRepository.fetchUserProfile();

      emit(
        state.copyWith(
          userProfile: ApiResponse.completed(response),
        ),
      );
    } catch (error, stackTrace) {
      log(
        'User Profile API Failed',
        error: error,
        stackTrace: stackTrace,
        name: 'UserProfileBloc',
      );

      emit(
        state.copyWith(
          userProfile: ApiResponse.error(
            'Something went wrong. Please try again.',
          ),
        ),
      );
    }
  }
}