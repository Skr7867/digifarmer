// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionUserModel {

 String get accessToken; String get refreshToken; String get userId; String get mobileNumber; String? get role; bool get isApproved;
/// Create a copy of SessionUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionUserModelCopyWith<SessionUserModel> get copyWith => _$SessionUserModelCopyWithImpl<SessionUserModel>(this as SessionUserModel, _$identity);

  /// Serializes this SessionUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionUserModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,mobileNumber,role,isApproved);

@override
String toString() {
  return 'SessionUserModel(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, mobileNumber: $mobileNumber, role: $role, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class $SessionUserModelCopyWith<$Res>  {
  factory $SessionUserModelCopyWith(SessionUserModel value, $Res Function(SessionUserModel) _then) = _$SessionUserModelCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken, String userId, String mobileNumber, String? role, bool isApproved
});




}
/// @nodoc
class _$SessionUserModelCopyWithImpl<$Res>
    implements $SessionUserModelCopyWith<$Res> {
  _$SessionUserModelCopyWithImpl(this._self, this._then);

  final SessionUserModel _self;
  final $Res Function(SessionUserModel) _then;

/// Create a copy of SessionUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? userId = null,Object? mobileNumber = null,Object? role = freezed,Object? isApproved = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionUserModel].
extension SessionUserModelPatterns on SessionUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionUserModel value)  $default,){
final _that = this;
switch (_that) {
case _SessionUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _SessionUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  String userId,  String mobileNumber,  String? role,  bool isApproved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionUserModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.mobileNumber,_that.role,_that.isApproved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  String userId,  String mobileNumber,  String? role,  bool isApproved)  $default,) {final _that = this;
switch (_that) {
case _SessionUserModel():
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.mobileNumber,_that.role,_that.isApproved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken,  String userId,  String mobileNumber,  String? role,  bool isApproved)?  $default,) {final _that = this;
switch (_that) {
case _SessionUserModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.userId,_that.mobileNumber,_that.role,_that.isApproved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionUserModel implements SessionUserModel {
  const _SessionUserModel({required this.accessToken, required this.refreshToken, required this.userId, required this.mobileNumber, this.role, required this.isApproved});
  factory _SessionUserModel.fromJson(Map<String, dynamic> json) => _$SessionUserModelFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;
@override final  String userId;
@override final  String mobileNumber;
@override final  String? role;
@override final  bool isApproved;

/// Create a copy of SessionUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionUserModelCopyWith<_SessionUserModel> get copyWith => __$SessionUserModelCopyWithImpl<_SessionUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionUserModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,userId,mobileNumber,role,isApproved);

@override
String toString() {
  return 'SessionUserModel(accessToken: $accessToken, refreshToken: $refreshToken, userId: $userId, mobileNumber: $mobileNumber, role: $role, isApproved: $isApproved)';
}


}

/// @nodoc
abstract mixin class _$SessionUserModelCopyWith<$Res> implements $SessionUserModelCopyWith<$Res> {
  factory _$SessionUserModelCopyWith(_SessionUserModel value, $Res Function(_SessionUserModel) _then) = __$SessionUserModelCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken, String userId, String mobileNumber, String? role, bool isApproved
});




}
/// @nodoc
class __$SessionUserModelCopyWithImpl<$Res>
    implements _$SessionUserModelCopyWith<$Res> {
  __$SessionUserModelCopyWithImpl(this._self, this._then);

  final _SessionUserModel _self;
  final $Res Function(_SessionUserModel) _then;

/// Create a copy of SessionUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? userId = null,Object? mobileNumber = null,Object? role = freezed,Object? isApproved = null,}) {
  return _then(_SessionUserModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
