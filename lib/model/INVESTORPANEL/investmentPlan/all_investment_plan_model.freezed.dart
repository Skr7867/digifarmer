// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_investment_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AllInvestmentPlanModel {

 bool get success; List<InvestmentPlanModel> get plans;
/// Create a copy of AllInvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllInvestmentPlanModelCopyWith<AllInvestmentPlanModel> get copyWith => _$AllInvestmentPlanModelCopyWithImpl<AllInvestmentPlanModel>(this as AllInvestmentPlanModel, _$identity);

  /// Serializes this AllInvestmentPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllInvestmentPlanModel&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.plans, plans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(plans));

@override
String toString() {
  return 'AllInvestmentPlanModel(success: $success, plans: $plans)';
}


}

/// @nodoc
abstract mixin class $AllInvestmentPlanModelCopyWith<$Res>  {
  factory $AllInvestmentPlanModelCopyWith(AllInvestmentPlanModel value, $Res Function(AllInvestmentPlanModel) _then) = _$AllInvestmentPlanModelCopyWithImpl;
@useResult
$Res call({
 bool success, List<InvestmentPlanModel> plans
});




}
/// @nodoc
class _$AllInvestmentPlanModelCopyWithImpl<$Res>
    implements $AllInvestmentPlanModelCopyWith<$Res> {
  _$AllInvestmentPlanModelCopyWithImpl(this._self, this._then);

  final AllInvestmentPlanModel _self;
  final $Res Function(AllInvestmentPlanModel) _then;

/// Create a copy of AllInvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? plans = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as List<InvestmentPlanModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [AllInvestmentPlanModel].
extension AllInvestmentPlanModelPatterns on AllInvestmentPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllInvestmentPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllInvestmentPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllInvestmentPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _AllInvestmentPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllInvestmentPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _AllInvestmentPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<InvestmentPlanModel> plans)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllInvestmentPlanModel() when $default != null:
return $default(_that.success,_that.plans);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<InvestmentPlanModel> plans)  $default,) {final _that = this;
switch (_that) {
case _AllInvestmentPlanModel():
return $default(_that.success,_that.plans);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<InvestmentPlanModel> plans)?  $default,) {final _that = this;
switch (_that) {
case _AllInvestmentPlanModel() when $default != null:
return $default(_that.success,_that.plans);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllInvestmentPlanModel implements AllInvestmentPlanModel {
  const _AllInvestmentPlanModel({this.success = false, final  List<InvestmentPlanModel> plans = const []}): _plans = plans;
  factory _AllInvestmentPlanModel.fromJson(Map<String, dynamic> json) => _$AllInvestmentPlanModelFromJson(json);

@override@JsonKey() final  bool success;
 final  List<InvestmentPlanModel> _plans;
@override@JsonKey() List<InvestmentPlanModel> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of AllInvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllInvestmentPlanModelCopyWith<_AllInvestmentPlanModel> get copyWith => __$AllInvestmentPlanModelCopyWithImpl<_AllInvestmentPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllInvestmentPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllInvestmentPlanModel&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._plans, _plans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'AllInvestmentPlanModel(success: $success, plans: $plans)';
}


}

/// @nodoc
abstract mixin class _$AllInvestmentPlanModelCopyWith<$Res> implements $AllInvestmentPlanModelCopyWith<$Res> {
  factory _$AllInvestmentPlanModelCopyWith(_AllInvestmentPlanModel value, $Res Function(_AllInvestmentPlanModel) _then) = __$AllInvestmentPlanModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<InvestmentPlanModel> plans
});




}
/// @nodoc
class __$AllInvestmentPlanModelCopyWithImpl<$Res>
    implements _$AllInvestmentPlanModelCopyWith<$Res> {
  __$AllInvestmentPlanModelCopyWithImpl(this._self, this._then);

  final _AllInvestmentPlanModel _self;
  final $Res Function(_AllInvestmentPlanModel) _then;

/// Create a copy of AllInvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? plans = null,}) {
  return _then(_AllInvestmentPlanModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<InvestmentPlanModel>,
  ));
}


}


/// @nodoc
mixin _$InvestmentPlanModel {

@JsonKey(name: '_id') String get id; String get planId; String get planName; String get description; int get minInvestment; int get maxInvestment; int get durationMonths; int get returnPercent; String get roiFrequency; int get lockInPeriodMonths; bool get prematureExitAllowed; int get prematureExitPenalty; String get riskLevel; bool get isActive; bool get isPopular; String get createdAt; String get updatedAt; int get totalReturnPercent; int get totalReturnOnLakh; double get periodicReturn; String get periodicLabel; String get minInvestmentFormatted; String get maxInvestmentFormatted; String get durationFormatted; String get returnFormatted; ExamplesModel? get examples; List<String> get features; SummaryModel? get summary; InvestmentGuideModel? get investmentGuide;
/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentPlanModelCopyWith<InvestmentPlanModel> get copyWith => _$InvestmentPlanModelCopyWithImpl<InvestmentPlanModel>(this as InvestmentPlanModel, _$identity);

  /// Serializes this InvestmentPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestmentPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.description, description) || other.description == description)&&(identical(other.minInvestment, minInvestment) || other.minInvestment == minInvestment)&&(identical(other.maxInvestment, maxInvestment) || other.maxInvestment == maxInvestment)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.returnPercent, returnPercent) || other.returnPercent == returnPercent)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.prematureExitPenalty, prematureExitPenalty) || other.prematureExitPenalty == prematureExitPenalty)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalReturnPercent, totalReturnPercent) || other.totalReturnPercent == totalReturnPercent)&&(identical(other.totalReturnOnLakh, totalReturnOnLakh) || other.totalReturnOnLakh == totalReturnOnLakh)&&(identical(other.periodicReturn, periodicReturn) || other.periodicReturn == periodicReturn)&&(identical(other.periodicLabel, periodicLabel) || other.periodicLabel == periodicLabel)&&(identical(other.minInvestmentFormatted, minInvestmentFormatted) || other.minInvestmentFormatted == minInvestmentFormatted)&&(identical(other.maxInvestmentFormatted, maxInvestmentFormatted) || other.maxInvestmentFormatted == maxInvestmentFormatted)&&(identical(other.durationFormatted, durationFormatted) || other.durationFormatted == durationFormatted)&&(identical(other.returnFormatted, returnFormatted) || other.returnFormatted == returnFormatted)&&(identical(other.examples, examples) || other.examples == examples)&&const DeepCollectionEquality().equals(other.features, features)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.investmentGuide, investmentGuide) || other.investmentGuide == investmentGuide));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,planId,planName,description,minInvestment,maxInvestment,durationMonths,returnPercent,roiFrequency,lockInPeriodMonths,prematureExitAllowed,prematureExitPenalty,riskLevel,isActive,isPopular,createdAt,updatedAt,totalReturnPercent,totalReturnOnLakh,periodicReturn,periodicLabel,minInvestmentFormatted,maxInvestmentFormatted,durationFormatted,returnFormatted,examples,const DeepCollectionEquality().hash(features),summary,investmentGuide]);

@override
String toString() {
  return 'InvestmentPlanModel(id: $id, planId: $planId, planName: $planName, description: $description, minInvestment: $minInvestment, maxInvestment: $maxInvestment, durationMonths: $durationMonths, returnPercent: $returnPercent, roiFrequency: $roiFrequency, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, prematureExitPenalty: $prematureExitPenalty, riskLevel: $riskLevel, isActive: $isActive, isPopular: $isPopular, createdAt: $createdAt, updatedAt: $updatedAt, totalReturnPercent: $totalReturnPercent, totalReturnOnLakh: $totalReturnOnLakh, periodicReturn: $periodicReturn, periodicLabel: $periodicLabel, minInvestmentFormatted: $minInvestmentFormatted, maxInvestmentFormatted: $maxInvestmentFormatted, durationFormatted: $durationFormatted, returnFormatted: $returnFormatted, examples: $examples, features: $features, summary: $summary, investmentGuide: $investmentGuide)';
}


}

