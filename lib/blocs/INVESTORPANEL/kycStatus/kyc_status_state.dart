part of 'kyc_status_bloc.dart';

class KycStatusState extends Equatable {
  const KycStatusState({required this.kycStatus});

  final ApiResponse<KycStatusModel> kycStatus;

  KycStatusState copyWith({
    ApiResponse<KycStatusModel>? kycStatus,
  }) {
    return KycStatusState(
      kycStatus: kycStatus ?? this.kycStatus,
    );
  }

  @override
  List<Object?> get props => [kycStatus];
}