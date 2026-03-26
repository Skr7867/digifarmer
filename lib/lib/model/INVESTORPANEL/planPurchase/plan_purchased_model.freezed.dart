// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_purchased_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanPurchasedModel {

 bool get success; String get message; PlanPurchasedInvestmentModel? get investment; bool get paymentRequired;
/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPurchasedModelCopyWith<PlanPurchasedModel> get copyWith => _$PlanPurchasedModelCopyWithImpl<PlanPurchasedModel>(this as PlanPurchasedModel, _$identity);

  /// Serializes this PlanPurchasedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPurchasedModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.investment, investment) || other.investment == investment)&&(identical(other.paymentRequired, paymentRequired) || other.paymentRequired == paymentRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,investment,paymentRequired);

@override
String toString() {
  return 'PlanPurchasedModel(success: $success, message: $message, investment: $investment, paymentRequired: $paymentRequired)';
}


}

/// @nodoc
abstract mixin class $PlanPurchasedModelCopyWith<$Res>  {
  factory $PlanPurchasedModelCopyWith(PlanPurchasedModel value, $Res Function(PlanPurchasedModel) _then) = _$PlanPurchasedModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message, PlanPurchasedInvestmentModel? investment, bool paymentRequired
});


$PlanPurchasedInvestmentModelCopyWith<$Res>? get investment;

}
/// @nodoc
class _$PlanPurchasedModelCopyWithImpl<$Res>
    implements $PlanPurchasedModelCopyWith<$Res> {
  _$PlanPurchasedModelCopyWithImpl(this._self, this._then);

  final PlanPurchasedModel _self;
  final $Res Function(PlanPurchasedModel) _then;

/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? investment = freezed,Object? paymentRequired = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,investment: freezed == investment ? _self.investment : investment // ignore: cast_nullable_to_non_nullable
as PlanPurchasedInvestmentModel?,paymentRequired: null == paymentRequired ? _self.paymentRequired : paymentRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedInvestmentModelCopyWith<$Res>? get investment {
    if (_self.investment == null) {
    return null;
  }

  return $PlanPurchasedInvestmentModelCopyWith<$Res>(_self.investment!, (value) {
    return _then(_self.copyWith(investment: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanPurchasedModel].
extension PlanPurchasedModelPatterns on PlanPurchasedModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPurchasedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPurchasedModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPurchasedModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPurchasedModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  PlanPurchasedInvestmentModel? investment,  bool paymentRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPurchasedModel() when $default != null:
return $default(_that.success,_that.message,_that.investment,_that.paymentRequired);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  PlanPurchasedInvestmentModel? investment,  bool paymentRequired)  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedModel():
return $default(_that.success,_that.message,_that.investment,_that.paymentRequired);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  PlanPurchasedInvestmentModel? investment,  bool paymentRequired)?  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedModel() when $default != null:
return $default(_that.success,_that.message,_that.investment,_that.paymentRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPurchasedModel implements PlanPurchasedModel {
  const _PlanPurchasedModel({this.success = false, this.message = '', this.investment, this.paymentRequired = false});
  factory _PlanPurchasedModel.fromJson(Map<String, dynamic> json) => _$PlanPurchasedModelFromJson(json);

@override@JsonKey() final  bool success;
@override@JsonKey() final  String message;
@override final  PlanPurchasedInvestmentModel? investment;
@override@JsonKey() final  bool paymentRequired;

/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPurchasedModelCopyWith<_PlanPurchasedModel> get copyWith => __$PlanPurchasedModelCopyWithImpl<_PlanPurchasedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPurchasedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPurchasedModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.investment, investment) || other.investment == investment)&&(identical(other.paymentRequired, paymentRequired) || other.paymentRequired == paymentRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,investment,paymentRequired);

@override
String toString() {
  return 'PlanPurchasedModel(success: $success, message: $message, investment: $investment, paymentRequired: $paymentRequired)';
}


}

/// @nodoc
abstract mixin class _$PlanPurchasedModelCopyWith<$Res> implements $PlanPurchasedModelCopyWith<$Res> {
  factory _$PlanPurchasedModelCopyWith(_PlanPurchasedModel value, $Res Function(_PlanPurchasedModel) _then) = __$PlanPurchasedModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, PlanPurchasedInvestmentModel? investment, bool paymentRequired
});


@override $PlanPurchasedInvestmentModelCopyWith<$Res>? get investment;

}
/// @nodoc
class __$PlanPurchasedModelCopyWithImpl<$Res>
    implements _$PlanPurchasedModelCopyWith<$Res> {
  __$PlanPurchasedModelCopyWithImpl(this._self, this._then);

  final _PlanPurchasedModel _self;
  final $Res Function(_PlanPurchasedModel) _then;

/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? investment = freezed,Object? paymentRequired = null,}) {
  return _then(_PlanPurchasedModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,investment: freezed == investment ? _self.investment : investment // ignore: cast_nullable_to_non_nullable
as PlanPurchasedInvestmentModel?,paymentRequired: null == paymentRequired ? _self.paymentRequired : paymentRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PlanPurchasedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedInvestmentModelCopyWith<$Res>? get investment {
    if (_self.investment == null) {
    return null;
  }

  return $PlanPurchasedInvestmentModelCopyWith<$Res>(_self.investment!, (value) {
    return _then(_self.copyWith(investment: value));
  });
}
}


/// @nodoc
mixin _$PlanPurchasedInvestmentModel {

 String get id; String get investmentId; String get investmentType; int get investmentAmount; int get durationMonths; double get expectedReturnPercent; String get applicationStatus; String get paymentStatus; int get selectedDuration; String get roiFrequency; double get roiAmount; double get totalRoiExpected; double get totalROIPaid; double get pendingROI; String get startDate; String get endDate; String get maturityDate; int get lockInPeriodMonths; bool get prematureExitAllowed; String get riskLevel; List<dynamic> get documents; List<PlanPurchasedStatusTimelineModel> get statusTimeline; List<dynamic> get adminNotes; String get createdAt; String get updatedAt; PlanPurchasedAllocationsModel? get allocations; PlanPurchasedPoolInfoModel? get poolInfo;
/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPurchasedInvestmentModelCopyWith<PlanPurchasedInvestmentModel> get copyWith => _$PlanPurchasedInvestmentModelCopyWithImpl<PlanPurchasedInvestmentModel>(this as PlanPurchasedInvestmentModel, _$identity);

  /// Serializes this PlanPurchasedInvestmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPurchasedInvestmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.investmentId, investmentId) || other.investmentId == investmentId)&&(identical(other.investmentType, investmentType) || other.investmentType == investmentType)&&(identical(other.investmentAmount, investmentAmount) || other.investmentAmount == investmentAmount)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.expectedReturnPercent, expectedReturnPercent) || other.expectedReturnPercent == expectedReturnPercent)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.selectedDuration, selectedDuration) || other.selectedDuration == selectedDuration)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency)&&(identical(other.roiAmount, roiAmount) || other.roiAmount == roiAmount)&&(identical(other.totalRoiExpected, totalRoiExpected) || other.totalRoiExpected == totalRoiExpected)&&(identical(other.totalROIPaid, totalROIPaid) || other.totalROIPaid == totalROIPaid)&&(identical(other.pendingROI, pendingROI) || other.pendingROI == pendingROI)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maturityDate, maturityDate) || other.maturityDate == maturityDate)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&const DeepCollectionEquality().equals(other.documents, documents)&&const DeepCollectionEquality().equals(other.statusTimeline, statusTimeline)&&const DeepCollectionEquality().equals(other.adminNotes, adminNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allocations, allocations) || other.allocations == allocations)&&(identical(other.poolInfo, poolInfo) || other.poolInfo == poolInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,investmentId,investmentType,investmentAmount,durationMonths,expectedReturnPercent,applicationStatus,paymentStatus,selectedDuration,roiFrequency,roiAmount,totalRoiExpected,totalROIPaid,pendingROI,startDate,endDate,maturityDate,lockInPeriodMonths,prematureExitAllowed,riskLevel,const DeepCollectionEquality().hash(documents),const DeepCollectionEquality().hash(statusTimeline),const DeepCollectionEquality().hash(adminNotes),createdAt,updatedAt,allocations,poolInfo]);

@override
String toString() {
  return 'PlanPurchasedInvestmentModel(id: $id, investmentId: $investmentId, investmentType: $investmentType, investmentAmount: $investmentAmount, durationMonths: $durationMonths, expectedReturnPercent: $expectedReturnPercent, applicationStatus: $applicationStatus, paymentStatus: $paymentStatus, selectedDuration: $selectedDuration, roiFrequency: $roiFrequency, roiAmount: $roiAmount, totalRoiExpected: $totalRoiExpected, totalROIPaid: $totalROIPaid, pendingROI: $pendingROI, startDate: $startDate, endDate: $endDate, maturityDate: $maturityDate, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, riskLevel: $riskLevel, documents: $documents, statusTimeline: $statusTimeline, adminNotes: $adminNotes, createdAt: $createdAt, updatedAt: $updatedAt, allocations: $allocations, poolInfo: $poolInfo)';
}


}

/// @nodoc
abstract mixin class $PlanPurchasedInvestmentModelCopyWith<$Res>  {
  factory $PlanPurchasedInvestmentModelCopyWith(PlanPurchasedInvestmentModel value, $Res Function(PlanPurchasedInvestmentModel) _then) = _$PlanPurchasedInvestmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String investmentId, String investmentType, int investmentAmount, int durationMonths, double expectedReturnPercent, String applicationStatus, String paymentStatus, int selectedDuration, String roiFrequency, double roiAmount, double totalRoiExpected, double totalROIPaid, double pendingROI, String startDate, String endDate, String maturityDate, int lockInPeriodMonths, bool prematureExitAllowed, String riskLevel, List<dynamic> documents, List<PlanPurchasedStatusTimelineModel> statusTimeline, List<dynamic> adminNotes, String createdAt, String updatedAt, PlanPurchasedAllocationsModel? allocations, PlanPurchasedPoolInfoModel? poolInfo
});


