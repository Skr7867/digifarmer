part of 'submit_kyc_documents_bloc.dart';

class SubmitKycDocumentsState extends Equatable {
  const SubmitKycDocumentsState({
    this.messages = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String messages;
  final PostApiStatus postApiStatus;

  SubmitKycDocumentsState copyWith({
    String? messages,
    PostApiStatus? postApiStatus,
  }) {
    return SubmitKycDocumentsState(
      messages: messages ?? this.messages,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [messages, postApiStatus];
}