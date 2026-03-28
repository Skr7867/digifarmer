import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/data/response/api_response.dart';
import '../../../model/INVESTORPANEL/kycStatus/kyc_status_model.dart';
import '../../../repository/INVESTORPANEL/kycStatus/kyc_status_repository.dart';

part 'kyc_status_event.dart';
part 'kyc_status_state.dart';

class KycStatusBloc extends Bloc<KycStatusEvent, KycStatusState> {
  final KycStatusRepository kycStatusRepository;

  KycStatusBloc({required this.kycStatusRepository})
      : super(KycStatusState(kycStatus: ApiResponse.loading())) {
    on<KycStatusFetched>(_fetchKycStatus);
  }

  Future<void> _fetchKycStatus(
    KycStatusFetched event,
    Emitter<KycStatusState> emit,
  ) async {
    emit(state.copyWith(kycStatus: ApiResponse.loading()));

    try {
      final response = await kycStatusRepository.fetchKycStatus();
      emit(state.copyWith(kycStatus: ApiResponse.completed(response)));
    } catch (error) {
      emit(
        state.copyWith(kycStatus: ApiResponse.error(error.toString())),
      );
    }
  }
}