/// @nodoc
abstract mixin class $InvestmentPlanModelCopyWith<$Res>  {
  factory $InvestmentPlanModelCopyWith(InvestmentPlanModel value, $Res Function(InvestmentPlanModel) _then) = _$InvestmentPlanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String planId, String planName, String description, int minInvestment, int maxInvestment, int durationMonths, int returnPercent, String roiFrequency, int lockInPeriodMonths, bool prematureExitAllowed, int prematureExitPenalty, String riskLevel, bool isActive, bool isPopular, String createdAt, String updatedAt, int totalReturnPercent, int totalReturnOnLakh, double periodicReturn, String periodicLabel, String minInvestmentFormatted, String maxInvestmentFormatted, String durationFormatted, String returnFormatted, ExamplesModel? examples, List<String> features, SummaryModel? summary, InvestmentGuideModel? investmentGuide
});


$ExamplesModelCopyWith<$Res>? get examples;$SummaryModelCopyWith<$Res>? get summary;$InvestmentGuideModelCopyWith<$Res>? get investmentGuide;

}
/// @nodoc
class _$InvestmentPlanModelCopyWithImpl<$Res>
    implements $InvestmentPlanModelCopyWith<$Res> {
  _$InvestmentPlanModelCopyWithImpl(this._self, this._then);

  final InvestmentPlanModel _self;
  final $Res Function(InvestmentPlanModel) _then;

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? description = null,Object? minInvestment = null,Object? maxInvestment = null,Object? durationMonths = null,Object? returnPercent = null,Object? roiFrequency = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? prematureExitPenalty = null,Object? riskLevel = null,Object? isActive = null,Object? isPopular = null,Object? createdAt = null,Object? updatedAt = null,Object? totalReturnPercent = null,Object? totalReturnOnLakh = null,Object? periodicReturn = null,Object? periodicLabel = null,Object? minInvestmentFormatted = null,Object? maxInvestmentFormatted = null,Object? durationFormatted = null,Object? returnFormatted = null,Object? examples = freezed,Object? features = null,Object? summary = freezed,Object? investmentGuide = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minInvestment: null == minInvestment ? _self.minInvestment : minInvestment // ignore: cast_nullable_to_non_nullable
as int,maxInvestment: null == maxInvestment ? _self.maxInvestment : maxInvestment // ignore: cast_nullable_to_non_nullable
as int,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,returnPercent: null == returnPercent ? _self.returnPercent : returnPercent // ignore: cast_nullable_to_non_nullable
as int,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,prematureExitPenalty: null == prematureExitPenalty ? _self.prematureExitPenalty : prematureExitPenalty // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,totalReturnPercent: null == totalReturnPercent ? _self.totalReturnPercent : totalReturnPercent // ignore: cast_nullable_to_non_nullable
as int,totalReturnOnLakh: null == totalReturnOnLakh ? _self.totalReturnOnLakh : totalReturnOnLakh // ignore: cast_nullable_to_non_nullable
as int,periodicReturn: null == periodicReturn ? _self.periodicReturn : periodicReturn // ignore: cast_nullable_to_non_nullable
as double,periodicLabel: null == periodicLabel ? _self.periodicLabel : periodicLabel // ignore: cast_nullable_to_non_nullable
as String,minInvestmentFormatted: null == minInvestmentFormatted ? _self.minInvestmentFormatted : minInvestmentFormatted // ignore: cast_nullable_to_non_nullable
as String,maxInvestmentFormatted: null == maxInvestmentFormatted ? _self.maxInvestmentFormatted : maxInvestmentFormatted // ignore: cast_nullable_to_non_nullable
as String,durationFormatted: null == durationFormatted ? _self.durationFormatted : durationFormatted // ignore: cast_nullable_to_non_nullable
as String,returnFormatted: null == returnFormatted ? _self.returnFormatted : returnFormatted // ignore: cast_nullable_to_non_nullable
as String,examples: freezed == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as ExamplesModel?,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SummaryModel?,investmentGuide: freezed == investmentGuide ? _self.investmentGuide : investmentGuide // ignore: cast_nullable_to_non_nullable
as InvestmentGuideModel?,
  ));
}
/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExamplesModelCopyWith<$Res>? get examples {
    if (_self.examples == null) {
    return null;
  }

  return $ExamplesModelCopyWith<$Res>(_self.examples!, (value) {
    return _then(_self.copyWith(examples: value));
  });
}/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryModelCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SummaryModelCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvestmentGuideModelCopyWith<$Res>? get investmentGuide {
    if (_self.investmentGuide == null) {
    return null;
  }

  return $InvestmentGuideModelCopyWith<$Res>(_self.investmentGuide!, (value) {
    return _then(_self.copyWith(investmentGuide: value));
  });
}
}


