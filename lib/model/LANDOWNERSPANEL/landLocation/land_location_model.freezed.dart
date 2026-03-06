// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'land_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LandLocationModel {

 bool get success; String get message; LandLocationData get data;
/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandLocationModelCopyWith<LandLocationModel> get copyWith => _$LandLocationModelCopyWithImpl<LandLocationModel>(this as LandLocationModel, _$identity);

  /// Serializes this LandLocationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandLocationModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'LandLocationModel(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $LandLocationModelCopyWith<$Res>  {
  factory $LandLocationModelCopyWith(LandLocationModel value, $Res Function(LandLocationModel) _then) = _$LandLocationModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message, LandLocationData data
});


$LandLocationDataCopyWith<$Res> get data;

}
/// @nodoc
class _$LandLocationModelCopyWithImpl<$Res>
    implements $LandLocationModelCopyWith<$Res> {
  _$LandLocationModelCopyWithImpl(this._self, this._then);

  final LandLocationModel _self;
  final $Res Function(LandLocationModel) _then;

/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LandLocationData,
  ));
}
/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LandLocationDataCopyWith<$Res> get data {
  
  return $LandLocationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [LandLocationModel].
extension LandLocationModelPatterns on LandLocationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandLocationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandLocationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandLocationModel value)  $default,){
final _that = this;
switch (_that) {
case _LandLocationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandLocationModel value)?  $default,){
final _that = this;
switch (_that) {
case _LandLocationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  LandLocationData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandLocationModel() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  LandLocationData data)  $default,) {final _that = this;
switch (_that) {
case _LandLocationModel():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  LandLocationData data)?  $default,) {final _that = this;
switch (_that) {
case _LandLocationModel() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LandLocationModel implements LandLocationModel {
  const _LandLocationModel({required this.success, required this.message, required this.data});
  factory _LandLocationModel.fromJson(Map<String, dynamic> json) => _$LandLocationModelFromJson(json);

@override final  bool success;
@override final  String message;
@override final  LandLocationData data;

/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandLocationModelCopyWith<_LandLocationModel> get copyWith => __$LandLocationModelCopyWithImpl<_LandLocationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LandLocationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandLocationModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'LandLocationModel(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$LandLocationModelCopyWith<$Res> implements $LandLocationModelCopyWith<$Res> {
  factory _$LandLocationModelCopyWith(_LandLocationModel value, $Res Function(_LandLocationModel) _then) = __$LandLocationModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, LandLocationData data
});


@override $LandLocationDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LandLocationModelCopyWithImpl<$Res>
    implements _$LandLocationModelCopyWith<$Res> {
  __$LandLocationModelCopyWithImpl(this._self, this._then);

  final _LandLocationModel _self;
  final $Res Function(_LandLocationModel) _then;

/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_LandLocationModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LandLocationData,
  ));
}

/// Create a copy of LandLocationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LandLocationDataCopyWith<$Res> get data {
  
  return $LandLocationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$LandLocationData {

 String get tempId; int get currentStep; String get nextStep; DateTime get expiresAt;
/// Create a copy of LandLocationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandLocationDataCopyWith<LandLocationData> get copyWith => _$LandLocationDataCopyWithImpl<LandLocationData>(this as LandLocationData, _$identity);

  /// Serializes this LandLocationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandLocationData&&(identical(other.tempId, tempId) || other.tempId == tempId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tempId,currentStep,nextStep,expiresAt);

@override
String toString() {
  return 'LandLocationData(tempId: $tempId, currentStep: $currentStep, nextStep: $nextStep, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $LandLocationDataCopyWith<$Res>  {
  factory $LandLocationDataCopyWith(LandLocationData value, $Res Function(LandLocationData) _then) = _$LandLocationDataCopyWithImpl;
@useResult
$Res call({
 String tempId, int currentStep, String nextStep, DateTime expiresAt
});




}
/// @nodoc
class _$LandLocationDataCopyWithImpl<$Res>
    implements $LandLocationDataCopyWith<$Res> {
  _$LandLocationDataCopyWithImpl(this._self, this._then);

  final LandLocationData _self;
  final $Res Function(LandLocationData) _then;

/// Create a copy of LandLocationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tempId = null,Object? currentStep = null,Object? nextStep = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
tempId: null == tempId ? _self.tempId : tempId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LandLocationData].
extension LandLocationDataPatterns on LandLocationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandLocationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandLocationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandLocationData value)  $default,){
final _that = this;
switch (_that) {
case _LandLocationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandLocationData value)?  $default,){
final _that = this;
switch (_that) {
case _LandLocationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tempId,  int currentStep,  String nextStep,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandLocationData() when $default != null:
return $default(_that.tempId,_that.currentStep,_that.nextStep,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tempId,  int currentStep,  String nextStep,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _LandLocationData():
return $default(_that.tempId,_that.currentStep,_that.nextStep,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tempId,  int currentStep,  String nextStep,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _LandLocationData() when $default != null:
return $default(_that.tempId,_that.currentStep,_that.nextStep,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LandLocationData implements LandLocationData {
  const _LandLocationData({required this.tempId, required this.currentStep, required this.nextStep, required this.expiresAt});
  factory _LandLocationData.fromJson(Map<String, dynamic> json) => _$LandLocationDataFromJson(json);

@override final  String tempId;
@override final  int currentStep;
@override final  String nextStep;
@override final  DateTime expiresAt;

/// Create a copy of LandLocationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandLocationDataCopyWith<_LandLocationData> get copyWith => __$LandLocationDataCopyWithImpl<_LandLocationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LandLocationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandLocationData&&(identical(other.tempId, tempId) || other.tempId == tempId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tempId,currentStep,nextStep,expiresAt);

@override
String toString() {
  return 'LandLocationData(tempId: $tempId, currentStep: $currentStep, nextStep: $nextStep, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$LandLocationDataCopyWith<$Res> implements $LandLocationDataCopyWith<$Res> {
  factory _$LandLocationDataCopyWith(_LandLocationData value, $Res Function(_LandLocationData) _then) = __$LandLocationDataCopyWithImpl;
@override @useResult
$Res call({
 String tempId, int currentStep, String nextStep, DateTime expiresAt
});




}
/// @nodoc
class __$LandLocationDataCopyWithImpl<$Res>
    implements _$LandLocationDataCopyWith<$Res> {
  __$LandLocationDataCopyWithImpl(this._self, this._then);

  final _LandLocationData _self;
  final $Res Function(_LandLocationData) _then;

/// Create a copy of LandLocationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tempId = null,Object? currentStep = null,Object? nextStep = null,Object? expiresAt = null,}) {
  return _then(_LandLocationData(
tempId: null == tempId ? _self.tempId : tempId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
