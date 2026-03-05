// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_basic_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SaveBasicInfoModel {

 bool get success; String get message; SaveBasicInfoData get data;
/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveBasicInfoModelCopyWith<SaveBasicInfoModel> get copyWith => _$SaveBasicInfoModelCopyWithImpl<SaveBasicInfoModel>(this as SaveBasicInfoModel, _$identity);

  /// Serializes this SaveBasicInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveBasicInfoModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SaveBasicInfoModel(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $SaveBasicInfoModelCopyWith<$Res>  {
  factory $SaveBasicInfoModelCopyWith(SaveBasicInfoModel value, $Res Function(SaveBasicInfoModel) _then) = _$SaveBasicInfoModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message, SaveBasicInfoData data
});


$SaveBasicInfoDataCopyWith<$Res> get data;

}
/// @nodoc
class _$SaveBasicInfoModelCopyWithImpl<$Res>
    implements $SaveBasicInfoModelCopyWith<$Res> {
  _$SaveBasicInfoModelCopyWithImpl(this._self, this._then);

  final SaveBasicInfoModel _self;
  final $Res Function(SaveBasicInfoModel) _then;

/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SaveBasicInfoData,
  ));
}
/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaveBasicInfoDataCopyWith<$Res> get data {
  
  return $SaveBasicInfoDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SaveBasicInfoModel].
extension SaveBasicInfoModelPatterns on SaveBasicInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveBasicInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveBasicInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveBasicInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _SaveBasicInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveBasicInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _SaveBasicInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  SaveBasicInfoData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveBasicInfoModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  SaveBasicInfoData data)  $default,) {final _that = this;
switch (_that) {
case _SaveBasicInfoModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  SaveBasicInfoData data)?  $default,) {final _that = this;
switch (_that) {
case _SaveBasicInfoModel() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaveBasicInfoModel implements SaveBasicInfoModel {
  const _SaveBasicInfoModel({required this.success, required this.message, required this.data});
  factory _SaveBasicInfoModel.fromJson(Map<String, dynamic> json) => _$SaveBasicInfoModelFromJson(json);

@override final  bool success;
@override final  String message;
@override final  SaveBasicInfoData data;

/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveBasicInfoModelCopyWith<_SaveBasicInfoModel> get copyWith => __$SaveBasicInfoModelCopyWithImpl<_SaveBasicInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaveBasicInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveBasicInfoModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SaveBasicInfoModel(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SaveBasicInfoModelCopyWith<$Res> implements $SaveBasicInfoModelCopyWith<$Res> {
  factory _$SaveBasicInfoModelCopyWith(_SaveBasicInfoModel value, $Res Function(_SaveBasicInfoModel) _then) = __$SaveBasicInfoModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, SaveBasicInfoData data
});


@override $SaveBasicInfoDataCopyWith<$Res> get data;

}
/// @nodoc
class __$SaveBasicInfoModelCopyWithImpl<$Res>
    implements _$SaveBasicInfoModelCopyWith<$Res> {
  __$SaveBasicInfoModelCopyWithImpl(this._self, this._then);

  final _SaveBasicInfoModel _self;
  final $Res Function(_SaveBasicInfoModel) _then;

/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_SaveBasicInfoModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SaveBasicInfoData,
  ));
}