/// Adds pattern-matching-related methods to [InvestmentPlanModel].
extension InvestmentPlanModelPatterns on InvestmentPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvestmentPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvestmentPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _InvestmentPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvestmentPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int durationMonths,  int returnPercent,  String roiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt,  int totalReturnPercent,  int totalReturnOnLakh,  double periodicReturn,  String periodicLabel,  String minInvestmentFormatted,  String maxInvestmentFormatted,  String durationFormatted,  String returnFormatted,  ExamplesModel? examples,  List<String> features,  SummaryModel? summary,  InvestmentGuideModel? investmentGuide)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.durationMonths,_that.returnPercent,_that.roiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.totalReturnPercent,_that.totalReturnOnLakh,_that.periodicReturn,_that.periodicLabel,_that.minInvestmentFormatted,_that.maxInvestmentFormatted,_that.durationFormatted,_that.returnFormatted,_that.examples,_that.features,_that.summary,_that.investmentGuide);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int durationMonths,  int returnPercent,  String roiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt,  int totalReturnPercent,  int totalReturnOnLakh,  double periodicReturn,  String periodicLabel,  String minInvestmentFormatted,  String maxInvestmentFormatted,  String durationFormatted,  String returnFormatted,  ExamplesModel? examples,  List<String> features,  SummaryModel? summary,  InvestmentGuideModel? investmentGuide)  $default,) {final _that = this;
switch (_that) {
case _InvestmentPlanModel():
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.durationMonths,_that.returnPercent,_that.roiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.totalReturnPercent,_that.totalReturnOnLakh,_that.periodicReturn,_that.periodicLabel,_that.minInvestmentFormatted,_that.maxInvestmentFormatted,_that.durationFormatted,_that.returnFormatted,_that.examples,_that.features,_that.summary,_that.investmentGuide);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int durationMonths,  int returnPercent,  String roiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt,  int totalReturnPercent,  int totalReturnOnLakh,  double periodicReturn,  String periodicLabel,  String minInvestmentFormatted,  String maxInvestmentFormatted,  String durationFormatted,  String returnFormatted,  ExamplesModel? examples,  List<String> features,  SummaryModel? summary,  InvestmentGuideModel? investmentGuide)?  $default,) {final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.durationMonths,_that.returnPercent,_that.roiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.totalReturnPercent,_that.totalReturnOnLakh,_that.periodicReturn,_that.periodicLabel,_that.minInvestmentFormatted,_that.maxInvestmentFormatted,_that.durationFormatted,_that.returnFormatted,_that.examples,_that.features,_that.summary,_that.investmentGuide);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestmentPlanModel implements InvestmentPlanModel {
  const _InvestmentPlanModel({@JsonKey(name: '_id') this.id = '', this.planId = '', this.planName = '', this.description = '', this.minInvestment = 0, this.maxInvestment = 0, this.durationMonths = 0, this.returnPercent = 0, this.roiFrequency = '', this.lockInPeriodMonths = 0, this.prematureExitAllowed = false, this.prematureExitPenalty = 0, this.riskLevel = '', this.isActive = false, this.isPopular = false, this.createdAt = '', this.updatedAt = '', this.totalReturnPercent = 0, this.totalReturnOnLakh = 0, this.periodicReturn = 0.0, this.periodicLabel = '', this.minInvestmentFormatted = '', this.maxInvestmentFormatted = '', this.durationFormatted = '', this.returnFormatted = '', this.examples, final  List<String> features = const [], this.summary, this.investmentGuide}): _features = features;
  factory _InvestmentPlanModel.fromJson(Map<String, dynamic> json) => _$InvestmentPlanModelFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override@JsonKey() final  String planId;
@override@JsonKey() final  String planName;
@override@JsonKey() final  String description;
@override@JsonKey() final  int minInvestment;
@override@JsonKey() final  int maxInvestment;
@override@JsonKey() final  int durationMonths;
@override@JsonKey() final  int returnPercent;
@override@JsonKey() final  String roiFrequency;
@override@JsonKey() final  int lockInPeriodMonths;
@override@JsonKey() final  bool prematureExitAllowed;
@override@JsonKey() final  int prematureExitPenalty;
@override@JsonKey() final  String riskLevel;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isPopular;
@override@JsonKey() final  String createdAt;
@override@JsonKey() final  String updatedAt;
@override@JsonKey() final  int totalReturnPercent;
@override@JsonKey() final  int totalReturnOnLakh;
@override@JsonKey() final  double periodicReturn;
@override@JsonKey() final  String periodicLabel;
@override@JsonKey() final  String minInvestmentFormatted;
@override@JsonKey() final  String maxInvestmentFormatted;
@override@JsonKey() final  String durationFormatted;
@override@JsonKey() final  String returnFormatted;
@override final  ExamplesModel? examples;
 final  List<String> _features;
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

@override final  SummaryModel? summary;
@override final  InvestmentGuideModel? investmentGuide;

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestmentPlanModelCopyWith<_InvestmentPlanModel> get copyWith => __$InvestmentPlanModelCopyWithImpl<_InvestmentPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestmentPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestmentPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.description, description) || other.description == description)&&(identical(other.minInvestment, minInvestment) || other.minInvestment == minInvestment)&&(identical(other.maxInvestment, maxInvestment) || other.maxInvestment == maxInvestment)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.returnPercent, returnPercent) || other.returnPercent == returnPercent)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.prematureExitPenalty, prematureExitPenalty) || other.prematureExitPenalty == prematureExitPenalty)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.totalReturnPercent, totalReturnPercent) || other.totalReturnPercent == totalReturnPercent)&&(identical(other.totalReturnOnLakh, totalReturnOnLakh) || other.totalReturnOnLakh == totalReturnOnLakh)&&(identical(other.periodicReturn, periodicReturn) || other.periodicReturn == periodicReturn)&&(identical(other.periodicLabel, periodicLabel) || other.periodicLabel == periodicLabel)&&(identical(other.minInvestmentFormatted, minInvestmentFormatted) || other.minInvestmentFormatted == minInvestmentFormatted)&&(identical(other.maxInvestmentFormatted, maxInvestmentFormatted) || other.maxInvestmentFormatted == maxInvestmentFormatted)&&(identical(other.durationFormatted, durationFormatted) || other.durationFormatted == durationFormatted)&&(identical(other.returnFormatted, returnFormatted) || other.returnFormatted == returnFormatted)&&(identical(other.examples, examples) || other.examples == examples)&&const DeepCollectionEquality().equals(other._features, _features)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.investmentGuide, investmentGuide) || other.investmentGuide == investmentGuide));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,planId,planName,description,minInvestment,maxInvestment,durationMonths,returnPercent,roiFrequency,lockInPeriodMonths,prematureExitAllowed,prematureExitPenalty,riskLevel,isActive,isPopular,createdAt,updatedAt,totalReturnPercent,totalReturnOnLakh,periodicReturn,periodicLabel,minInvestmentFormatted,maxInvestmentFormatted,durationFormatted,returnFormatted,examples,const DeepCollectionEquality().hash(_features),summary,investmentGuide]);

