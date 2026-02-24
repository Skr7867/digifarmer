// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_account_send_otp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpResponseModel {

 bool get success; String get uniqueKey; String get message; UserModel get user; String get otp;
/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpResponseModelCopyWith<OtpResponseModel> get copyWith => _$OtpResponseModelCopyWithImpl<OtpResponseModel>(this as OtpResponseModel, _$identity);

  /// Serializes this OtpResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user,otp);

@override
String toString() {
  return 'OtpResponseModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $OtpResponseModelCopyWith<$Res>  {
  factory $OtpResponseModelCopyWith(OtpResponseModel value, $Res Function(OtpResponseModel) _then) = _$OtpResponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, String uniqueKey, String message, UserModel user, String otp
});


$UserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$OtpResponseModelCopyWithImpl<$Res>
    implements $OtpResponseModelCopyWith<$Res> {
  _$OtpResponseModelCopyWithImpl(this._self, this._then);

  final OtpResponseModel _self;
  final $Res Function(OtpResponseModel) _then;

/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,Object? otp = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [OtpResponseModel].
extension OtpResponseModelPatterns on OtpResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _OtpResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _OtpResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  UserModel user,  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpResponseModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  UserModel user,  String otp)  $default,) {final _that = this;
switch (_that) {
case _OtpResponseModel():
return $default(_that.success,_that.uniqueKey,_that.message,_that.user,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String uniqueKey,  String message,  UserModel user,  String otp)?  $default,) {final _that = this;
switch (_that) {
case _OtpResponseModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpResponseModel implements OtpResponseModel {
  const _OtpResponseModel({required this.success, required this.uniqueKey, required this.message, required this.user, required this.otp});
  factory _OtpResponseModel.fromJson(Map<String, dynamic> json) => _$OtpResponseModelFromJson(json);

@override final  bool success;
@override final  String uniqueKey;
@override final  String message;
@override final  UserModel user;
@override final  String otp;

/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpResponseModelCopyWith<_OtpResponseModel> get copyWith => __$OtpResponseModelCopyWithImpl<_OtpResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user,otp);

@override
String toString() {
  return 'OtpResponseModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$OtpResponseModelCopyWith<$Res> implements $OtpResponseModelCopyWith<$Res> {
  factory _$OtpResponseModelCopyWith(_OtpResponseModel value, $Res Function(_OtpResponseModel) _then) = __$OtpResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String uniqueKey, String message, UserModel user, String otp
});


@override $UserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$OtpResponseModelCopyWithImpl<$Res>
    implements _$OtpResponseModelCopyWith<$Res> {
  __$OtpResponseModelCopyWithImpl(this._self, this._then);

  final _OtpResponseModel _self;
  final $Res Function(_OtpResponseModel) _then;

/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,Object? otp = null,}) {
  return _then(_OtpResponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of OtpResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$UserModel {

 String get id; String get mobileNumber; String? get role; String? get fullName; String? get dateOfBirth; String? get panNumber; String? get aadhaarNumber; String? get address; String? get profileImage; String get status; bool get isApproved; String get createdAt; String get updatedAt; bool? get requiresAdminApproval;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'UserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
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


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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
case _UserModel() when $default != null:
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
case _UserModel():
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
case _UserModel() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.mobileNumber, this.role, this.fullName, this.dateOfBirth, this.panNumber, this.aadhaarNumber, this.address, this.profileImage, required this.status, required this.isApproved, required this.createdAt, required this.updatedAt, this.requiresAdminApproval});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

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

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'UserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = freezed,}) {
  return _then(_UserModel(
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
