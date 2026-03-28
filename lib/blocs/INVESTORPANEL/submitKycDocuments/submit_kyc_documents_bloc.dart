import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../repository/INVESTORPANEL/submitKycDocuments/submit_kyc_documents_repository.dart';
import '../../../utils/enums.dart';
part 'submit_kyc_documents_event.dart';
part 'submit_kyc_documents_state.dart';

class SubmitKycDocumentsBloc
    extends Bloc<SubmitKycDocumentsEvent, SubmitKycDocumentsState> {
  final SubmitKycDocumentsRepository submitKycDocumentsRepository;

  SubmitKycDocumentsBloc(this.submitKycDocumentsRepository)
      : super(const SubmitKycDocumentsState()) {
    on<SubmitKycDocuments>(_submitKycDocuments);
  }

  Future<void> _submitKycDocuments(
    SubmitKycDocuments event,
    Emitter<SubmitKycDocumentsState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final response = await submitKycDocumentsRepository.submitKycDocumentsApi();

      if (response.success == true) {
        emit(state.copyWith(
          messages: response.message ?? "KYC documents submitted successfully",
          postApiStatus: PostApiStatus.success,
        ));
      } else {
        emit(state.copyWith(
          messages: response.message ?? "Failed to submit KYC documents",
          postApiStatus: PostApiStatus.error,
        ));
      }
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());

      emit(state.copyWith(
        messages: error.toString(),
        postApiStatus: PostApiStatus.error,
      ));
    }
  }
}