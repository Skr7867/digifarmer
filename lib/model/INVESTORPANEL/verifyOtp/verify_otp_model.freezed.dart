// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyOtpModel {

 bool get success; String get uniqueKey; String get message; VerifyOtpUserModel get user;
/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpModelCopyWith<VerifyOtpModel> get copyWith => _$VerifyOtpModelCopyWithImpl<VerifyOtpModel>(this as VerifyOtpModel, _$identity);

  /// Serializes this VerifyOtpModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'VerifyOtpModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpModelCopyWith<$Res>  {
  factory $VerifyOtpModelCopyWith(VerifyOtpModel value, $Res Function(VerifyOtpModel) _then) = _$VerifyOtpModelCopyWithImpl;
@useResult
$Res call({
 bool success, String uniqueKey, String message, VerifyOtpUserModel user
});


$VerifyOtpUserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$VerifyOtpModelCopyWithImpl<$Res>
    implements $VerifyOtpModelCopyWith<$Res> {
  _$VerifyOtpModelCopyWithImpl(this._self, this._then);

  final VerifyOtpModel _self;
  final $Res Function(VerifyOtpModel) _then;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as VerifyOtpUserModel,
  ));
}
/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerifyOtpUserModelCopyWith<$Res> get user {
  
  return $VerifyOtpUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [VerifyOtpModel].
extension VerifyOtpModelPatterns on VerifyOtpModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpModel value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  VerifyOtpUserModel user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  VerifyOtpUserModel user)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpModel():
return $default(_that.success,_that.uniqueKey,_that.message,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String uniqueKey,  String message,  VerifyOtpUserModel user)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpModel implements VerifyOtpModel {
  const _VerifyOtpModel({required this.success, required this.uniqueKey, required this.message, required this.user});
  factory _VerifyOtpModel.fromJson(Map<String, dynamic> json) => _$VerifyOtpModelFromJson(json);

@override final  bool success;
@override final  String uniqueKey;
@override final  String message;
@override final  VerifyOtpUserModel user;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpModelCopyWith<_VerifyOtpModel> get copyWith => __$VerifyOtpModelCopyWithImpl<_VerifyOtpModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'VerifyOtpModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpModelCopyWith<$Res> implements $VerifyOtpModelCopyWith<$Res> {
  factory _$VerifyOtpModelCopyWith(_VerifyOtpModel value, $Res Function(_VerifyOtpModel) _then) = __$VerifyOtpModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String uniqueKey, String message, VerifyOtpUserModel user
});


@override $VerifyOtpUserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$VerifyOtpModelCopyWithImpl<$Res>
    implements _$VerifyOtpModelCopyWith<$Res> {
  __$VerifyOtpModelCopyWithImpl(this._self, this._then);

  final _VerifyOtpModel _self;
  final $Res Function(_VerifyOtpModel) _then;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_VerifyOtpModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as VerifyOtpUserModel,
  ));
}

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerifyOtpUserModelCopyWith<$Res> get user {
  
  return $VerifyOtpUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$VerifyOtpUserModel {

 String get id; String get mobileNumber; String? get role; String? get fullName; String? get dateOfBirth; String? get panNumber; String? get aadhaarNumber; String? get address; String? get profileImage; String get status; bool get isApproved; String get createdAt; String get updatedAt; bool? get requiresAdminApproval;
/// Create a copy of VerifyOtpUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpUserModelCopyWith<VerifyOtpUserModel> get copyWith => _$VerifyOtpUserModelCopyWithImpl<VerifyOtpUserModel>(this as VerifyOtpUserModel, _$identity);

  /// Serializes this VerifyOtpUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'VerifyOtpUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpUserModelCopyWith<$Res>  {
  factory $VerifyOtpUserModelCopyWith(VerifyOtpUserModel value, $Res Function(VerifyOtpUserModel) _then) = _$VerifyOtpUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class _$VerifyOtpUserModelCopyWithImpl<$Res>
    implements $VerifyOtpUserModelCopyWith<$Res> {
  _$VerifyOtpUserModelCopyWithImpl(this._self, this._then);

  final VerifyOtpUserModel _self;
  final $Res Function(VerifyOtpUserModel) _then;

/// Create a copy of VerifyOtpUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,panNumber: freezed == panNumber ? _self.panNumber : panNumber // ignore: cast_nullable_to_non_nullable
as String?,aadhaarNumber: freezed == aadhaarNumber ? _self.aadhaarNumber : aadhaarNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: freezed == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpUserModel].
extension VerifyOtpUserModelPatterns on VerifyOtpUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpUserModel value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  String? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpUserModel() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  String? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpUserModel():
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  String? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpUserModel() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpUserModel implements VerifyOtpUserModel {
  const _VerifyOtpUserModel({required this.id, required this.mobileNumber, this.role, this.fullName, this.dateOfBirth, this.panNumber, this.aadhaarNumber, this.address, this.profileImage, required this.status, required this.isApproved, required this.createdAt, required this.updatedAt, this.requiresAdminApproval});
  factory _VerifyOtpUserModel.fromJson(Map<String, dynamic> json) => _$VerifyOtpUserModelFromJson(json);

@override final  String id;
@override final  String mobileNumber;
@override final  String? role;
@override final  String? fullName;
@override final  String? dateOfBirth;
@override final  String? panNumber;
@override final  String? aadhaarNumber;
@override final  String? address;
@override final  String? profileImage;
@override final  String status;
@override final  bool isApproved;
@override final  String createdAt;
@override final  String updatedAt;
@override final  bool? requiresAdminApproval;

/// Create a copy of VerifyOtpUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpUserModelCopyWith<_VerifyOtpUserModel> get copyWith => __$VerifyOtpUserModelCopyWithImpl<_VerifyOtpUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'VerifyOtpUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpUserModelCopyWith<$Res> implements $VerifyOtpUserModelCopyWith<$Res> {
  factory _$VerifyOtpUserModelCopyWith(_VerifyOtpUserModel value, $Res Function(_VerifyOtpUserModel) _then) = __$VerifyOtpUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class __$VerifyOtpUserModelCopyWithImpl<$Res>
    implements _$VerifyOtpUserModelCopyWith<$Res> {
  __$VerifyOtpUserModelCopyWithImpl(this._self, this._then);

  final _VerifyOtpUserModel _self;
  final $Res Function(_VerifyOtpUserModel) _then;

/// Create a copy of VerifyOtpUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = freezed,}) {
  return _then(_VerifyOtpUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,panNumber: freezed == panNumber ? _self.panNumber : panNumber // ignore: cast_nullable_to_non_nullable
as String?,aadhaarNumber: freezed == aadhaarNumber ? _self.aadhaarNumber : aadhaarNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: freezed == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
