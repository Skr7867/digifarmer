// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'land_owner_timeline_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LandOwnerTimelineModel {

 bool get success; LandOwnerTimelineData get data;
/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandOwnerTimelineModelCopyWith<LandOwnerTimelineModel> get copyWith => _$LandOwnerTimelineModelCopyWithImpl<LandOwnerTimelineModel>(this as LandOwnerTimelineModel, _$identity);

  /// Serializes this LandOwnerTimelineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandOwnerTimelineModel&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'LandOwnerTimelineModel(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class $LandOwnerTimelineModelCopyWith<$Res>  {
  factory $LandOwnerTimelineModelCopyWith(LandOwnerTimelineModel value, $Res Function(LandOwnerTimelineModel) _then) = _$LandOwnerTimelineModelCopyWithImpl;
@useResult
$Res call({
 bool success, LandOwnerTimelineData data
});


$LandOwnerTimelineDataCopyWith<$Res> get data;

}
/// @nodoc
class _$LandOwnerTimelineModelCopyWithImpl<$Res>
    implements $LandOwnerTimelineModelCopyWith<$Res> {
  _$LandOwnerTimelineModelCopyWithImpl(this._self, this._then);

  final LandOwnerTimelineModel _self;
  final $Res Function(LandOwnerTimelineModel) _then;

/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LandOwnerTimelineData,
  ));
}
/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LandOwnerTimelineDataCopyWith<$Res> get data {
  
  return $LandOwnerTimelineDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [LandOwnerTimelineModel].
extension LandOwnerTimelineModelPatterns on LandOwnerTimelineModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandOwnerTimelineModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandOwnerTimelineModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandOwnerTimelineModel value)  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandOwnerTimelineModel value)?  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  LandOwnerTimelineData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandOwnerTimelineModel() when $default != null:
return $default(_that.success,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  LandOwnerTimelineData data)  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineModel():
return $default(_that.success,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  LandOwnerTimelineData data)?  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineModel() when $default != null:
return $default(_that.success,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LandOwnerTimelineModel implements LandOwnerTimelineModel {
  const _LandOwnerTimelineModel({required this.success, required this.data});
  factory _LandOwnerTimelineModel.fromJson(Map<String, dynamic> json) => _$LandOwnerTimelineModelFromJson(json);

@override final  bool success;
@override final  LandOwnerTimelineData data;

/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandOwnerTimelineModelCopyWith<_LandOwnerTimelineModel> get copyWith => __$LandOwnerTimelineModelCopyWithImpl<_LandOwnerTimelineModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LandOwnerTimelineModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandOwnerTimelineModel&&(identical(other.success, success) || other.success == success)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,data);

@override
String toString() {
  return 'LandOwnerTimelineModel(success: $success, data: $data)';
}


}

/// @nodoc
abstract mixin class _$LandOwnerTimelineModelCopyWith<$Res> implements $LandOwnerTimelineModelCopyWith<$Res> {
  factory _$LandOwnerTimelineModelCopyWith(_LandOwnerTimelineModel value, $Res Function(_LandOwnerTimelineModel) _then) = __$LandOwnerTimelineModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, LandOwnerTimelineData data
});


@override $LandOwnerTimelineDataCopyWith<$Res> get data;

}
/// @nodoc
class __$LandOwnerTimelineModelCopyWithImpl<$Res>
    implements _$LandOwnerTimelineModelCopyWith<$Res> {
  __$LandOwnerTimelineModelCopyWithImpl(this._self, this._then);

  final _LandOwnerTimelineModel _self;
  final $Res Function(_LandOwnerTimelineModel) _then;

/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = null,}) {
  return _then(_LandOwnerTimelineModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LandOwnerTimelineData,
  ));
}

/// Create a copy of LandOwnerTimelineModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LandOwnerTimelineDataCopyWith<$Res> get data {
  
  return $LandOwnerTimelineDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$LandOwnerTimelineData {

 int get count; List<LandOwnerTimelineLand> get lands;
/// Create a copy of LandOwnerTimelineData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandOwnerTimelineDataCopyWith<LandOwnerTimelineData> get copyWith => _$LandOwnerTimelineDataCopyWithImpl<LandOwnerTimelineData>(this as LandOwnerTimelineData, _$identity);

  /// Serializes this LandOwnerTimelineData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandOwnerTimelineData&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.lands, lands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(lands));

@override
String toString() {
  return 'LandOwnerTimelineData(count: $count, lands: $lands)';
}


}

