part of 'land_status_bloc.dart';

class LandStatusState extends Equatable {
  const LandStatusState({required this.landStatus});

  final ApiResponse<LandOwnerTimelineModel> landStatus;

  LandStatusState copyWith({ApiResponse<LandOwnerTimelineModel>? landStatus}) {
    return LandStatusState(landStatus: landStatus ?? this.landStatus);
  }

  @override
  List<Object?> get props => [landStatus];
}
