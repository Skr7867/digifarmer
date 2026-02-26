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

@JsonKey(name: '_id') String get id; String get planId; String get planName; String get description; int get minInvestment; int get maxInvestment; int get defaultDurationMonths; List<int> get availableDurations; int get baseReturnPercent;/// Map<String, num> is better because multiplier may be double (1.2)
 Map<String, num> get durationMultipliers; List<String> get availableRoiFrequencies; String get defaultRoiFrequency; int get lockInPeriodMonths; bool get prematureExitAllowed; int get prematureExitPenalty; String get riskLevel; bool get isActive; bool get isPopular; String get createdAt; String get updatedAt;@JsonKey(name: '__v') int get version;
/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvestmentPlanModelCopyWith<InvestmentPlanModel> get copyWith => _$InvestmentPlanModelCopyWithImpl<InvestmentPlanModel>(this as InvestmentPlanModel, _$identity);

  /// Serializes this InvestmentPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvestmentPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.description, description) || other.description == description)&&(identical(other.minInvestment, minInvestment) || other.minInvestment == minInvestment)&&(identical(other.maxInvestment, maxInvestment) || other.maxInvestment == maxInvestment)&&(identical(other.defaultDurationMonths, defaultDurationMonths) || other.defaultDurationMonths == defaultDurationMonths)&&const DeepCollectionEquality().equals(other.availableDurations, availableDurations)&&(identical(other.baseReturnPercent, baseReturnPercent) || other.baseReturnPercent == baseReturnPercent)&&const DeepCollectionEquality().equals(other.durationMultipliers, durationMultipliers)&&const DeepCollectionEquality().equals(other.availableRoiFrequencies, availableRoiFrequencies)&&(identical(other.defaultRoiFrequency, defaultRoiFrequency) || other.defaultRoiFrequency == defaultRoiFrequency)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.prematureExitPenalty, prematureExitPenalty) || other.prematureExitPenalty == prematureExitPenalty)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,planId,planName,description,minInvestment,maxInvestment,defaultDurationMonths,const DeepCollectionEquality().hash(availableDurations),baseReturnPercent,const DeepCollectionEquality().hash(durationMultipliers),const DeepCollectionEquality().hash(availableRoiFrequencies),defaultRoiFrequency,lockInPeriodMonths,prematureExitAllowed,prematureExitPenalty,riskLevel,isActive,isPopular,createdAt,updatedAt,version]);