/// Create a copy of SaveBasicInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SaveBasicInfoDataCopyWith<$Res> get data {
  
  return $SaveBasicInfoDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SaveBasicInfoData {

 String get tempId; int get currentStep; String get ownerId; String get createdBy; String get createdByRole; String get nextStep; String get expiresAt;
/// Create a copy of SaveBasicInfoData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveBasicInfoDataCopyWith<SaveBasicInfoData> get copyWith => _$SaveBasicInfoDataCopyWithImpl<SaveBasicInfoData>(this as SaveBasicInfoData, _$identity);

  /// Serializes this SaveBasicInfoData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveBasicInfoData&&(identical(other.tempId, tempId) || other.tempId == tempId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByRole, createdByRole) || other.createdByRole == createdByRole)&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tempId,currentStep,ownerId,createdBy,createdByRole,nextStep,expiresAt);

@override
String toString() {
  return 'SaveBasicInfoData(tempId: $tempId, currentStep: $currentStep, ownerId: $ownerId, createdBy: $createdBy, createdByRole: $createdByRole, nextStep: $nextStep, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $SaveBasicInfoDataCopyWith<$Res>  {
  factory $SaveBasicInfoDataCopyWith(SaveBasicInfoData value, $Res Function(SaveBasicInfoData) _then) = _$SaveBasicInfoDataCopyWithImpl;
@useResult
$Res call({
 String tempId, int currentStep, String ownerId, String createdBy, String createdByRole, String nextStep, String expiresAt
});




}
/// @nodoc
class _$SaveBasicInfoDataCopyWithImpl<$Res>
    implements $SaveBasicInfoDataCopyWith<$Res> {
  _$SaveBasicInfoDataCopyWithImpl(this._self, this._then);

  final SaveBasicInfoData _self;
  final $Res Function(SaveBasicInfoData) _then;

/// Create a copy of SaveBasicInfoData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tempId = null,Object? currentStep = null,Object? ownerId = null,Object? createdBy = null,Object? createdByRole = null,Object? nextStep = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
tempId: null == tempId ? _self.tempId : tempId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdByRole: null == createdByRole ? _self.createdByRole : createdByRole // ignore: cast_nullable_to_non_nullable
as String,nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SaveBasicInfoData].
extension SaveBasicInfoDataPatterns on SaveBasicInfoData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaveBasicInfoData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaveBasicInfoData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaveBasicInfoData value)  $default,){
final _that = this;
switch (_that) {
case _SaveBasicInfoData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaveBasicInfoData value)?  $default,){
final _that = this;
switch (_that) {
case _SaveBasicInfoData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tempId,  int currentStep,  String ownerId,  String createdBy,  String createdByRole,  String nextStep,  String expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaveBasicInfoData() when $default != null:
return $default(_that.tempId,_that.currentStep,_that.ownerId,_that.createdBy,_that.createdByRole,_that.nextStep,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tempId,  int currentStep,  String ownerId,  String createdBy,  String createdByRole,  String nextStep,  String expiresAt)  $default,) {final _that = this;
switch (_that) {
case _SaveBasicInfoData():
return $default(_that.tempId,_that.currentStep,_that.ownerId,_that.createdBy,_that.createdByRole,_that.nextStep,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tempId,  int currentStep,  String ownerId,  String createdBy,  String createdByRole,  String nextStep,  String expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _SaveBasicInfoData() when $default != null:
return $default(_that.tempId,_that.currentStep,_that.ownerId,_that.createdBy,_that.createdByRole,_that.nextStep,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SaveBasicInfoData implements SaveBasicInfoData {
  const _SaveBasicInfoData({required this.tempId, required this.currentStep, required this.ownerId, required this.createdBy, required this.createdByRole, required this.nextStep, required this.expiresAt});
  factory _SaveBasicInfoData.fromJson(Map<String, dynamic> json) => _$SaveBasicInfoDataFromJson(json);

@override final  String tempId;
@override final  int currentStep;
@override final  String ownerId;
@override final  String createdBy;
@override final  String createdByRole;
@override final  String nextStep;
@override final  String expiresAt;

/// Create a copy of SaveBasicInfoData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveBasicInfoDataCopyWith<_SaveBasicInfoData> get copyWith => __$SaveBasicInfoDataCopyWithImpl<_SaveBasicInfoData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SaveBasicInfoDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveBasicInfoData&&(identical(other.tempId, tempId) || other.tempId == tempId)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByRole, createdByRole) || other.createdByRole == createdByRole)&&(identical(other.nextStep, nextStep) || other.nextStep == nextStep)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tempId,currentStep,ownerId,createdBy,createdByRole,nextStep,expiresAt);

@override
String toString() {
  return 'SaveBasicInfoData(tempId: $tempId, currentStep: $currentStep, ownerId: $ownerId, createdBy: $createdBy, createdByRole: $createdByRole, nextStep: $nextStep, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$SaveBasicInfoDataCopyWith<$Res> implements $SaveBasicInfoDataCopyWith<$Res> {
  factory _$SaveBasicInfoDataCopyWith(_SaveBasicInfoData value, $Res Function(_SaveBasicInfoData) _then) = __$SaveBasicInfoDataCopyWithImpl;
@override @useResult
$Res call({
 String tempId, int currentStep, String ownerId, String createdBy, String createdByRole, String nextStep, String expiresAt
});




}
/// @nodoc
class __$SaveBasicInfoDataCopyWithImpl<$Res>
    implements _$SaveBasicInfoDataCopyWith<$Res> {
  __$SaveBasicInfoDataCopyWithImpl(this._self, this._then);

  final _SaveBasicInfoData _self;
  final $Res Function(_SaveBasicInfoData) _then;

/// Create a copy of SaveBasicInfoData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tempId = null,Object? currentStep = null,Object? ownerId = null,Object? createdBy = null,Object? createdByRole = null,Object? nextStep = null,Object? expiresAt = null,}) {
  return _then(_SaveBasicInfoData(
tempId: null == tempId ? _self.tempId : tempId // ignore: cast_nullable_to_non_nullable
as String,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdByRole: null == createdByRole ? _self.createdByRole : createdByRole // ignore: cast_nullable_to_non_nullable
as String,nextStep: null == nextStep ? _self.nextStep : nextStep // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
