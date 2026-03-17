part of 'land_details_bloc.dart';

class LandDetailsState extends Equatable {
  const LandDetailsState({required this.landDetails});

  final ApiResponse<LandDetailsModel> landDetails;

  LandDetailsState copyWith({ApiResponse<LandDetailsModel>? landDetails}) {
    return LandDetailsState(landDetails: landDetails ?? this.landDetails);
  }

  @override
  List<Object?> get props => [landDetails];
}