@override
String toString() {
  return 'InvestmentPlanModel(id: $id, planId: $planId, planName: $planName, description: $description, minInvestment: $minInvestment, maxInvestment: $maxInvestment, defaultDurationMonths: $defaultDurationMonths, availableDurations: $availableDurations, baseReturnPercent: $baseReturnPercent, durationMultipliers: $durationMultipliers, availableRoiFrequencies: $availableRoiFrequencies, defaultRoiFrequency: $defaultRoiFrequency, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, prematureExitPenalty: $prematureExitPenalty, riskLevel: $riskLevel, isActive: $isActive, isPopular: $isPopular, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class $InvestmentPlanModelCopyWith<$Res>  {
  factory $InvestmentPlanModelCopyWith(InvestmentPlanModel value, $Res Function(InvestmentPlanModel) _then) = _$InvestmentPlanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: '_id') String id, String planId, String planName, String description, int minInvestment, int maxInvestment, int defaultDurationMonths, List<int> availableDurations, int baseReturnPercent, Map<String, num> durationMultipliers, List<String> availableRoiFrequencies, String defaultRoiFrequency, int lockInPeriodMonths, bool prematureExitAllowed, int prematureExitPenalty, String riskLevel, bool isActive, bool isPopular, String createdAt, String updatedAt,@JsonKey(name: '__v') int version
});




}
/// @nodoc
class _$InvestmentPlanModelCopyWithImpl<$Res>
    implements $InvestmentPlanModelCopyWith<$Res> {
  _$InvestmentPlanModelCopyWithImpl(this._self, this._then);

  final InvestmentPlanModel _self;
  final $Res Function(InvestmentPlanModel) _then;

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? description = null,Object? minInvestment = null,Object? maxInvestment = null,Object? defaultDurationMonths = null,Object? availableDurations = null,Object? baseReturnPercent = null,Object? durationMultipliers = null,Object? availableRoiFrequencies = null,Object? defaultRoiFrequency = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? prematureExitPenalty = null,Object? riskLevel = null,Object? isActive = null,Object? isPopular = null,Object? createdAt = null,Object? updatedAt = null,Object? version = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minInvestment: null == minInvestment ? _self.minInvestment : minInvestment // ignore: cast_nullable_to_non_nullable
as int,maxInvestment: null == maxInvestment ? _self.maxInvestment : maxInvestment // ignore: cast_nullable_to_non_nullable
as int,defaultDurationMonths: null == defaultDurationMonths ? _self.defaultDurationMonths : defaultDurationMonths // ignore: cast_nullable_to_non_nullable
as int,availableDurations: null == availableDurations ? _self.availableDurations : availableDurations // ignore: cast_nullable_to_non_nullable
as List<int>,baseReturnPercent: null == baseReturnPercent ? _self.baseReturnPercent : baseReturnPercent // ignore: cast_nullable_to_non_nullable
as int,durationMultipliers: null == durationMultipliers ? _self.durationMultipliers : durationMultipliers // ignore: cast_nullable_to_non_nullable
as Map<String, num>,availableRoiFrequencies: null == availableRoiFrequencies ? _self.availableRoiFrequencies : availableRoiFrequencies // ignore: cast_nullable_to_non_nullable
as List<String>,defaultRoiFrequency: null == defaultRoiFrequency ? _self.defaultRoiFrequency : defaultRoiFrequency // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,prematureExitPenalty: null == prematureExitPenalty ? _self.prematureExitPenalty : prematureExitPenalty // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int defaultDurationMonths,  List<int> availableDurations,  int baseReturnPercent,  Map<String, num> durationMultipliers,  List<String> availableRoiFrequencies,  String defaultRoiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt, @JsonKey(name: '__v')  int version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.defaultDurationMonths,_that.availableDurations,_that.baseReturnPercent,_that.durationMultipliers,_that.availableRoiFrequencies,_that.defaultRoiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int defaultDurationMonths,  List<int> availableDurations,  int baseReturnPercent,  Map<String, num> durationMultipliers,  List<String> availableRoiFrequencies,  String defaultRoiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt, @JsonKey(name: '__v')  int version)  $default,) {final _that = this;
switch (_that) {
case _InvestmentPlanModel():
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.defaultDurationMonths,_that.availableDurations,_that.baseReturnPercent,_that.durationMultipliers,_that.availableRoiFrequencies,_that.defaultRoiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: '_id')  String id,  String planId,  String planName,  String description,  int minInvestment,  int maxInvestment,  int defaultDurationMonths,  List<int> availableDurations,  int baseReturnPercent,  Map<String, num> durationMultipliers,  List<String> availableRoiFrequencies,  String defaultRoiFrequency,  int lockInPeriodMonths,  bool prematureExitAllowed,  int prematureExitPenalty,  String riskLevel,  bool isActive,  bool isPopular,  String createdAt,  String updatedAt, @JsonKey(name: '__v')  int version)?  $default,) {final _that = this;
switch (_that) {
case _InvestmentPlanModel() when $default != null:
return $default(_that.id,_that.planId,_that.planName,_that.description,_that.minInvestment,_that.maxInvestment,_that.defaultDurationMonths,_that.availableDurations,_that.baseReturnPercent,_that.durationMultipliers,_that.availableRoiFrequencies,_that.defaultRoiFrequency,_that.lockInPeriodMonths,_that.prematureExitAllowed,_that.prematureExitPenalty,_that.riskLevel,_that.isActive,_that.isPopular,_that.createdAt,_that.updatedAt,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvestmentPlanModel implements InvestmentPlanModel {
  const _InvestmentPlanModel({@JsonKey(name: '_id') this.id = '', this.planId = '', this.planName = '', this.description = '', this.minInvestment = 0, this.maxInvestment = 0, this.defaultDurationMonths = 0, final  List<int> availableDurations = const [], this.baseReturnPercent = 0, final  Map<String, num> durationMultipliers = const {}, final  List<String> availableRoiFrequencies = const [], this.defaultRoiFrequency = '', this.lockInPeriodMonths = 0, this.prematureExitAllowed = false, this.prematureExitPenalty = 0, this.riskLevel = '', this.isActive = false, this.isPopular = false, this.createdAt = '', this.updatedAt = '', @JsonKey(name: '__v') this.version = 0}): _availableDurations = availableDurations,_durationMultipliers = durationMultipliers,_availableRoiFrequencies = availableRoiFrequencies;
  factory _InvestmentPlanModel.fromJson(Map<String, dynamic> json) => _$InvestmentPlanModelFromJson(json);

@override@JsonKey(name: '_id') final  String id;
@override@JsonKey() final  String planId;
@override@JsonKey() final  String planName;
@override@JsonKey() final  String description;
@override@JsonKey() final  int minInvestment;
@override@JsonKey() final  int maxInvestment;
@override@JsonKey() final  int defaultDurationMonths;
 final  List<int> _availableDurations;
@override@JsonKey() List<int> get availableDurations {
  if (_availableDurations is EqualUnmodifiableListView) return _availableDurations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableDurations);
}

@override@JsonKey() final  int baseReturnPercent;
/// Map<String, num> is better because multiplier may be double (1.2)
 final  Map<String, num> _durationMultipliers;
/// Map<String, num> is better because multiplier may be double (1.2)
@override@JsonKey() Map<String, num> get durationMultipliers {
  if (_durationMultipliers is EqualUnmodifiableMapView) return _durationMultipliers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_durationMultipliers);
}

 final  List<String> _availableRoiFrequencies;
@override@JsonKey() List<String> get availableRoiFrequencies {
  if (_availableRoiFrequencies is EqualUnmodifiableListView) return _availableRoiFrequencies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableRoiFrequencies);
}

@override@JsonKey() final  String defaultRoiFrequency;
@override@JsonKey() final  int lockInPeriodMonths;
@override@JsonKey() final  bool prematureExitAllowed;
@override@JsonKey() final  int prematureExitPenalty;
@override@JsonKey() final  String riskLevel;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isPopular;
@override@JsonKey() final  String createdAt;
@override@JsonKey() final  String updatedAt;
@override@JsonKey(name: '__v') final  int version;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvestmentPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.description, description) || other.description == description)&&(identical(other.minInvestment, minInvestment) || other.minInvestment == minInvestment)&&(identical(other.maxInvestment, maxInvestment) || other.maxInvestment == maxInvestment)&&(identical(other.defaultDurationMonths, defaultDurationMonths) || other.defaultDurationMonths == defaultDurationMonths)&&const DeepCollectionEquality().equals(other._availableDurations, _availableDurations)&&(identical(other.baseReturnPercent, baseReturnPercent) || other.baseReturnPercent == baseReturnPercent)&&const DeepCollectionEquality().equals(other._durationMultipliers, _durationMultipliers)&&const DeepCollectionEquality().equals(other._availableRoiFrequencies, _availableRoiFrequencies)&&(identical(other.defaultRoiFrequency, defaultRoiFrequency) || other.defaultRoiFrequency == defaultRoiFrequency)&&(identical(other.lockInPeriodMonths, lockInPeriodMonths) || other.lockInPeriodMonths == lockInPeriodMonths)&&(identical(other.prematureExitAllowed, prematureExitAllowed) || other.prematureExitAllowed == prematureExitAllowed)&&(identical(other.prematureExitPenalty, prematureExitPenalty) || other.prematureExitPenalty == prematureExitPenalty)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,planId,planName,description,minInvestment,maxInvestment,defaultDurationMonths,const DeepCollectionEquality().hash(_availableDurations),baseReturnPercent,const DeepCollectionEquality().hash(_durationMultipliers),const DeepCollectionEquality().hash(_availableRoiFrequencies),defaultRoiFrequency,lockInPeriodMonths,prematureExitAllowed,prematureExitPenalty,riskLevel,isActive,isPopular,createdAt,updatedAt,version]);