$PlanPurchasedAllocationsModelCopyWith<$Res>? get allocations;$PlanPurchasedPoolInfoModelCopyWith<$Res>? get poolInfo;

}
/// @nodoc
class _$PlanPurchasedInvestmentModelCopyWithImpl<$Res>
    implements $PlanPurchasedInvestmentModelCopyWith<$Res> {
  _$PlanPurchasedInvestmentModelCopyWithImpl(this._self, this._then);

  final PlanPurchasedInvestmentModel _self;
  final $Res Function(PlanPurchasedInvestmentModel) _then;

/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? investmentId = null,Object? investmentType = null,Object? investmentAmount = null,Object? durationMonths = null,Object? expectedReturnPercent = null,Object? applicationStatus = null,Object? paymentStatus = null,Object? selectedDuration = null,Object? roiFrequency = null,Object? roiAmount = null,Object? totalRoiExpected = null,Object? totalROIPaid = null,Object? pendingROI = null,Object? startDate = null,Object? endDate = null,Object? maturityDate = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? riskLevel = null,Object? documents = null,Object? statusTimeline = null,Object? adminNotes = null,Object? createdAt = null,Object? updatedAt = null,Object? allocations = freezed,Object? poolInfo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,investmentId: null == investmentId ? _self.investmentId : investmentId // ignore: cast_nullable_to_non_nullable
as String,investmentType: null == investmentType ? _self.investmentType : investmentType // ignore: cast_nullable_to_non_nullable
as String,investmentAmount: null == investmentAmount ? _self.investmentAmount : investmentAmount // ignore: cast_nullable_to_non_nullable
as int,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,expectedReturnPercent: null == expectedReturnPercent ? _self.expectedReturnPercent : expectedReturnPercent // ignore: cast_nullable_to_non_nullable
as double,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,selectedDuration: null == selectedDuration ? _self.selectedDuration : selectedDuration // ignore: cast_nullable_to_non_nullable
as int,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,roiAmount: null == roiAmount ? _self.roiAmount : roiAmount // ignore: cast_nullable_to_non_nullable
as double,totalRoiExpected: null == totalRoiExpected ? _self.totalRoiExpected : totalRoiExpected // ignore: cast_nullable_to_non_nullable
as double,totalROIPaid: null == totalROIPaid ? _self.totalROIPaid : totalROIPaid // ignore: cast_nullable_to_non_nullable
as double,pendingROI: null == pendingROI ? _self.pendingROI : pendingROI // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,maturityDate: null == maturityDate ? _self.maturityDate : maturityDate // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self.documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,statusTimeline: null == statusTimeline ? _self.statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as List<PlanPurchasedStatusTimelineModel>,adminNotes: null == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as List<dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,allocations: freezed == allocations ? _self.allocations : allocations // ignore: cast_nullable_to_non_nullable
as PlanPurchasedAllocationsModel?,poolInfo: freezed == poolInfo ? _self.poolInfo : poolInfo // ignore: cast_nullable_to_non_nullable
as PlanPurchasedPoolInfoModel?,
  ));
}
/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedAllocationsModelCopyWith<$Res>? get allocations {
    if (_self.allocations == null) {
    return null;
  }

  return $PlanPurchasedAllocationsModelCopyWith<$Res>(_self.allocations!, (value) {
    return _then(_self.copyWith(allocations: value));
  });
}/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedPoolInfoModelCopyWith<$Res>? get poolInfo {
    if (_self.poolInfo == null) {
    return null;
  }

  return $PlanPurchasedPoolInfoModelCopyWith<$Res>(_self.poolInfo!, (value) {
    return _then(_self.copyWith(poolInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanPurchasedInvestmentModel].
extension PlanPurchasedInvestmentModelPatterns on PlanPurchasedInvestmentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPurchasedInvestmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPurchasedInvestmentModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPurchasedInvestmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String investmentId,  String investmentType,  int investmentAmount,  int durationMonths,  double expectedReturnPercent,  String applicationStatus,  String paymentStatus,  int selectedDuration,  String roiFrequency,  double roiAmount,  double totalRoiExpected,  double totalROIPaid,  double pendingROI,  String startDate,  String endDate,  String maturityDate,  int lockInPeriodMonths,  bool prematureExitAllowed,  String riskLevel,  List<dynamic> documents,  List<PlanPurchasedStatusTimelineModel> statusTimeline,  List<dynamic> adminNotes,  String createdAt,  String updatedAt,  PlanPurchasedAllocationsModel? allocations,  PlanPurchasedPoolInfoModel? poolInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel() when $default != null:
return $default(_that.id,_that.investmentId,_that.investmentType,_that.investmentAmount,_that.durationMonths,_that.expectedReturnPercent,_that.applicationStatus,_that.paymentStatus,_that.selectedDuration,_that.roiFrequency,_that.roiAmount,_that.totalRoiExpected,_that.totalROIPaid,_that.pendingROI,_that.startDate,_that.endDate,_that.maturityDate,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.riskLevel,_that.documents,_that.statusTimeline,_that.adminNotes,_that.createdAt,_that.updatedAt,_that.allocations,_that.poolInfo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String investmentId,  String investmentType,  int investmentAmount,  int durationMonths,  double expectedReturnPercent,  String applicationStatus,  String paymentStatus,  int selectedDuration,  String roiFrequency,  double roiAmount,  double totalRoiExpected,  double totalROIPaid,  double pendingROI,  String startDate,  String endDate,  String maturityDate,  int lockInPeriodMonths,  bool prematureExitAllowed,  String riskLevel,  List<dynamic> documents,  List<PlanPurchasedStatusTimelineModel> statusTimeline,  List<dynamic> adminNotes,  String createdAt,  String updatedAt,  PlanPurchasedAllocationsModel? allocations,  PlanPurchasedPoolInfoModel? poolInfo)  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel():
return $default(_that.id,_that.investmentId,_that.investmentType,_that.investmentAmount,_that.durationMonths,_that.expectedReturnPercent,_that.applicationStatus,_that.paymentStatus,_that.selectedDuration,_that.roiFrequency,_that.roiAmount,_that.totalRoiExpected,_that.totalROIPaid,_that.pendingROI,_that.startDate,_that.endDate,_that.maturityDate,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.riskLevel,_that.documents,_that.statusTimeline,_that.adminNotes,_that.createdAt,_that.updatedAt,_that.allocations,_that.poolInfo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String investmentId,  String investmentType,  int investmentAmount,  int durationMonths,  double expectedReturnPercent,  String applicationStatus,  String paymentStatus,  int selectedDuration,  String roiFrequency,  double roiAmount,  double totalRoiExpected,  double totalROIPaid,  double pendingROI,  String startDate,  String endDate,  String maturityDate,  int lockInPeriodMonths,  bool prematureExitAllowed,  String riskLevel,  List<dynamic> documents,  List<PlanPurchasedStatusTimelineModel> statusTimeline,  List<dynamic> adminNotes,  String createdAt,  String updatedAt,  PlanPurchasedAllocationsModel? allocations,  PlanPurchasedPoolInfoModel? poolInfo)?  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedInvestmentModel() when $default != null:
return $default(_that.id,_that.investmentId,_that.investmentType,_that.investmentAmount,_that.durationMonths,_that.expectedReturnPercent,_that.applicationStatus,_that.paymentStatus,_that.selectedDuration,_that.roiFrequency,_that.roiAmount,_that.totalRoiExpected,_that.totalROIPaid,_that.pendingROI,_that.startDate,_that.endDate,_that.maturityDate,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.riskLevel,_that.documents,_that.statusTimeline,_that.adminNotes,_that.createdAt,_that.updatedAt,_that.allocations,_that.poolInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPurchasedInvestmentModel implements PlanPurchasedInvestmentModel {
  const _PlanPurchasedInvestmentModel({this.id = '', this.investmentId = '', this.investmentType = '', this.investmentAmount = 0, this.durationMonths = 0, this.expectedReturnPercent = 0.0, this.applicationStatus = '', this.paymentStatus = '', this.selectedDuration = 0, this.roiFrequency = '', this.roiAmount = 0.0, this.totalRoiExpected = 0.0, this.totalROIPaid = 0.0, this.pendingROI = 0.0, this.startDate = '', this.endDate = '', this.maturityDate = '', this.lockInPeriodMonths = 0, this.prematureExitAllowed = false, this.riskLevel = '', final  List<dynamic> documents = const [], final  List<PlanPurchasedStatusTimelineModel> statusTimeline = const [], final  List<dynamic> adminNotes = const [], this.createdAt = '', this.updatedAt = '', this.allocations, this.poolInfo}): _documents = documents,_statusTimeline = statusTimeline,_adminNotes = adminNotes;
  factory _PlanPurchasedInvestmentModel.fromJson(Map<String, dynamic> json) => _$PlanPurchasedInvestmentModelFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String investmentId;
@override@JsonKey() final  String investmentType;
@override@JsonKey() final  int investmentAmount;
@override@JsonKey() final  int durationMonths;
@override@JsonKey() final  double expectedReturnPercent;
@override@JsonKey() final  String applicationStatus;
@override@JsonKey() final  String paymentStatus;
@override@JsonKey() final  int selectedDuration;
@override@JsonKey() final  String roiFrequency;
@override@JsonKey() final  double roiAmount;
@override@JsonKey() final  double totalRoiExpected;
@override@JsonKey() final  double totalROIPaid;
@override@JsonKey() final  double pendingROI;
@override@JsonKey() final  String startDate;
@override@JsonKey() final  String endDate;
@override@JsonKey() final  String maturityDate;
@override@JsonKey() final  int lockInPeriodMonths;
@override@JsonKey() final  bool prematureExitAllowed;
@override@JsonKey() final  String riskLevel;
 final  List<dynamic> _documents;
@override@JsonKey() List<dynamic> get documents {
  if (_documents is EqualUnmodifiableListView) return _documents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_documents);
}

 final  List<PlanPurchasedStatusTimelineModel> _statusTimeline;
@override@JsonKey() List<PlanPurchasedStatusTimelineModel> get statusTimeline {
  if (_statusTimeline is EqualUnmodifiableListView) return _statusTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusTimeline);
}

 final  List<dynamic> _adminNotes;
@override@JsonKey() List<dynamic> get adminNotes {
  if (_adminNotes is EqualUnmodifiableListView) return _adminNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminNotes);
}

@override@JsonKey() final  String createdAt;
@override@JsonKey() final  String updatedAt;
@override final  PlanPurchasedAllocationsModel? allocations;
@override final  PlanPurchasedPoolInfoModel? poolInfo;

/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPurchasedInvestmentModelCopyWith<_PlanPurchasedInvestmentModel> get copyWith => __$PlanPurchasedInvestmentModelCopyWithImpl<_PlanPurchasedInvestmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPurchasedInvestmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPurchasedInvestmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.investmentId, investmentId) || other.investmentId == investmentId)&&(identical(other.investmentType, investmentType) || other.investmentType == investmentType)&&(identical(other.investmentAmount, investmentAmount) || other.investmentAmount == investmentAmount)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.expectedReturnPercent, expectedReturnPercent) || other.expectedReturnPercent == expectedReturnPercent)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.selectedDuration, selectedDuration) || other.selectedDuration == selectedDuration)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency)&&(identical(other.roiAmount, roiAmount) || other.roiAmount == roiAmount)&&(identical(other.totalRoiExpected, totalRoiExpected) || other.totalRoiExpected == totalRoiExpected)&&(identical(other.totalROIPaid, totalROIPaid) || other.totalROIPaid == totalROIPaid)&&(identical(other.pendingROI, pendingROI) || other.pendingROI == pendingROI)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.maturityDate, maturityDate) || other.maturityDate == maturityDate)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&const DeepCollectionEquality().equals(other._documents, _documents)&&const DeepCollectionEquality().equals(other._statusTimeline, _statusTimeline)&&const DeepCollectionEquality().equals(other._adminNotes, _adminNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allocations, allocations) || other.allocations == allocations)&&(identical(other.poolInfo, poolInfo) || other.poolInfo == poolInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,investmentId,investmentType,investmentAmount,durationMonths,expectedReturnPercent,applicationStatus,paymentStatus,selectedDuration,roiFrequency,roiAmount,totalRoiExpected,totalROIPaid,pendingROI,startDate,endDate,maturityDate,lockInPeriodMonths,prematureExitAllowed,riskLevel,const DeepCollectionEquality().hash(_documents),const DeepCollectionEquality().hash(_statusTimeline),const DeepCollectionEquality().hash(_adminNotes),createdAt,updatedAt,allocations,poolInfo]);

