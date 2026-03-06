part of 'basic_info_bloc.dart';

abstract class SaveBasicInfoEvent extends Equatable {
  const SaveBasicInfoEvent();

  @override
  List<Object?> get props => [];
}

class SetUniqueKey extends SaveBasicInfoEvent {
  final String uniqueKey;
  const SetUniqueKey(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class LandTitleChanged extends SaveBasicInfoEvent {
  final String landTitle;
  const LandTitleChanged(this.landTitle);

  @override
  List<Object?> get props => [landTitle];
}

class SurveyNumberChanged extends SaveBasicInfoEvent {
  final String surveyNumber;
  const SurveyNumberChanged(this.surveyNumber);

  @override
  List<Object?> get props => [surveyNumber];
}

class AreaValueChanged extends SaveBasicInfoEvent {
  final double areaValue;
  const AreaValueChanged(this.areaValue);

  @override
  List<Object?> get props => [areaValue];
}

class AreaUnitChanged extends SaveBasicInfoEvent {
  final String areaUnit;
  const AreaUnitChanged(this.areaUnit);

  @override
  List<Object?> get props => [areaUnit];
}

class TotalSizeChanged extends SaveBasicInfoEvent {
  final double totalSize;
  const TotalSizeChanged(this.totalSize);

  @override
  List<Object?> get props => [totalSize];
}

class DescriptionChanged extends SaveBasicInfoEvent {
  final String description;
  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class SoilTypeChanged extends SaveBasicInfoEvent {
  final String soilType;
  const SoilTypeChanged(this.soilType);

  @override
  List<Object?> get props => [soilType];
}

class WaterSourceChanged extends SaveBasicInfoEvent {
  final List<String> waterSource;
  const WaterSourceChanged(this.waterSource);

  @override
  List<Object?> get props => [waterSource];
}

class RoadAccessChanged extends SaveBasicInfoEvent {
  final bool roadAccess;
  const RoadAccessChanged(this.roadAccess);

  @override
  List<Object?> get props => [roadAccess];
}

class ExpectedMonthlyRentChanged extends SaveBasicInfoEvent {
  final double expectedMonthlyRent;
  const ExpectedMonthlyRentChanged(this.expectedMonthlyRent);

  @override
  List<Object?> get props => [expectedMonthlyRent];
}

class MinimumLeaseDurationChanged extends SaveBasicInfoEvent {
  final int minimumLeaseDuration;
  const MinimumLeaseDurationChanged(this.minimumLeaseDuration);

  @override
  List<Object?> get props => [minimumLeaseDuration];
}

class SubmitSaveBasicInfo extends SaveBasicInfoEvent {}

class SaveDraftBasicInfo extends SaveBasicInfoEvent {}