@override
String toString() {
  return 'InvestmentPlanModel(id: $id, planId: $planId, planName: $planName, description: $description, minInvestment: $minInvestment, maxInvestment: $maxInvestment, defaultDurationMonths: $defaultDurationMonths, availableDurations: $availableDurations, baseReturnPercent: $baseReturnPercent, durationMultipliers: $durationMultipliers, availableRoiFrequencies: $availableRoiFrequencies, defaultRoiFrequency: $defaultRoiFrequency, lockInPeriodMonths: $lockInPeriodMonths, prematureExitAllowed: $prematureExitAllowed, prematureExitPenalty: $prematureExitPenalty, riskLevel: $riskLevel, isActive: $isActive, isPopular: $isPopular, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
}


}

/// @nodoc
abstract mixin class _$InvestmentPlanModelCopyWith<$Res> implements $InvestmentPlanModelCopyWith<$Res> {
  factory _$InvestmentPlanModelCopyWith(_InvestmentPlanModel value, $Res Function(_InvestmentPlanModel) _then) = __$InvestmentPlanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: '_id') String id, String planId, String planName, String description, int minInvestment, int maxInvestment, int defaultDurationMonths, List<int> availableDurations, int baseReturnPercent, Map<String, num> durationMultipliers, List<String> availableRoiFrequencies, String defaultRoiFrequency, int lockInPeriodMonths, bool prematureExitAllowed, int prematureExitPenalty, String riskLevel, bool isActive, bool isPopular, String createdAt, String updatedAt,@JsonKey(name: '__v') int version
});




}
/// @nodoc
class __$InvestmentPlanModelCopyWithImpl<$Res>
    implements _$InvestmentPlanModelCopyWith<$Res> {
  __$InvestmentPlanModelCopyWithImpl(this._self, this._then);

  final _InvestmentPlanModel _self;
  final $Res Function(_InvestmentPlanModel) _then;

/// Create a copy of InvestmentPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? planName = null,Object? description = null,Object? minInvestment = null,Object? maxInvestment = null,Object? defaultDurationMonths = null,Object? availableDurations = null,Object? baseReturnPercent = null,Object? durationMultipliers = null,Object? availableRoiFrequencies = null,Object? defaultRoiFrequency = null,Object? lockInPeriodMonths = null,Object? prematureExitAllowed = null,Object? prematureExitPenalty = null,Object? riskLevel = null,Object? isActive = null,Object? isPopular = null,Object? createdAt = null,Object? updatedAt = null,Object? version = null,}) {
  return _then(_InvestmentPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,minInvestment: null == minInvestment ? _self.minInvestment : minInvestment // ignore: cast_nullable_to_non_nullable
as int,maxInvestment: null == maxInvestment ? _self.maxInvestment : maxInvestment // ignore: cast_nullable_to_non_nullable
as int,defaultDurationMonths: null == defaultDurationMonths ? _self.defaultDurationMonths : defaultDurationMonths // ignore: cast_nullable_to_non_nullable
as int,availableDurations: null == availableDurations ? _self._availableDurations : availableDurations // ignore: cast_nullable_to_non_nullable
as List<int>,baseReturnPercent: null == baseReturnPercent ? _self.baseReturnPercent : baseReturnPercent // ignore: cast_nullable_to_non_nullable
as int,durationMultipliers: null == durationMultipliers ? _self._durationMultipliers : durationMultipliers // ignore: cast_nullable_to_non_nullable
as Map<String, num>,availableRoiFrequencies: null == availableRoiFrequencies ? _self._availableRoiFrequencies : availableRoiFrequencies // ignore: cast_nullable_to_non_nullable
as List<String>,defaultRoiFrequency: null == defaultRoiFrequency ? _self.defaultRoiFrequency : defaultRoiFrequency // ignore: cast_nullable_to_non_nullable
as String,lockInPeriodMonths: null == lockInPeriodMonths ? _self.lockInPeriodMonths : lockInPeriodMonths // ignore: cast_nullable_to_non_nullable
as int,prematureExitAllowed: null == prematureExitAllowed ? _self.prematureExitAllowed : prematureExitAllowed // ignore: cast_nullable_to_non_nullable
as bool,prematureExitPenalty: null == prematureExitPenalty ? _self.prematureExitPenalty : prematureExitPenalty // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