/// @nodoc
abstract mixin class $LandOwnerTimelineDataCopyWith<$Res>  {
  factory $LandOwnerTimelineDataCopyWith(LandOwnerTimelineData value, $Res Function(LandOwnerTimelineData) _then) = _$LandOwnerTimelineDataCopyWithImpl;
@useResult
$Res call({
 int count, List<LandOwnerTimelineLand> lands
});




}
/// @nodoc
class _$LandOwnerTimelineDataCopyWithImpl<$Res>
    implements $LandOwnerTimelineDataCopyWith<$Res> {
  _$LandOwnerTimelineDataCopyWithImpl(this._self, this._then);

  final LandOwnerTimelineData _self;
  final $Res Function(LandOwnerTimelineData) _then;

/// Create a copy of LandOwnerTimelineData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? lands = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lands: null == lands ? _self.lands : lands // ignore: cast_nullable_to_non_nullable
as List<LandOwnerTimelineLand>,
  ));
}

}


/// Adds pattern-matching-related methods to [LandOwnerTimelineData].
extension LandOwnerTimelineDataPatterns on LandOwnerTimelineData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandOwnerTimelineData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandOwnerTimelineData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandOwnerTimelineData value)  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandOwnerTimelineData value)?  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<LandOwnerTimelineLand> lands)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandOwnerTimelineData() when $default != null:
return $default(_that.count,_that.lands);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<LandOwnerTimelineLand> lands)  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineData():
return $default(_that.count,_that.lands);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<LandOwnerTimelineLand> lands)?  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineData() when $default != null:
return $default(_that.count,_that.lands);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LandOwnerTimelineData implements LandOwnerTimelineData {
  const _LandOwnerTimelineData({required this.count, required final  List<LandOwnerTimelineLand> lands}): _lands = lands;
  factory _LandOwnerTimelineData.fromJson(Map<String, dynamic> json) => _$LandOwnerTimelineDataFromJson(json);

@override final  int count;
 final  List<LandOwnerTimelineLand> _lands;
@override List<LandOwnerTimelineLand> get lands {
  if (_lands is EqualUnmodifiableListView) return _lands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lands);
}


/// Create a copy of LandOwnerTimelineData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandOwnerTimelineDataCopyWith<_LandOwnerTimelineData> get copyWith => __$LandOwnerTimelineDataCopyWithImpl<_LandOwnerTimelineData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LandOwnerTimelineDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandOwnerTimelineData&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._lands, _lands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_lands));

@override
String toString() {
  return 'LandOwnerTimelineData(count: $count, lands: $lands)';
}


}

/// @nodoc
abstract mixin class _$LandOwnerTimelineDataCopyWith<$Res> implements $LandOwnerTimelineDataCopyWith<$Res> {
  factory _$LandOwnerTimelineDataCopyWith(_LandOwnerTimelineData value, $Res Function(_LandOwnerTimelineData) _then) = __$LandOwnerTimelineDataCopyWithImpl;
@override @useResult
$Res call({
 int count, List<LandOwnerTimelineLand> lands
});




}
/// @nodoc
class __$LandOwnerTimelineDataCopyWithImpl<$Res>
    implements _$LandOwnerTimelineDataCopyWith<$Res> {
  __$LandOwnerTimelineDataCopyWithImpl(this._self, this._then);

  final _LandOwnerTimelineData _self;
  final $Res Function(_LandOwnerTimelineData) _then;

/// Create a copy of LandOwnerTimelineData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? lands = null,}) {
  return _then(_LandOwnerTimelineData(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lands: null == lands ? _self._lands : lands // ignore: cast_nullable_to_non_nullable
as List<LandOwnerTimelineLand>,
  ));
}


}