@override
String toString() {
  return 'PlanPurchasedInvestmentModel(id: $id, investmentId: $investmentId, investmentType: $investmentType, investmentAmount: $investmentAmount, durationMonths: $durationMonths, expectedReturnPercent: $expectedReturnPercent, applicationStatus: $applicationStatus, paymentStatus: $paymentStatus, selectedDuration: $selectedDuration, roiFrequency: $roiFrequency, roiAmount: $roiAmount, totalRoiExpected: $totalRoiExpected, totalROIPaid: $totalROIPaid, pendingROI: $pendingROI, startDate: $startDate, endDate: $endDate, maturityDate: $maturityDate, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, riskLevel: $riskLevel, documents: $documents, statusTimeline: $statusTimeline, adminNotes: $adminNotes, createdAt: $createdAt, updatedAt: $updatedAt, allocations: $allocations, poolInfo: $poolInfo)';
}


}

/// @nodoc
abstract mixin class _$PlanPurchasedInvestmentModelCopyWith<$Res> implements $PlanPurchasedInvestmentModelCopyWith<$Res> {
  factory _$PlanPurchasedInvestmentModelCopyWith(_PlanPurchasedInvestmentModel value, $Res Function(_PlanPurchasedInvestmentModel) _then) = __$PlanPurchasedInvestmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String investmentId, String investmentType, int investmentAmount, int durationMonths, double expectedReturnPercent, String applicationStatus, String paymentStatus, int selectedDuration, String roiFrequency, double roiAmount, double totalRoiExpected, double totalROIPaid, double pendingROI, String startDate, String endDate, String maturityDate, int lockInPeriodMonths, bool prematureExitAllowed, String riskLevel, List<dynamic> documents, List<PlanPurchasedStatusTimelineModel> statusTimeline, List<dynamic> adminNotes, String createdAt, String updatedAt, PlanPurchasedAllocationsModel? allocations, PlanPurchasedPoolInfoModel? poolInfo
});