@override
String toString() {
  return 'InvestmentPlanModel(id: $id, planId: $planId, planName: $planName, description: $description, minInvestment: $minInvestment, maxInvestment: $maxInvestment, durationMonths: $durationMonths, returnPercent: $returnPercent, roiFrequency: $roiFrequency, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, prematureExitPenalty: $prematureExitPenalty, riskLevel: $riskLevel, isActive: $isActive, isPopular: $isPopular, createdAt: $createdAt, updatedAt: $updatedAt, totalReturnPercent: $totalReturnPercent, totalReturnOnLakh: $totalReturnOnLakh, periodicReturn: $periodicReturn, periodicLabel: $periodicLabel, minInvestmentFormatted: $minInvestmentFormatted, maxInvestmentFormatted: $maxInvestmentFormatted, durationFormatted: $durationFormatted, returnFormatted: $returnFormatted, examples: $examples, features: $features, summary: $summary, investmentGuide: $investmentGuide)';
}


}

/// @nodoc
abstract mixin class _$InvestmentPlanModelCopyWith<$Res> implements $InvestmentPlanModelCopyWith<$Res> {
  factory _$InvestmentPlanModelCopyWith(_InvestmentPlanModel value, $Res Function(_InvestmentPlanModel) _then) = __$InvestmentPlanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String planId, String planName, String description, int minInvestment, int maxInvestment, int durationMonths, int returnPercent, String roiFrequency, int lockInPeriodMonths, bool prematureExitAllowed, int prematureExitPenalty, String riskLevel, bool isActive, bool isPopular, String createdAt, String updatedAt, int totalReturnPercent, int totalReturnOnLakh, double periodicReturn, String periodicLabel, String minInvestmentFormatted, String maxInvestmentFormatted, String durationFormatted, String returnFormatted, ExamplesModel? examples, List<String> features, SummaryModel? summary, InvestmentGuideModel? investmentGuide
});


@override $ExamplesModelCopyWith<$Res>? get examples;@override $SummaryModelCopyWith<$Res>? get summary;@override $InvestmentGuideModelCopyWith<$Res>? get investmentGuide;

}
/// @nodoc
class __$InvestmentPlanModelCopyWithImpl<$Res>
    implements _$InvestmentPlanModelCopyWith<$Res> {
  __$InvestmentPlanModelCopyWithImpl(this._self, this._then);

  final _InvestmentPlanModel _self;
  final $Res Function(_InvestmentPlanModel) _then;

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? description = null,Object? minInvestment = null,Object? maxInvestment = null,Object? durationMonths = null,Object? returnPercent = null,Object? roiFrequency = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? prematureExitPenalty = null,Object? riskLevel = null,Object? isActive = null,Object? isPopular = null,Object? createdAt = null,Object? updatedAt = null,Object? totalReturnPercent = null,Object? totalReturnOnLakh = null,Object? periodicReturn = null,Object? periodicLabel = null,Object? minInvestmentFormatted = null,Object? maxInvestmentFormatted = null,Object? durationFormatted = null,Object? returnFormatted = null,Object? examples = freezed,Object? features = null,Object? summary = freezed,Object? investmentGuide = freezed,}) {
  return _then(_InvestmentPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minInvestment: null == minInvestment ? _self.minInvestment : minInvestment // ignore: cast_nullable_to_non_nullable
as int,maxInvestment: null == maxInvestment ? _self.maxInvestment : maxInvestment // ignore: cast_nullable_to_non_nullable
as int,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,returnPercent: null == returnPercent ? _self.returnPercent : returnPercent // ignore: cast_nullable_to_non_nullable
as int,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,prematureExitPenalty: null == prematureExitPenalty ? _self.prematureExitPenalty : prematureExitPenalty // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,totalReturnPercent: null == totalReturnPercent ? _self.totalReturnPercent : totalReturnPercent // ignore: cast_nullable_to_non_nullable
as int,totalReturnOnLakh: null == totalReturnOnLakh ? _self.totalReturnOnLakh : totalReturnOnLakh // ignore: cast_nullable_to_non_nullable
as int,periodicReturn: null == periodicReturn ? _self.periodicReturn : periodicReturn // ignore: cast_nullable_to_non_nullable
as double,periodicLabel: null == periodicLabel ? _self.periodicLabel : periodicLabel // ignore: cast_nullable_to_non_nullable
as String,minInvestmentFormatted: null == minInvestmentFormatted ? _self.minInvestmentFormatted : minInvestmentFormatted // ignore: cast_nullable_to_non_nullable
as String,maxInvestmentFormatted: null == maxInvestmentFormatted ? _self.maxInvestmentFormatted : maxInvestmentFormatted // ignore: cast_nullable_to_non_nullable
as String,durationFormatted: null == durationFormatted ? _self.durationFormatted : durationFormatted // ignore: cast_nullable_to_non_nullable
as String,returnFormatted: null == returnFormatted ? _self.returnFormatted : returnFormatted // ignore: cast_nullable_to_non_nullable
as String,examples: freezed == examples ? _self.examples : examples // ignore: cast_nullable_to_non_nullable
as ExamplesModel?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SummaryModel?,investmentGuide: freezed == investmentGuide ? _self.investmentGuide : investmentGuide // ignore: cast_nullable_to_non_nullable
as InvestmentGuideModel?,
  ));
}

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExamplesModelCopyWith<$Res>? get examples {
    if (_self.examples == null) {
    return null;
  }

  return $ExamplesModelCopyWith<$Res>(_self.examples!, (value) {
    return _then(_self.copyWith(examples: value));
  });
}/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SummaryModelCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $SummaryModelCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InvestmentGuideModelCopyWith<$Res>? get investmentGuide {
    if (_self.investmentGuide == null) {
    return null;
  }

  return $InvestmentGuideModelCopyWith<$Res>(_self.investmentGuide!, (value) {
    return _then(_self.copyWith(investmentGuide: value));
  });
}
}


