part of 'submit_kyc_documents_bloc.dart';

abstract class SubmitKycDocumentsEvent extends Equatable {
  const SubmitKycDocumentsEvent();

  @override
  List<Object> get props => [];
}

class SubmitKycDocuments extends SubmitKycDocumentsEvent {}