@override $PlanPurchasedAllocationsModelCopyWith<$Res>? get allocations;@override $PlanPurchasedPoolInfoModelCopyWith<$Res>? get poolInfo;

}
/// @nodoc
class __$PlanPurchasedInvestmentModelCopyWithImpl<$Res>
    implements _$PlanPurchasedInvestmentModelCopyWith<$Res> {
  __$PlanPurchasedInvestmentModelCopyWithImpl(this._self, this._then);

  final _PlanPurchasedInvestmentModel _self;
  final $Res Function(_PlanPurchasedInvestmentModel) _then;

/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? investmentId = null,Object? investmentType = null,Object? investmentAmount = null,Object? durationMonths = null,Object? expectedReturnPercent = null,Object? applicationStatus = null,Object? paymentStatus = null,Object? selectedDuration = null,Object? roiFrequency = null,Object? roiAmount = null,Object? totalRoiExpected = null,Object? totalROIPaid = null,Object? pendingROI = null,Object? startDate = null,Object? endDate = null,Object? maturityDate = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? riskLevel = null,Object? documents = null,Object? statusTimeline = null,Object? adminNotes = null,Object? createdAt = null,Object? updatedAt = null,Object? allocations = freezed,Object? poolInfo = freezed,}) {
  return _then(_PlanPurchasedInvestmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,investmentId: null == investmentId ? _self.investmentId : investmentId // ignore: cast_nullable_to_non_nullable
as String,investmentType: null == investmentType ? _self.investmentType : investmentType // ignore: cast_nullable_to_non_nullable
as String,investmentAmount: null == investmentAmount ? _self.investmentAmount : investmentAmount // ignore: cast_nullable_to_non_nullable
as int,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,expectedReturnPercent: null == expectedReturnPercent ? _self.expectedReturnPercent : expectedReturnPercent // ignore: cast_nullable_to_non_nullable
as double,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,selectedDuration: null == selectedDuration ? _self.selectedDuration : selectedDuration // ignore: cast_nullable_to_non_nullable
as int,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,roiAmount: null == roiAmount ? _self.roiAmount : roiAmount // ignore: cast_nullable_to_non_nullable
as double,totalRoiExpected: null == totalRoiExpected ? _self.totalRoiExpected : totalRoiExpected // ignore: cast_nullable_to_non_nullable
as double,totalROIPaid: null == totalROIPaid ? _self.totalROIPaid : totalROIPaid // ignore: cast_nullable_to_non_nullable
as double,pendingROI: null == pendingROI ? _self.pendingROI : pendingROI // ignore: cast_nullable_to_non_nullable
as double,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,maturityDate: null == maturityDate ? _self.maturityDate : maturityDate // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,documents: null == documents ? _self._documents : documents // ignore: cast_nullable_to_non_nullable
as List<dynamic>,statusTimeline: null == statusTimeline ? _self._statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as List<PlanPurchasedStatusTimelineModel>,adminNotes: null == adminNotes ? _self._adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as List<dynamic>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,allocations: freezed == allocations ? _self.allocations : allocations // ignore: cast_nullable_to_non_nullable
as PlanPurchasedAllocationsModel?,poolInfo: freezed == poolInfo ? _self.poolInfo : poolInfo // ignore: cast_nullable_to_non_nullable
as PlanPurchasedPoolInfoModel?,
  ));
}