/// @nodoc
mixin _$ExamplesModel {

@JsonKey(name: 'on100000') ExampleDetailModel? get on100000;
/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExamplesModelCopyWith<ExamplesModel> get copyWith => _$ExamplesModelCopyWithImpl<ExamplesModel>(this as ExamplesModel, _$identity);

  /// Serializes this ExamplesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExamplesModel&&(identical(other.on100000, on100000) || other.on100000 == on100000));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,on100000);

@override
String toString() {
  return 'ExamplesModel(on100000: $on100000)';
}


}

/// @nodoc
abstract mixin class $ExamplesModelCopyWith<$Res>  {
  factory $ExamplesModelCopyWith(ExamplesModel value, $Res Function(ExamplesModel) _then) = _$ExamplesModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'on100000') ExampleDetailModel? on100000
});


$ExampleDetailModelCopyWith<$Res>? get on100000;

}
/// @nodoc
class _$ExamplesModelCopyWithImpl<$Res>
    implements $ExamplesModelCopyWith<$Res> {
  _$ExamplesModelCopyWithImpl(this._self, this._then);

  final ExamplesModel _self;
  final $Res Function(ExamplesModel) _then;

/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? on100000 = freezed,}) {
  return _then(_self.copyWith(
on100000: freezed == on100000 ? _self.on100000 : on100000 // ignore: cast_nullable_to_non_nullable
as ExampleDetailModel?,
  ));
}
/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExampleDetailModelCopyWith<$Res>? get on100000 {
    if (_self.on100000 == null) {
    return null;
  }

  return $ExampleDetailModelCopyWith<$Res>(_self.on100000!, (value) {
    return _then(_self.copyWith(on100000: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExamplesModel].
extension ExamplesModelPatterns on ExamplesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExamplesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExamplesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExamplesModel value)  $default,){
final _that = this;
switch (_that) {
case _ExamplesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExamplesModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExamplesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'on100000')  ExampleDetailModel? on100000)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExamplesModel() when $default != null:
return $default(_that.on100000);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'on100000')  ExampleDetailModel? on100000)  $default,) {final _that = this;
switch (_that) {
case _ExamplesModel():
return $default(_that.on100000);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'on100000')  ExampleDetailModel? on100000)?  $default,) {final _that = this;
switch (_that) {
case _ExamplesModel() when $default != null:
return $default(_that.on100000);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExamplesModel implements ExamplesModel {
  const _ExamplesModel({@JsonKey(name: 'on100000') this.on100000});
  factory _ExamplesModel.fromJson(Map<String, dynamic> json) => _$ExamplesModelFromJson(json);

@override@JsonKey(name: 'on100000') final  ExampleDetailModel? on100000;

/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExamplesModelCopyWith<_ExamplesModel> get copyWith => __$ExamplesModelCopyWithImpl<_ExamplesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExamplesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExamplesModel&&(identical(other.on100000, on100000) || other.on100000 == on100000));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,on100000);

@override
String toString() {
  return 'ExamplesModel(on100000: $on100000)';
}


}

/// @nodoc
abstract mixin class _$ExamplesModelCopyWith<$Res> implements $ExamplesModelCopyWith<$Res> {
  factory _$ExamplesModelCopyWith(_ExamplesModel value, $Res Function(_ExamplesModel) _then) = __$ExamplesModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'on100000') ExampleDetailModel? on100000
});


@override $ExampleDetailModelCopyWith<$Res>? get on100000;

}
/// @nodoc
class __$ExamplesModelCopyWithImpl<$Res>
    implements _$ExamplesModelCopyWith<$Res> {
  __$ExamplesModelCopyWithImpl(this._self, this._then);

  final _ExamplesModel _self;
  final $Res Function(_ExamplesModel) _then;

/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? on100000 = freezed,}) {
  return _then(_ExamplesModel(
on100000: freezed == on100000 ? _self.on100000 : on100000 // ignore: cast_nullable_to_non_nullable
as ExampleDetailModel?,
  ));
}

/// Create a copy of ExamplesModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExampleDetailModelCopyWith<$Res>? get on100000 {
    if (_self.on100000 == null) {
    return null;
  }

  return $ExampleDetailModelCopyWith<$Res>(_self.on100000!, (value) {
    return _then(_self.copyWith(on100000: value));
  });
}
}


/// @nodoc
mixin _$ExampleDetailModel {

 String get invested; String get totalReturn; String get maturityAmount; String get periodicReturn;
/// Create a copy of ExampleDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExampleDetailModelCopyWith<ExampleDetailModel> get copyWith => _$ExampleDetailModelCopyWithImpl<ExampleDetailModel>(this as ExampleDetailModel, _$identity);

  /// Serializes this ExampleDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExampleDetailModel&&(identical(other.invested, invested) || other.invested == invested)&&(identical(other.totalReturn, totalReturn) || other.totalReturn == totalReturn)&&(identical(other.maturityAmount, maturityAmount) || other.maturityAmount == maturityAmount)&&(identical(other.periodicReturn, periodicReturn) || other.periodicReturn == periodicReturn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invested,totalReturn,maturityAmount,periodicReturn);

@override
String toString() {
  return 'ExampleDetailModel(invested: $invested, totalReturn: $totalReturn, maturityAmount: $maturityAmount, periodicReturn: $periodicReturn)';
}


}

