part of 'basic_info_bloc.dart';

class SaveBasicInfoState extends Equatable {
  const SaveBasicInfoState({
    this.uniqueKey = '',
    this.landTitle = '',
    this.surveyNumber = '',
    this.areaValue = 0.0,
    this.areaUnit = 'ACRE',
    this.totalSize = 0.0,
    this.description = '',
    this.soilType = '',
    this.waterSource = const [],
    this.roadAccess = false,
    this.expectedMonthlyRent = 0.0,
    this.minimumLeaseDuration = 12,
    this.tempId = '',
    this.currentStep = 1,
    this.ownerId = '',
    this.createdBy = '',
    this.createdByRole = '',
    this.nextStep = '',
    this.expiresAt = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String uniqueKey;
  final String landTitle;
  final String surveyNumber;
  final double areaValue;
  final String areaUnit;
  final double totalSize;
  final String description;
  final String soilType;
  final List<String> waterSource;
  final bool roadAccess;
  final double expectedMonthlyRent;
  final int minimumLeaseDuration;

  // Response fields
  final String tempId;
  final int currentStep;
  final String ownerId;
  final String createdBy;
  final String createdByRole;
  final String nextStep;
  final String expiresAt;

  final String message;
  final PostApiStatus postApiStatus;

  SaveBasicInfoState copyWith({
    String? uniqueKey,
    String? landTitle,
    String? surveyNumber,
    double? areaValue,
    String? areaUnit,
    double? totalSize,
    String? description,
    String? soilType,
    List<String>? waterSource,
    bool? roadAccess,
    double? expectedMonthlyRent,
    int? minimumLeaseDuration,
    String? tempId,
    int? currentStep,
    String? ownerId,
    String? createdBy,
    String? createdByRole,
    String? nextStep,
    String? expiresAt,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return SaveBasicInfoState(
      uniqueKey: uniqueKey ?? this.uniqueKey,
      landTitle: landTitle ?? this.landTitle,
      surveyNumber: surveyNumber ?? this.surveyNumber,
      areaValue: areaValue ?? this.areaValue,
      areaUnit: areaUnit ?? this.areaUnit,
      totalSize: totalSize ?? this.totalSize,
      description: description ?? this.description,
      soilType: soilType ?? this.soilType,
      waterSource: waterSource ?? this.waterSource,
      roadAccess: roadAccess ?? this.roadAccess,
      expectedMonthlyRent: expectedMonthlyRent ?? this.expectedMonthlyRent,
      minimumLeaseDuration: minimumLeaseDuration ?? this.minimumLeaseDuration,
      tempId: tempId ?? this.tempId,
      currentStep: currentStep ?? this.currentStep,
      ownerId: ownerId ?? this.ownerId,
      createdBy: createdBy ?? this.createdBy,
      createdByRole: createdByRole ?? this.createdByRole,
      nextStep: nextStep ?? this.nextStep,
      expiresAt: expiresAt ?? this.expiresAt,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    uniqueKey,
    landTitle,
    surveyNumber,
    areaValue,
    areaUnit,
    totalSize,
    description,
    soilType,
    waterSource,
    roadAccess,
    expectedMonthlyRent,
    minimumLeaseDuration,
    tempId,
    currentStep,
    ownerId,
    createdBy,
    createdByRole,
    nextStep,
    expiresAt,
    message,
    postApiStatus,
  ];
}