/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedAllocationsModelCopyWith<$Res>? get allocations {
    if (_self.allocations == null) {
    return null;
  }

  return $PlanPurchasedAllocationsModelCopyWith<$Res>(_self.allocations!, (value) {
    return _then(_self.copyWith(allocations: value));
  });
}/// Create a copy of PlanPurchasedInvestmentModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanPurchasedPoolInfoModelCopyWith<$Res>? get poolInfo {
    if (_self.poolInfo == null) {
    return null;
  }

  return $PlanPurchasedPoolInfoModelCopyWith<$Res>(_self.poolInfo!, (value) {
    return _then(_self.copyWith(poolInfo: value));
  });
}
}


/// @nodoc
mixin _$PlanPurchasedStatusTimelineModel {

 String get status; String get note; String get updatedAt;
/// Create a copy of PlanPurchasedStatusTimelineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPurchasedStatusTimelineModelCopyWith<PlanPurchasedStatusTimelineModel> get copyWith => _$PlanPurchasedStatusTimelineModelCopyWithImpl<PlanPurchasedStatusTimelineModel>(this as PlanPurchasedStatusTimelineModel, _$identity);

  /// Serializes this PlanPurchasedStatusTimelineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPurchasedStatusTimelineModel&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,note,updatedAt);

@override
String toString() {
  return 'PlanPurchasedStatusTimelineModel(status: $status, note: $note, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PlanPurchasedStatusTimelineModelCopyWith<$Res>  {
  factory $PlanPurchasedStatusTimelineModelCopyWith(PlanPurchasedStatusTimelineModel value, $Res Function(PlanPurchasedStatusTimelineModel) _then) = _$PlanPurchasedStatusTimelineModelCopyWithImpl;
@useResult
$Res call({
 String status, String note, String updatedAt
});




}
/// @nodoc
class _$PlanPurchasedStatusTimelineModelCopyWithImpl<$Res>
    implements $PlanPurchasedStatusTimelineModelCopyWith<$Res> {
  _$PlanPurchasedStatusTimelineModelCopyWithImpl(this._self, this._then);

  final PlanPurchasedStatusTimelineModel _self;
  final $Res Function(PlanPurchasedStatusTimelineModel) _then;

/// Create a copy of PlanPurchasedStatusTimelineModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? note = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanPurchasedStatusTimelineModel].
extension PlanPurchasedStatusTimelineModelPatterns on PlanPurchasedStatusTimelineModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPurchasedStatusTimelineModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPurchasedStatusTimelineModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPurchasedStatusTimelineModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String note,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel() when $default != null:
return $default(_that.status,_that.note,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String note,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel():
return $default(_that.status,_that.note,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String note,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedStatusTimelineModel() when $default != null:
return $default(_that.status,_that.note,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPurchasedStatusTimelineModel implements PlanPurchasedStatusTimelineModel {
  const _PlanPurchasedStatusTimelineModel({this.status = '', this.note = '', this.updatedAt = ''});
  factory _PlanPurchasedStatusTimelineModel.fromJson(Map<String, dynamic> json) => _$PlanPurchasedStatusTimelineModelFromJson(json);

@override@JsonKey() final  String status;
@override@JsonKey() final  String note;
@override@JsonKey() final  String updatedAt;

/// Create a copy of PlanPurchasedStatusTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPurchasedStatusTimelineModelCopyWith<_PlanPurchasedStatusTimelineModel> get copyWith => __$PlanPurchasedStatusTimelineModelCopyWithImpl<_PlanPurchasedStatusTimelineModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPurchasedStatusTimelineModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPurchasedStatusTimelineModel&&(identical(other.status, status) || other.status == status)&&(identical(other.note, note) || other.note == note)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,note,updatedAt);

@override
String toString() {
  return 'PlanPurchasedStatusTimelineModel(status: $status, note: $note, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PlanPurchasedStatusTimelineModelCopyWith<$Res> implements $PlanPurchasedStatusTimelineModelCopyWith<$Res> {
  factory _$PlanPurchasedStatusTimelineModelCopyWith(_PlanPurchasedStatusTimelineModel value, $Res Function(_PlanPurchasedStatusTimelineModel) _then) = __$PlanPurchasedStatusTimelineModelCopyWithImpl;
@override @useResult
$Res call({
 String status, String note, String updatedAt
});




}
/// @nodoc
class __$PlanPurchasedStatusTimelineModelCopyWithImpl<$Res>
    implements _$PlanPurchasedStatusTimelineModelCopyWith<$Res> {
  __$PlanPurchasedStatusTimelineModelCopyWithImpl(this._self, this._then);

  final _PlanPurchasedStatusTimelineModel _self;
  final $Res Function(_PlanPurchasedStatusTimelineModel) _then;

/// Create a copy of PlanPurchasedStatusTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? note = null,Object? updatedAt = null,}) {
  return _then(_PlanPurchasedStatusTimelineModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PlanPurchasedAllocationsModel {

 List<dynamic> get lands; List<dynamic> get crops;
/// Create a copy of PlanPurchasedAllocationsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPurchasedAllocationsModelCopyWith<PlanPurchasedAllocationsModel> get copyWith => _$PlanPurchasedAllocationsModelCopyWithImpl<PlanPurchasedAllocationsModel>(this as PlanPurchasedAllocationsModel, _$identity);

  /// Serializes this PlanPurchasedAllocationsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPurchasedAllocationsModel&&const DeepCollectionEquality().equals(other.lands, lands)&&const DeepCollectionEquality().equals(other.crops, crops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(lands),const DeepCollectionEquality().hash(crops));

@override
String toString() {
  return 'PlanPurchasedAllocationsModel(lands: $lands, crops: $crops)';
}


}

/// @nodoc
abstract mixin class $PlanPurchasedAllocationsModelCopyWith<$Res>  {
  factory $PlanPurchasedAllocationsModelCopyWith(PlanPurchasedAllocationsModel value, $Res Function(PlanPurchasedAllocationsModel) _then) = _$PlanPurchasedAllocationsModelCopyWithImpl;
@useResult
$Res call({
 List<dynamic> lands, List<dynamic> crops
});




}
/// @nodoc
class _$PlanPurchasedAllocationsModelCopyWithImpl<$Res>
    implements $PlanPurchasedAllocationsModelCopyWith<$Res> {
  _$PlanPurchasedAllocationsModelCopyWithImpl(this._self, this._then);

  final PlanPurchasedAllocationsModel _self;
  final $Res Function(PlanPurchasedAllocationsModel) _then;

/// Create a copy of PlanPurchasedAllocationsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lands = null,Object? crops = null,}) {
  return _then(_self.copyWith(
lands: null == lands ? _self.lands : lands // ignore: cast_nullable_to_non_nullable
as List<dynamic>,crops: null == crops ? _self.crops : crops // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanPurchasedAllocationsModel].
extension PlanPurchasedAllocationsModelPatterns on PlanPurchasedAllocationsModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPurchasedAllocationsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPurchasedAllocationsModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPurchasedAllocationsModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<dynamic> lands,  List<dynamic> crops)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel() when $default != null:
return $default(_that.lands,_that.crops);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<dynamic> lands,  List<dynamic> crops)  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel():
return $default(_that.lands,_that.crops);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<dynamic> lands,  List<dynamic> crops)?  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedAllocationsModel() when $default != null:
return $default(_that.lands,_that.crops);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPurchasedAllocationsModel implements PlanPurchasedAllocationsModel {
  const _PlanPurchasedAllocationsModel({final  List<dynamic> lands = const [], final  List<dynamic> crops = const []}): _lands = lands,_crops = crops;
  factory _PlanPurchasedAllocationsModel.fromJson(Map<String, dynamic> json) => _$PlanPurchasedAllocationsModelFromJson(json);

 final  List<dynamic> _lands;
@override@JsonKey() List<dynamic> get lands {
  if (_lands is EqualUnmodifiableListView) return _lands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lands);
}

 final  List<dynamic> _crops;
@override@JsonKey() List<dynamic> get crops {
  if (_crops is EqualUnmodifiableListView) return _crops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_crops);
}


/// Create a copy of PlanPurchasedAllocationsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPurchasedAllocationsModelCopyWith<_PlanPurchasedAllocationsModel> get copyWith => __$PlanPurchasedAllocationsModelCopyWithImpl<_PlanPurchasedAllocationsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPurchasedAllocationsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPurchasedAllocationsModel&&const DeepCollectionEquality().equals(other._lands, _lands)&&const DeepCollectionEquality().equals(other._crops, _crops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_lands),const DeepCollectionEquality().hash(_crops));

@override
String toString() {
  return 'PlanPurchasedAllocationsModel(lands: $lands, crops: $crops)';
}


}

/// @nodoc
abstract mixin class _$PlanPurchasedAllocationsModelCopyWith<$Res> implements $PlanPurchasedAllocationsModelCopyWith<$Res> {
  factory _$PlanPurchasedAllocationsModelCopyWith(_PlanPurchasedAllocationsModel value, $Res Function(_PlanPurchasedAllocationsModel) _then) = __$PlanPurchasedAllocationsModelCopyWithImpl;
@override @useResult
$Res call({
 List<dynamic> lands, List<dynamic> crops
});




}
/// @nodoc
class __$PlanPurchasedAllocationsModelCopyWithImpl<$Res>
    implements _$PlanPurchasedAllocationsModelCopyWith<$Res> {
  __$PlanPurchasedAllocationsModelCopyWithImpl(this._self, this._then);

  final _PlanPurchasedAllocationsModel _self;
  final $Res Function(_PlanPurchasedAllocationsModel) _then;

/// Create a copy of PlanPurchasedAllocationsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lands = null,Object? crops = null,}) {
  return _then(_PlanPurchasedAllocationsModel(
lands: null == lands ? _self._lands : lands // ignore: cast_nullable_to_non_nullable
as List<dynamic>,crops: null == crops ? _self._crops : crops // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}


/// @nodoc
mixin _$PlanPurchasedPoolInfoModel {

 String get poolName; int get totalPoolSize; int get remainingAmount; List<dynamic> get allocatedLands;
/// Create a copy of PlanPurchasedPoolInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPurchasedPoolInfoModelCopyWith<PlanPurchasedPoolInfoModel> get copyWith => _$PlanPurchasedPoolInfoModelCopyWithImpl<PlanPurchasedPoolInfoModel>(this as PlanPurchasedPoolInfoModel, _$identity);

  /// Serializes this PlanPurchasedPoolInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPurchasedPoolInfoModel&&(identical(other.poolName, poolName) || other.poolName == poolName)&&(identical(other.totalPoolSize, totalPoolSize) || other.totalPoolSize == totalPoolSize)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&const DeepCollectionEquality().equals(other.allocatedLands, allocatedLands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poolName,totalPoolSize,remainingAmount,const DeepCollectionEquality().hash(allocatedLands));

@override
String toString() {
  return 'PlanPurchasedPoolInfoModel(poolName: $poolName, totalPoolSize: $totalPoolSize, remainingAmount: $remainingAmount, allocatedLands: $allocatedLands)';
}


}

/// @nodoc
abstract mixin class $PlanPurchasedPoolInfoModelCopyWith<$Res>  {
  factory $PlanPurchasedPoolInfoModelCopyWith(PlanPurchasedPoolInfoModel value, $Res Function(PlanPurchasedPoolInfoModel) _then) = _$PlanPurchasedPoolInfoModelCopyWithImpl;
@useResult
$Res call({
 String poolName, int totalPoolSize, int remainingAmount, List<dynamic> allocatedLands
});




}
/// @nodoc
class _$PlanPurchasedPoolInfoModelCopyWithImpl<$Res>
    implements $PlanPurchasedPoolInfoModelCopyWith<$Res> {
  _$PlanPurchasedPoolInfoModelCopyWithImpl(this._self, this._then);

  final PlanPurchasedPoolInfoModel _self;
  final $Res Function(PlanPurchasedPoolInfoModel) _then;

/// Create a copy of PlanPurchasedPoolInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poolName = null,Object? totalPoolSize = null,Object? remainingAmount = null,Object? allocatedLands = null,}) {
  return _then(_self.copyWith(
poolName: null == poolName ? _self.poolName : poolName // ignore: cast_nullable_to_non_nullable
as String,totalPoolSize: null == totalPoolSize ? _self.totalPoolSize : totalPoolSize // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,allocatedLands: null == allocatedLands ? _self.allocatedLands : allocatedLands // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanPurchasedPoolInfoModel].
extension PlanPurchasedPoolInfoModelPatterns on PlanPurchasedPoolInfoModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPurchasedPoolInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPurchasedPoolInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPurchasedPoolInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String poolName,  int totalPoolSize,  int remainingAmount,  List<dynamic> allocatedLands)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel() when $default != null:
return $default(_that.poolName,_that.totalPoolSize,_that.remainingAmount,_that.allocatedLands);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String poolName,  int totalPoolSize,  int remainingAmount,  List<dynamic> allocatedLands)  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel():
return $default(_that.poolName,_that.totalPoolSize,_that.remainingAmount,_that.allocatedLands);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String poolName,  int totalPoolSize,  int remainingAmount,  List<dynamic> allocatedLands)?  $default,) {final _that = this;
switch (_that) {
case _PlanPurchasedPoolInfoModel() when $default != null:
return $default(_that.poolName,_that.totalPoolSize,_that.remainingAmount,_that.allocatedLands);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPurchasedPoolInfoModel implements PlanPurchasedPoolInfoModel {
  const _PlanPurchasedPoolInfoModel({this.poolName = '', this.totalPoolSize = 0, this.remainingAmount = 0, final  List<dynamic> allocatedLands = const []}): _allocatedLands = allocatedLands;
  factory _PlanPurchasedPoolInfoModel.fromJson(Map<String, dynamic> json) => _$PlanPurchasedPoolInfoModelFromJson(json);

@override@JsonKey() final  String poolName;
@override@JsonKey() final  int totalPoolSize;
@override@JsonKey() final  int remainingAmount;
 final  List<dynamic> _allocatedLands;
@override@JsonKey() List<dynamic> get allocatedLands {
  if (_allocatedLands is EqualUnmodifiableListView) return _allocatedLands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allocatedLands);
}


/// Create a copy of PlanPurchasedPoolInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPurchasedPoolInfoModelCopyWith<_PlanPurchasedPoolInfoModel> get copyWith => __$PlanPurchasedPoolInfoModelCopyWithImpl<_PlanPurchasedPoolInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPurchasedPoolInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPurchasedPoolInfoModel&&(identical(other.poolName, poolName) || other.poolName == poolName)&&(identical(other.totalPoolSize, totalPoolSize) || other.totalPoolSize == totalPoolSize)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&const DeepCollectionEquality().equals(other._allocatedLands, _allocatedLands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poolName,totalPoolSize,remainingAmount,const DeepCollectionEquality().hash(_allocatedLands));

@override
String toString() {
  return 'PlanPurchasedPoolInfoModel(poolName: $poolName, totalPoolSize: $totalPoolSize, remainingAmount: $remainingAmount, allocatedLands: $allocatedLands)';
}


}

/// @nodoc
abstract mixin class _$PlanPurchasedPoolInfoModelCopyWith<$Res> implements $PlanPurchasedPoolInfoModelCopyWith<$Res> {
  factory _$PlanPurchasedPoolInfoModelCopyWith(_PlanPurchasedPoolInfoModel value, $Res Function(_PlanPurchasedPoolInfoModel) _then) = __$PlanPurchasedPoolInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String poolName, int totalPoolSize, int remainingAmount, List<dynamic> allocatedLands
});




}
/// @nodoc
class __$PlanPurchasedPoolInfoModelCopyWithImpl<$Res>
    implements _$PlanPurchasedPoolInfoModelCopyWith<$Res> {
  __$PlanPurchasedPoolInfoModelCopyWithImpl(this._self, this._then);

  final _PlanPurchasedPoolInfoModel _self;
  final $Res Function(_PlanPurchasedPoolInfoModel) _then;

/// Create a copy of PlanPurchasedPoolInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poolName = null,Object? totalPoolSize = null,Object? remainingAmount = null,Object? allocatedLands = null,}) {
  return _then(_PlanPurchasedPoolInfoModel(
poolName: null == poolName ? _self.poolName : poolName // ignore: cast_nullable_to_non_nullable
as String,totalPoolSize: null == totalPoolSize ? _self.totalPoolSize : totalPoolSize // ignore: cast_nullable_to_non_nullable
as int,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as int,allocatedLands: null == allocatedLands ? _self._allocatedLands : allocatedLands // ignore: cast_nullable_to_non_nullable
as List<dynamic>,
  ));
}


}

// dart format on
