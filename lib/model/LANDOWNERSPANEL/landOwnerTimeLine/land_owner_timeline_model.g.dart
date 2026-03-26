// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land_owner_timeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LandOwnerTimelineModel _$LandOwnerTimelineModelFromJson(
  Map<String, dynamic> json,
) => _LandOwnerTimelineModel(
  success: json['success'] as bool,
  data: LandOwnerTimelineData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LandOwnerTimelineModelToJson(
  _LandOwnerTimelineModel instance,
) => <String, dynamic>{'success': instance.success, 'data': instance.data};

_LandOwnerTimelineData _$LandOwnerTimelineDataFromJson(
  Map<String, dynamic> json,
) => _LandOwnerTimelineData(
  count: (json['count'] as num).toInt(),
  lands: (json['lands'] as List<dynamic>)
      .map((e) => LandOwnerTimelineLand.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$LandOwnerTimelineDataToJson(
  _LandOwnerTimelineData instance,
) => <String, dynamic>{'count': instance.count, 'lands': instance.lands};

_LandOwnerTimelineLand _$LandOwnerTimelineLandFromJson(
  Map<String, dynamic> json,
) => _LandOwnerTimelineLand(
  id: json['id'] as String,
  title: json['title'] as String,
  area: json['area'] as String,
  location: json['location'] as String,
  status: json['status'] as String,
  isLive: json['isLive'] as bool,
  currentStep: (json['currentStep'] as num).toInt(),
  stepStatus: json['stepStatus'] as String,
  landId: json['landId'] as String,
  submittedAt: DateTime.parse(json['submittedAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LandOwnerTimelineLandToJson(
  _LandOwnerTimelineLand instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'area': instance.area,
  'location': instance.location,
  'status': instance.status,
  'isLive': instance.isLive,
  'currentStep': instance.currentStep,
  'stepStatus': instance.stepStatus,
  'landId': instance.landId,
  'submittedAt': instance.submittedAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
