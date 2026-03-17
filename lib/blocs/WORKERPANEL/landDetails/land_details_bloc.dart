import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/WORKERPANEL/landDetails/land_details_model.dart';
import '../../../repository/WORKERPANEL/landDetails/land_details_repository.dart';

part 'land_details_event.dart';
part 'land_details_state.dart';

class LandDetailsBloc extends Bloc<LandDetailsEvent, LandDetailsState> {
  final LandDetailsRepository landDetailsRepository;

  LandDetailsBloc({required this.landDetailsRepository})
    : super(LandDetailsState(landDetails: ApiResponse.loading())) {
    on<LandDetailsFetched>(_fetchLandDetailsApi);
  }

  Future<void> _fetchLandDetailsApi(
    LandDetailsFetched event,
    Emitter<LandDetailsState> emit,
  ) async {
    emit(state.copyWith(landDetails: ApiResponse.loading()));

    try {
      final response = await landDetailsRepository.fetchLandDetailsApi(
        event.taskId,
      );
      emit(state.copyWith(landDetails: ApiResponse.completed(response)));
    } catch (error) {
      emit(state.copyWith(landDetails: ApiResponse.error(error.toString())));
    }
  }
}
