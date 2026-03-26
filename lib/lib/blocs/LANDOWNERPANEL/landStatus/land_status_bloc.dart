import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/LANDOWNERSPANEL/landOwnerTimeLine/land_owner_timeline_model.dart';
import '../../../repository/LANDOWNERPANEL/landStatus/land_status_repository.dart';

part 'land_status_event.dart';
part 'land_status_state.dart';

class LandStatusBloc extends Bloc<LandStatusEvent, LandStatusState> {
  final LandStatusRepository landStatusRepository;

  LandStatusBloc({required this.landStatusRepository})
    : super(LandStatusState(landStatus: ApiResponse.loading())) {
    on<LandStatusFetched>(_fetchLandStatus);
  }

  Future<void> _fetchLandStatus(
    LandStatusFetched event,
    Emitter<LandStatusState> emit,
  ) async {
    emit(state.copyWith(landStatus: ApiResponse.loading()));

    try {
      final response = await landStatusRepository.fetchLandStatus();

      emit(state.copyWith(landStatus: ApiResponse.completed(response)));
    } catch (error) {
      emit(state.copyWith(landStatus: ApiResponse.error(error.toString())));
    }
  }
}