/// @nodoc
mixin _$LandOwnerTimelineLand {

 String get id; String get title; String get area; String get location; String get status; bool get isLive; int get currentStep; String get stepStatus; String get landId; DateTime get submittedAt; DateTime get updatedAt;
/// Create a copy of LandOwnerTimelineLand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LandOwnerTimelineLandCopyWith<LandOwnerTimelineLand> get copyWith => _$LandOwnerTimelineLandCopyWithImpl<LandOwnerTimelineLand>(this as LandOwnerTimelineLand, _$identity);

  /// Serializes this LandOwnerTimelineLand to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LandOwnerTimelineLand&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.area, area) || other.area == area)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.stepStatus, stepStatus) || other.stepStatus == stepStatus)&&(identical(other.landId, landId) || other.landId == landId)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,area,location,status,isLive,currentStep,stepStatus,landId,submittedAt,updatedAt);

@override
String toString() {
  return 'LandOwnerTimelineLand(id: $id, title: $title, area: $area, location: $location, status: $status, isLive: $isLive, currentStep: $currentStep, stepStatus: $stepStatus, landId: $landId, submittedAt: $submittedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LandOwnerTimelineLandCopyWith<$Res>  {
  factory $LandOwnerTimelineLandCopyWith(LandOwnerTimelineLand value, $Res Function(LandOwnerTimelineLand) _then) = _$LandOwnerTimelineLandCopyWithImpl;
@useResult
$Res call({
 String id, String title, String area, String location, String status, bool isLive, int currentStep, String stepStatus, String landId, DateTime submittedAt, DateTime updatedAt
});




}
/// @nodoc
class _$LandOwnerTimelineLandCopyWithImpl<$Res>
    implements $LandOwnerTimelineLandCopyWith<$Res> {
  _$LandOwnerTimelineLandCopyWithImpl(this._self, this._then);

  final LandOwnerTimelineLand _self;
  final $Res Function(LandOwnerTimelineLand) _then;

/// Create a copy of LandOwnerTimelineLand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? area = null,Object? location = null,Object? status = null,Object? isLive = null,Object? currentStep = null,Object? stepStatus = null,Object? landId = null,Object? submittedAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,stepStatus: null == stepStatus ? _self.stepStatus : stepStatus // ignore: cast_nullable_to_non_nullable
as String,landId: null == landId ? _self.landId : landId // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LandOwnerTimelineLand].
extension LandOwnerTimelineLandPatterns on LandOwnerTimelineLand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LandOwnerTimelineLand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LandOwnerTimelineLand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LandOwnerTimelineLand value)  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineLand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LandOwnerTimelineLand value)?  $default,){
final _that = this;
switch (_that) {
case _LandOwnerTimelineLand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String area,  String location,  String status,  bool isLive,  int currentStep,  String stepStatus,  String landId,  DateTime submittedAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LandOwnerTimelineLand() when $default != null:
return $default(_that.id,_that.title,_that.area,_that.location,_that.status,_that.isLive,_that.currentStep,_that.stepStatus,_that.landId,_that.submittedAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String area,  String location,  String status,  bool isLive,  int currentStep,  String stepStatus,  String landId,  DateTime submittedAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineLand():
return $default(_that.id,_that.title,_that.area,_that.location,_that.status,_that.isLive,_that.currentStep,_that.stepStatus,_that.landId,_that.submittedAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String area,  String location,  String status,  bool isLive,  int currentStep,  String stepStatus,  String landId,  DateTime submittedAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LandOwnerTimelineLand() when $default != null:
return $default(_that.id,_that.title,_that.area,_that.location,_that.status,_that.isLive,_that.currentStep,_that.stepStatus,_that.landId,_that.submittedAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LandOwnerTimelineLand implements LandOwnerTimelineLand {
  const _LandOwnerTimelineLand({required this.id, required this.title, required this.area, required this.location, required this.status, required this.isLive, required this.currentStep, required this.stepStatus, required this.landId, required this.submittedAt, required this.updatedAt});
  factory _LandOwnerTimelineLand.fromJson(Map<String, dynamic> json) => _$LandOwnerTimelineLandFromJson(json);

@override final  String id;
@override final  String title;
@override final  String area;
@override final  String location;
@override final  String status;
@override final  bool isLive;
@override final  int currentStep;
@override final  String stepStatus;
@override final  String landId;
@override final  DateTime submittedAt;
@override final  DateTime updatedAt;

/// Create a copy of LandOwnerTimelineLand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LandOwnerTimelineLandCopyWith<_LandOwnerTimelineLand> get copyWith => __$LandOwnerTimelineLandCopyWithImpl<_LandOwnerTimelineLand>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LandOwnerTimelineLandToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LandOwnerTimelineLand&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.area, area) || other.area == area)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.stepStatus, stepStatus) || other.stepStatus == stepStatus)&&(identical(other.landId, landId) || other.landId == landId)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,area,location,status,isLive,currentStep,stepStatus,landId,submittedAt,updatedAt);

@override
String toString() {
  return 'LandOwnerTimelineLand(id: $id, title: $title, area: $area, location: $location, status: $status, isLive: $isLive, currentStep: $currentStep, stepStatus: $stepStatus, landId: $landId, submittedAt: $submittedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LandOwnerTimelineLandCopyWith<$Res> implements $LandOwnerTimelineLandCopyWith<$Res> {
  factory _$LandOwnerTimelineLandCopyWith(_LandOwnerTimelineLand value, $Res Function(_LandOwnerTimelineLand) _then) = __$LandOwnerTimelineLandCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String area, String location, String status, bool isLive, int currentStep, String stepStatus, String landId, DateTime submittedAt, DateTime updatedAt
});




}
/// @nodoc
class __$LandOwnerTimelineLandCopyWithImpl<$Res>
    implements _$LandOwnerTimelineLandCopyWith<$Res> {
  __$LandOwnerTimelineLandCopyWithImpl(this._self, this._then);

  final _LandOwnerTimelineLand _self;
  final $Res Function(_LandOwnerTimelineLand) _then;

/// Create a copy of LandOwnerTimelineLand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? area = null,Object? location = null,Object? status = null,Object? isLive = null,Object? currentStep = null,Object? stepStatus = null,Object? landId = null,Object? submittedAt = null,Object? updatedAt = null,}) {
  return _then(_LandOwnerTimelineLand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,stepStatus: null == stepStatus ? _self.stepStatus : stepStatus // ignore: cast_nullable_to_non_nullable
as String,landId: null == landId ? _self.landId : landId // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