/// @nodoc
abstract mixin class $ExampleDetailModelCopyWith<$Res>  {
  factory $ExampleDetailModelCopyWith(ExampleDetailModel value, $Res Function(ExampleDetailModel) _then) = _$ExampleDetailModelCopyWithImpl;
@useResult
$Res call({
 String invested, String totalReturn, String maturityAmount, String periodicReturn
});




}
/// @nodoc
class _$ExampleDetailModelCopyWithImpl<$Res>
    implements $ExampleDetailModelCopyWith<$Res> {
  _$ExampleDetailModelCopyWithImpl(this._self, this._then);

  final ExampleDetailModel _self;
  final $Res Function(ExampleDetailModel) _then;

/// Create a copy of ExampleDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invested = null,Object? totalReturn = null,Object? maturityAmount = null,Object? periodicReturn = null,}) {
  return _then(_self.copyWith(
invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as String,totalReturn: null == totalReturn ? _self.totalReturn : totalReturn // ignore: cast_nullable_to_non_nullable
as String,maturityAmount: null == maturityAmount ? _self.maturityAmount : maturityAmount // ignore: cast_nullable_to_non_nullable
as String,periodicReturn: null == periodicReturn ? _self.periodicReturn : periodicReturn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExampleDetailModel].
extension ExampleDetailModelPatterns on ExampleDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExampleDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExampleDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExampleDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _ExampleDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExampleDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExampleDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String invested,  String totalReturn,  String maturityAmount,  String periodicReturn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExampleDetailModel() when $default != null:
return $default(_that.invested,_that.totalReturn,_that.maturityAmount,_that.periodicReturn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String invested,  String totalReturn,  String maturityAmount,  String periodicReturn)  $default,) {final _that = this;
switch (_that) {
case _ExampleDetailModel():
return $default(_that.invested,_that.totalReturn,_that.maturityAmount,_that.periodicReturn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String invested,  String totalReturn,  String maturityAmount,  String periodicReturn)?  $default,) {final _that = this;
switch (_that) {
case _ExampleDetailModel() when $default != null:
return $default(_that.invested,_that.totalReturn,_that.maturityAmount,_that.periodicReturn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExampleDetailModel implements ExampleDetailModel {
  const _ExampleDetailModel({this.invested = '', this.totalReturn = '', this.maturityAmount = '', this.periodicReturn = ''});
  factory _ExampleDetailModel.fromJson(Map<String, dynamic> json) => _$ExampleDetailModelFromJson(json);

@override@JsonKey() final  String invested;
@override@JsonKey() final  String totalReturn;
@override@JsonKey() final  String maturityAmount;
@override@JsonKey() final  String periodicReturn;

/// Create a copy of ExampleDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExampleDetailModelCopyWith<_ExampleDetailModel> get copyWith => __$ExampleDetailModelCopyWithImpl<_ExampleDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExampleDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExampleDetailModel&&(identical(other.invested, invested) || other.invested == invested)&&(identical(other.totalReturn, totalReturn) || other.totalReturn == totalReturn)&&(identical(other.maturityAmount, maturityAmount) || other.maturityAmount == maturityAmount)&&(identical(other.periodicReturn, periodicReturn) || other.periodicReturn == periodicReturn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,invested,totalReturn,maturityAmount,periodicReturn);

@override
String toString() {
  return 'ExampleDetailModel(invested: $invested, totalReturn: $totalReturn, maturityAmount: $maturityAmount, periodicReturn: $periodicReturn)';
}


}

/// @nodoc
abstract mixin class _$ExampleDetailModelCopyWith<$Res> implements $ExampleDetailModelCopyWith<$Res> {
  factory _$ExampleDetailModelCopyWith(_ExampleDetailModel value, $Res Function(_ExampleDetailModel) _then) = __$ExampleDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String invested, String totalReturn, String maturityAmount, String periodicReturn
});




}
/// @nodoc
class __$ExampleDetailModelCopyWithImpl<$Res>
    implements _$ExampleDetailModelCopyWith<$Res> {
  __$ExampleDetailModelCopyWithImpl(this._self, this._then);

  final _ExampleDetailModel _self;
  final $Res Function(_ExampleDetailModel) _then;

/// Create a copy of ExampleDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invested = null,Object? totalReturn = null,Object? maturityAmount = null,Object? periodicReturn = null,}) {
  return _then(_ExampleDetailModel(
invested: null == invested ? _self.invested : invested // ignore: cast_nullable_to_non_nullable
as String,totalReturn: null == totalReturn ? _self.totalReturn : totalReturn // ignore: cast_nullable_to_non_nullable
as String,maturityAmount: null == maturityAmount ? _self.maturityAmount : maturityAmount // ignore: cast_nullable_to_non_nullable
as String,periodicReturn: null == periodicReturn ? _self.periodicReturn : periodicReturn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SummaryModel {

 String get investmentRange; String get duration; String get expectedReturn; String get totalReturn; String get lockInPeriod; String get riskLevel; String get roiFrequency;
/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SummaryModelCopyWith<SummaryModel> get copyWith => _$SummaryModelCopyWithImpl<SummaryModel>(this as SummaryModel, _$identity);

  /// Serializes this SummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SummaryModel&&(identical(other.investmentRange, investmentRange) || other.investmentRange == investmentRange)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.expectedReturn, expectedReturn) || other.expectedReturn == expectedReturn)&&(identical(other.totalReturn, totalReturn) || other.totalReturn == totalReturn)&&(identical(other.lockInPeriod, lockInPeriod) || other.lockInPeriod == lockInPeriod)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,investmentRange,duration,expectedReturn,totalReturn,lockInPeriod,riskLevel,roiFrequency);

@override
String toString() {
  return 'SummaryModel(investmentRange: $investmentRange, duration: $duration, expectedReturn: $expectedReturn, totalReturn: $totalReturn, lockInPeriod: $lockInPeriod, riskLevel: $riskLevel, roiFrequency: $roiFrequency)';
}


}

/// @nodoc
abstract mixin class $SummaryModelCopyWith<$Res>  {
  factory $SummaryModelCopyWith(SummaryModel value, $Res Function(SummaryModel) _then) = _$SummaryModelCopyWithImpl;
@useResult
$Res call({
 String investmentRange, String duration, String expectedReturn, String totalReturn, String lockInPeriod, String riskLevel, String roiFrequency
});




}
/// @nodoc
class _$SummaryModelCopyWithImpl<$Res>
    implements $SummaryModelCopyWith<$Res> {
  _$SummaryModelCopyWithImpl(this._self, this._then);

  final SummaryModel _self;
  final $Res Function(SummaryModel) _then;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? investmentRange = null,Object? duration = null,Object? expectedReturn = null,Object? totalReturn = null,Object? lockInPeriod = null,Object? riskLevel = null,Object? roiFrequency = null,}) {
  return _then(_self.copyWith(
investmentRange: null == investmentRange ? _self.investmentRange : investmentRange // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,expectedReturn: null == expectedReturn ? _self.expectedReturn : expectedReturn // ignore: cast_nullable_to_non_nullable
as String,totalReturn: null == totalReturn ? _self.totalReturn : totalReturn // ignore: cast_nullable_to_non_nullable
as String,lockInPeriod: null == lockInPeriod ? _self.lockInPeriod : lockInPeriod // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SummaryModel].
extension SummaryModelPatterns on SummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _SummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String investmentRange,  String duration,  String expectedReturn,  String totalReturn,  String lockInPeriod,  String riskLevel,  String roiFrequency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
return $default(_that.investmentRange,_that.duration,_that.expectedReturn,_that.totalReturn,_that.lockInPeriod,_that.riskLevel,_that.roiFrequency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String investmentRange,  String duration,  String expectedReturn,  String totalReturn,  String lockInPeriod,  String riskLevel,  String roiFrequency)  $default,) {final _that = this;
switch (_that) {
case _SummaryModel():
return $default(_that.investmentRange,_that.duration,_that.expectedReturn,_that.totalReturn,_that.lockInPeriod,_that.riskLevel,_that.roiFrequency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String investmentRange,  String duration,  String expectedReturn,  String totalReturn,  String lockInPeriod,  String riskLevel,  String roiFrequency)?  $default,) {final _that = this;
switch (_that) {
case _SummaryModel() when $default != null:
return $default(_that.investmentRange,_that.duration,_that.expectedReturn,_that.totalReturn,_that.lockInPeriod,_that.riskLevel,_that.roiFrequency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SummaryModel implements SummaryModel {
  const _SummaryModel({this.investmentRange = '', this.duration = '', this.expectedReturn = '', this.totalReturn = '', this.lockInPeriod = '', this.riskLevel = '', this.roiFrequency = ''});
  factory _SummaryModel.fromJson(Map<String, dynamic> json) => _$SummaryModelFromJson(json);

@override@JsonKey() final  String investmentRange;
@override@JsonKey() final  String duration;
@override@JsonKey() final  String expectedReturn;
@override@JsonKey() final  String totalReturn;
@override@JsonKey() final  String lockInPeriod;
@override@JsonKey() final  String riskLevel;
@override@JsonKey() final  String roiFrequency;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryModelCopyWith<_SummaryModel> get copyWith => __$SummaryModelCopyWithImpl<_SummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryModel&&(identical(other.investmentRange, investmentRange) || other.investmentRange == investmentRange)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.expectedReturn, expectedReturn) || other.expectedReturn == expectedReturn)&&(identical(other.totalReturn, totalReturn) || other.totalReturn == totalReturn)&&(identical(other.lockInPeriod, lockInPeriod) || other.lockInPeriod == lockInPeriod)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.roiFrequency, roiFrequency) || other.roiFrequency == roiFrequency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,investmentRange,duration,expectedReturn,totalReturn,lockInPeriod,riskLevel,roiFrequency);

@override
String toString() {
  return 'SummaryModel(investmentRange: $investmentRange, duration: $duration, expectedReturn: $expectedReturn, totalReturn: $totalReturn, lockInPeriod: $lockInPeriod, riskLevel: $riskLevel, roiFrequency: $roiFrequency)';
}


}

/// @nodoc
abstract mixin class _$SummaryModelCopyWith<$Res> implements $SummaryModelCopyWith<$Res> {
  factory _$SummaryModelCopyWith(_SummaryModel value, $Res Function(_SummaryModel) _then) = __$SummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String investmentRange, String duration, String expectedReturn, String totalReturn, String lockInPeriod, String riskLevel, String roiFrequency
});




}
/// @nodoc
class __$SummaryModelCopyWithImpl<$Res>
    implements _$SummaryModelCopyWith<$Res> {
  __$SummaryModelCopyWithImpl(this._self, this._then);

  final _SummaryModel _self;
  final $Res Function(_SummaryModel) _then;

/// Create a copy of SummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? investmentRange = null,Object? duration = null,Object? expectedReturn = null,Object? totalReturn = null,Object? lockInPeriod = null,Object? riskLevel = null,Object? roiFrequency = null,}) {
  return _then(_SummaryModel(
investmentRange: null == investmentRange ? _self.investmentRange : investmentRange // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,expectedReturn: null == expectedReturn ? _self.expectedReturn : expectedReturn // ignore: cast_nullable_to_non_nullable
as String,totalReturn: null == totalReturn ? _self.totalReturn : totalReturn // ignore: cast_nullable_to_non_nullable
as String,lockInPeriod: null == lockInPeriod ? _self.lockInPeriod : lockInPeriod // ignore: cast_nullable_to_non_nullable
as String,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,roiFrequency: null == roiFrequency ? _self.roiFrequency : roiFrequency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$InvestmentGuideModel {

 int get minimumAmount; int get recommendedDuration; String get expectedAnnualReturn; bool get lockInRequired; String get exitPenalty; String get roiOption;
/// Create a copy of InvestmentGuideModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentGuideModelCopyWith<InvestmentGuideModel> get copyWith => _$InvestmentGuideModelCopyWithImpl<InvestmentGuideModel>(this as InvestmentGuideModel, _$identity);

  /// Serializes this InvestmentGuideModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestmentGuideModel&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.recommendedDuration, recommendedDuration) || other.recommendedDuration == recommendedDuration)&&(identical(other.expectedAnnualReturn, expectedAnnualReturn) || other.expectedAnnualReturn == expectedAnnualReturn)&&(identical(other.lockInRequired, lockInRequired) || other.lockInRequired == lockInRequired)&&(identical(other.exitPenalty, exitPenalty) || other.exitPenalty == exitPenalty)&&(identical(other.roiOption, roiOption) || other.roiOption == roiOption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimumAmount,recommendedDuration,expectedAnnualReturn,lockInRequired,exitPenalty,roiOption);

@override
String toString() {
  return 'InvestmentGuideModel(minimumAmount: $minimumAmount, recommendedDuration: $recommendedDuration, expectedAnnualReturn: $expectedAnnualReturn, lockInRequired: $lockInRequired, exitPenalty: $exitPenalty, roiOption: $roiOption)';
}


}

/// @nodoc
abstract mixin class $InvestmentGuideModelCopyWith<$Res>  {
  factory $InvestmentGuideModelCopyWith(InvestmentGuideModel value, $Res Function(InvestmentGuideModel) _then) = _$InvestmentGuideModelCopyWithImpl;
@useResult
$Res call({
 int minimumAmount, int recommendedDuration, String expectedAnnualReturn, bool lockInRequired, String exitPenalty, String roiOption
});




}
/// @nodoc
class _$InvestmentGuideModelCopyWithImpl<$Res>
    implements $InvestmentGuideModelCopyWith<$Res> {
  _$InvestmentGuideModelCopyWithImpl(this._self, this._then);

  final InvestmentGuideModel _self;
  final $Res Function(InvestmentGuideModel) _then;

/// Create a copy of InvestmentGuideModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minimumAmount = null,Object? recommendedDuration = null,Object? expectedAnnualReturn = null,Object? lockInRequired = null,Object? exitPenalty = null,Object? roiOption = null,}) {
  return _then(_self.copyWith(
minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as int,recommendedDuration: null == recommendedDuration ? _self.recommendedDuration : recommendedDuration // ignore: cast_nullable_to_non_nullable
as int,expectedAnnualReturn: null == expectedAnnualReturn ? _self.expectedAnnualReturn : expectedAnnualReturn // ignore: cast_nullable_to_non_nullable
as String,lockInRequired: null == lockInRequired ? _self.lockInRequired : lockInRequired // ignore: cast_nullable_to_non_nullable
as bool,exitPenalty: null == exitPenalty ? _self.exitPenalty : exitPenalty // ignore: cast_nullable_to_non_nullable
as String,roiOption: null == roiOption ? _self.roiOption : roiOption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InvestmentGuideModel].
extension InvestmentGuideModelPatterns on InvestmentGuideModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvestmentGuideModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvestmentGuideModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvestmentGuideModel value)  $default,){
final _that = this;
switch (_that) {
case _InvestmentGuideModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvestmentGuideModel value)?  $default,){
final _that = this;
switch (_that) {
case _InvestmentGuideModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int minimumAmount,  int recommendedDuration,  String expectedAnnualReturn,  bool lockInRequired,  String exitPenalty,  String roiOption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestmentGuideModel() when $default != null:
return $default(_that.minimumAmount,_that.recommendedDuration,_that.expectedAnnualReturn,_that.lockInRequired,_that.exitPenalty,_that.roiOption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int minimumAmount,  int recommendedDuration,  String expectedAnnualReturn,  bool lockInRequired,  String exitPenalty,  String roiOption)  $default,) {final _that = this;
switch (_that) {
case _InvestmentGuideModel():
return $default(_that.minimumAmount,_that.recommendedDuration,_that.expectedAnnualReturn,_that.lockInRequired,_that.exitPenalty,_that.roiOption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int minimumAmount,  int recommendedDuration,  String expectedAnnualReturn,  bool lockInRequired,  String exitPenalty,  String roiOption)?  $default,) {final _that = this;
switch (_that) {
case _InvestmentGuideModel() when $default != null:
return $default(_that.minimumAmount,_that.recommendedDuration,_that.expectedAnnualReturn,_that.lockInRequired,_that.exitPenalty,_that.roiOption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestmentGuideModel implements InvestmentGuideModel {
  const _InvestmentGuideModel({this.minimumAmount = 0, this.recommendedDuration = 0, this.expectedAnnualReturn = '', this.lockInRequired = false, this.exitPenalty = '', this.roiOption = ''});
  factory _InvestmentGuideModel.fromJson(Map<String, dynamic> json) => _$InvestmentGuideModelFromJson(json);

@override@JsonKey() final  int minimumAmount;
@override@JsonKey() final  int recommendedDuration;
@override@JsonKey() final  String expectedAnnualReturn;
@override@JsonKey() final  bool lockInRequired;
@override@JsonKey() final  String exitPenalty;
@override@JsonKey() final  String roiOption;

/// Create a copy of InvestmentGuideModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvestmentGuideModelCopyWith<_InvestmentGuideModel> get copyWith => __$InvestmentGuideModelCopyWithImpl<_InvestmentGuideModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvestmentGuideModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestmentGuideModel&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.recommendedDuration, recommendedDuration) || other.recommendedDuration == recommendedDuration)&&(identical(other.expectedAnnualReturn, expectedAnnualReturn) || other.expectedAnnualReturn == expectedAnnualReturn)&&(identical(other.lockInRequired, lockInRequired) || other.lockInRequired == lockInRequired)&&(identical(other.exitPenalty, exitPenalty) || other.exitPenalty == exitPenalty)&&(identical(other.roiOption, roiOption) || other.roiOption == roiOption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimumAmount,recommendedDuration,expectedAnnualReturn,lockInRequired,exitPenalty,roiOption);

@override
String toString() {
  return 'InvestmentGuideModel(minimumAmount: $minimumAmount, recommendedDuration: $recommendedDuration, expectedAnnualReturn: $expectedAnnualReturn, lockInRequired: $lockInRequired, exitPenalty: $exitPenalty, roiOption: $roiOption)';
}


}

/// @nodoc
abstract mixin class _$InvestmentGuideModelCopyWith<$Res> implements $InvestmentGuideModelCopyWith<$Res> {
  factory _$InvestmentGuideModelCopyWith(_InvestmentGuideModel value, $Res Function(_InvestmentGuideModel) _then) = __$InvestmentGuideModelCopyWithImpl;
@override @useResult
$Res call({
 int minimumAmount, int recommendedDuration, String expectedAnnualReturn, bool lockInRequired, String exitPenalty, String roiOption
});




}
/// @nodoc
class __$InvestmentGuideModelCopyWithImpl<$Res>
    implements _$InvestmentGuideModelCopyWith<$Res> {
  __$InvestmentGuideModelCopyWithImpl(this._self, this._then);

  final _InvestmentGuideModel _self;
  final $Res Function(_InvestmentGuideModel) _then;

/// Create a copy of InvestmentGuideModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minimumAmount = null,Object? recommendedDuration = null,Object? expectedAnnualReturn = null,Object? lockInRequired = null,Object? exitPenalty = null,Object? roiOption = null,}) {
  return _then(_InvestmentGuideModel(
minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as int,recommendedDuration: null == recommendedDuration ? _self.recommendedDuration : recommendedDuration // ignore: cast_nullable_to_non_nullable
as int,expectedAnnualReturn: null == expectedAnnualReturn ? _self.expectedAnnualReturn : expectedAnnualReturn // ignore: cast_nullable_to_non_nullable
as String,lockInRequired: null == lockInRequired ? _self.lockInRequired : lockInRequired // ignore: cast_nullable_to_non_nullable
as bool,exitPenalty: null == exitPenalty ? _self.exitPenalty : exitPenalty // ignore: cast_nullable_to_non_nullable
as String,roiOption: null == roiOption ? _self.roiOption : roiOption // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
