// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_verify_otp_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginVerifyOtpResponse {

 bool get success; String get accessToken; String get refreshToken; String get tokenType; String get expiresIn; LoginVerifyUserModel get user; String get message;
/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginVerifyOtpResponseCopyWith<LoginVerifyOtpResponse> get copyWith => _$LoginVerifyOtpResponseCopyWithImpl<LoginVerifyOtpResponse>(this as LoginVerifyOtpResponse, _$identity);

  /// Serializes this LoginVerifyOtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginVerifyOtpResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,accessToken,refreshToken,tokenType,expiresIn,user,message);

@override
String toString() {
  return 'LoginVerifyOtpResponse(success: $success, accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, user: $user, message: $message)';
}


}

/// @nodoc
abstract mixin class $LoginVerifyOtpResponseCopyWith<$Res>  {
  factory $LoginVerifyOtpResponseCopyWith(LoginVerifyOtpResponse value, $Res Function(LoginVerifyOtpResponse) _then) = _$LoginVerifyOtpResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String accessToken, String refreshToken, String tokenType, String expiresIn, LoginVerifyUserModel user, String message
});


$LoginVerifyUserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginVerifyOtpResponseCopyWithImpl<$Res>
    implements $LoginVerifyOtpResponseCopyWith<$Res> {
  _$LoginVerifyOtpResponseCopyWithImpl(this._self, this._then);

  final LoginVerifyOtpResponse _self;
  final $Res Function(LoginVerifyOtpResponse) _then;

/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,Object? expiresIn = null,Object? user = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LoginVerifyUserModel,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginVerifyUserModelCopyWith<$Res> get user {
  
  return $LoginVerifyUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginVerifyOtpResponse].
extension LoginVerifyOtpResponsePatterns on LoginVerifyOtpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginVerifyOtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginVerifyOtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginVerifyOtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String accessToken,  String refreshToken,  String tokenType,  String expiresIn,  LoginVerifyUserModel user,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse() when $default != null:
return $default(_that.success,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.user,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String accessToken,  String refreshToken,  String tokenType,  String expiresIn,  LoginVerifyUserModel user,  String message)  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse():
return $default(_that.success,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.user,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String accessToken,  String refreshToken,  String tokenType,  String expiresIn,  LoginVerifyUserModel user,  String message)?  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyOtpResponse() when $default != null:
return $default(_that.success,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.user,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginVerifyOtpResponse implements LoginVerifyOtpResponse {
  const _LoginVerifyOtpResponse({required this.success, required this.accessToken, required this.refreshToken, required this.tokenType, required this.expiresIn, required this.user, required this.message});
  factory _LoginVerifyOtpResponse.fromJson(Map<String, dynamic> json) => _$LoginVerifyOtpResponseFromJson(json);

@override final  bool success;
@override final  String accessToken;
@override final  String refreshToken;
@override final  String tokenType;
@override final  String expiresIn;
@override final  LoginVerifyUserModel user;
@override final  String message;

/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginVerifyOtpResponseCopyWith<_LoginVerifyOtpResponse> get copyWith => __$LoginVerifyOtpResponseCopyWithImpl<_LoginVerifyOtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginVerifyOtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginVerifyOtpResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.user, user) || other.user == user)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,accessToken,refreshToken,tokenType,expiresIn,user,message);

@override
String toString() {
  return 'LoginVerifyOtpResponse(success: $success, accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, user: $user, message: $message)';
}


}

/// @nodoc
abstract mixin class _$LoginVerifyOtpResponseCopyWith<$Res> implements $LoginVerifyOtpResponseCopyWith<$Res> {
  factory _$LoginVerifyOtpResponseCopyWith(_LoginVerifyOtpResponse value, $Res Function(_LoginVerifyOtpResponse) _then) = __$LoginVerifyOtpResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String accessToken, String refreshToken, String tokenType, String expiresIn, LoginVerifyUserModel user, String message
});


@override $LoginVerifyUserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$LoginVerifyOtpResponseCopyWithImpl<$Res>
    implements _$LoginVerifyOtpResponseCopyWith<$Res> {
  __$LoginVerifyOtpResponseCopyWithImpl(this._self, this._then);

  final _LoginVerifyOtpResponse _self;
  final $Res Function(_LoginVerifyOtpResponse) _then;

/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,Object? expiresIn = null,Object? user = null,Object? message = null,}) {
  return _then(_LoginVerifyOtpResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as LoginVerifyUserModel,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of LoginVerifyOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginVerifyUserModelCopyWith<$Res> get user {
  
  return $LoginVerifyUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$LoginVerifyUserModel {

 String get id; String get mobileNumber; String? get role; String? get fullName; String? get dateOfBirth; String? get panNumber; String? get aadhaarNumber; LoginVerifyAddressModel? get address; String? get profileImage; String get status; bool get isApproved; String get createdAt; String get updatedAt; bool get requiresAdminApproval;
/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginVerifyUserModelCopyWith<LoginVerifyUserModel> get copyWith => _$LoginVerifyUserModelCopyWithImpl<LoginVerifyUserModel>(this as LoginVerifyUserModel, _$identity);

  /// Serializes this LoginVerifyUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginVerifyUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'LoginVerifyUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class $LoginVerifyUserModelCopyWith<$Res>  {
  factory $LoginVerifyUserModelCopyWith(LoginVerifyUserModel value, $Res Function(LoginVerifyUserModel) _then) = _$LoginVerifyUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, LoginVerifyAddressModel? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool requiresAdminApproval
});


$LoginVerifyAddressModelCopyWith<$Res>? get address;

}
/// @nodoc
class _$LoginVerifyUserModelCopyWithImpl<$Res>
    implements $LoginVerifyUserModelCopyWith<$Res> {
  _$LoginVerifyUserModelCopyWithImpl(this._self, this._then);

  final LoginVerifyUserModel _self;
  final $Res Function(LoginVerifyUserModel) _then;

/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,panNumber: freezed == panNumber ? _self.panNumber : panNumber // ignore: cast_nullable_to_non_nullable
as String?,aadhaarNumber: freezed == aadhaarNumber ? _self.aadhaarNumber : aadhaarNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as LoginVerifyAddressModel?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: null == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginVerifyAddressModelCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $LoginVerifyAddressModelCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginVerifyUserModel].
extension LoginVerifyUserModelPatterns on LoginVerifyUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginVerifyUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginVerifyUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginVerifyUserModel value)  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginVerifyUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  LoginVerifyAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool requiresAdminApproval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginVerifyUserModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  LoginVerifyAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool requiresAdminApproval)  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyUserModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  LoginVerifyAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool requiresAdminApproval)?  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyUserModel() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginVerifyUserModel implements LoginVerifyUserModel {
  const _LoginVerifyUserModel({required this.id, required this.mobileNumber, this.role, this.fullName, this.dateOfBirth, this.panNumber, this.aadhaarNumber, this.address, this.profileImage, required this.status, required this.isApproved, required this.createdAt, required this.updatedAt, required this.requiresAdminApproval});
  factory _LoginVerifyUserModel.fromJson(Map<String, dynamic> json) => _$LoginVerifyUserModelFromJson(json);

@override final  String id;
@override final  String mobileNumber;
@override final  String? role;
@override final  String? fullName;
@override final  String? dateOfBirth;
@override final  String? panNumber;
@override final  String? aadhaarNumber;
@override final  LoginVerifyAddressModel? address;
@override final  String? profileImage;
@override final  String status;
@override final  bool isApproved;
@override final  String createdAt;
@override final  String updatedAt;
@override final  bool requiresAdminApproval;

/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginVerifyUserModelCopyWith<_LoginVerifyUserModel> get copyWith => __$LoginVerifyUserModelCopyWithImpl<_LoginVerifyUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginVerifyUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginVerifyUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'LoginVerifyUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class _$LoginVerifyUserModelCopyWith<$Res> implements $LoginVerifyUserModelCopyWith<$Res> {
  factory _$LoginVerifyUserModelCopyWith(_LoginVerifyUserModel value, $Res Function(_LoginVerifyUserModel) _then) = __$LoginVerifyUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, LoginVerifyAddressModel? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool requiresAdminApproval
});


@override $LoginVerifyAddressModelCopyWith<$Res>? get address;

}
/// @nodoc
class __$LoginVerifyUserModelCopyWithImpl<$Res>
    implements _$LoginVerifyUserModelCopyWith<$Res> {
  __$LoginVerifyUserModelCopyWithImpl(this._self, this._then);

  final _LoginVerifyUserModel _self;
  final $Res Function(_LoginVerifyUserModel) _then;

/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = null,}) {
  return _then(_LoginVerifyUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,panNumber: freezed == panNumber ? _self.panNumber : panNumber // ignore: cast_nullable_to_non_nullable
as String?,aadhaarNumber: freezed == aadhaarNumber ? _self.aadhaarNumber : aadhaarNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as LoginVerifyAddressModel?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: null == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LoginVerifyUserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginVerifyAddressModelCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $LoginVerifyAddressModelCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$LoginVerifyAddressModel {

 String? get houseNumber; String? get street; String? get area; String? get city; String? get state; String? get pinCode;@JsonKey(name: '_id') String? get id;
/// Create a copy of LoginVerifyAddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginVerifyAddressModelCopyWith<LoginVerifyAddressModel> get copyWith => _$LoginVerifyAddressModelCopyWithImpl<LoginVerifyAddressModel>(this as LoginVerifyAddressModel, _$identity);

  /// Serializes this LoginVerifyAddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginVerifyAddressModel&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,houseNumber,street,area,city,state,pinCode,id);

@override
String toString() {
  return 'LoginVerifyAddressModel(houseNumber: $houseNumber, street: $street, area: $area, city: $city, state: $state, pinCode: $pinCode, id: $id)';
}


}

/// @nodoc
abstract mixin class $LoginVerifyAddressModelCopyWith<$Res>  {
  factory $LoginVerifyAddressModelCopyWith(LoginVerifyAddressModel value, $Res Function(LoginVerifyAddressModel) _then) = _$LoginVerifyAddressModelCopyWithImpl;
@useResult
$Res call({
 String? houseNumber, String? street, String? area, String? city, String? state, String? pinCode,@JsonKey(name: '_id') String? id
});




}
/// @nodoc
class _$LoginVerifyAddressModelCopyWithImpl<$Res>
    implements $LoginVerifyAddressModelCopyWith<$Res> {
  _$LoginVerifyAddressModelCopyWithImpl(this._self, this._then);

  final LoginVerifyAddressModel _self;
  final $Res Function(LoginVerifyAddressModel) _then;

/// Create a copy of LoginVerifyAddressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? houseNumber = freezed,Object? street = freezed,Object? area = freezed,Object? city = freezed,Object? state = freezed,Object? pinCode = freezed,Object? id = freezed,}) {
  return _then(_self.copyWith(
houseNumber: freezed == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pinCode: freezed == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginVerifyAddressModel].
extension LoginVerifyAddressModelPatterns on LoginVerifyAddressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginVerifyAddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginVerifyAddressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginVerifyAddressModel value)  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyAddressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginVerifyAddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _LoginVerifyAddressModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? houseNumber,  String? street,  String? area,  String? city,  String? state,  String? pinCode, @JsonKey(name: '_id')  String? id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginVerifyAddressModel() when $default != null:
return $default(_that.houseNumber,_that.street,_that.area,_that.city,_that.state,_that.pinCode,_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? houseNumber,  String? street,  String? area,  String? city,  String? state,  String? pinCode, @JsonKey(name: '_id')  String? id)  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyAddressModel():
return $default(_that.houseNumber,_that.street,_that.area,_that.city,_that.state,_that.pinCode,_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? houseNumber,  String? street,  String? area,  String? city,  String? state,  String? pinCode, @JsonKey(name: '_id')  String? id)?  $default,) {final _that = this;
switch (_that) {
case _LoginVerifyAddressModel() when $default != null:
return $default(_that.houseNumber,_that.street,_that.area,_that.city,_that.state,_that.pinCode,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginVerifyAddressModel implements LoginVerifyAddressModel {
  const _LoginVerifyAddressModel({this.houseNumber, this.street, this.area, this.city, this.state, this.pinCode, @JsonKey(name: '_id') this.id});
  factory _LoginVerifyAddressModel.fromJson(Map<String, dynamic> json) => _$LoginVerifyAddressModelFromJson(json);

@override final  String? houseNumber;
@override final  String? street;
@override final  String? area;
@override final  String? city;
@override final  String? state;
@override final  String? pinCode;
@override@JsonKey(name: '_id') final  String? id;

/// Create a copy of LoginVerifyAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginVerifyAddressModelCopyWith<_LoginVerifyAddressModel> get copyWith => __$LoginVerifyAddressModelCopyWithImpl<_LoginVerifyAddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginVerifyAddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginVerifyAddressModel&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,houseNumber,street,area,city,state,pinCode,id);

@override
String toString() {
  return 'LoginVerifyAddressModel(houseNumber: $houseNumber, street: $street, area: $area, city: $city, state: $state, pinCode: $pinCode, id: $id)';
}


}

/// @nodoc
abstract mixin class _$LoginVerifyAddressModelCopyWith<$Res> implements $LoginVerifyAddressModelCopyWith<$Res> {
  factory _$LoginVerifyAddressModelCopyWith(_LoginVerifyAddressModel value, $Res Function(_LoginVerifyAddressModel) _then) = __$LoginVerifyAddressModelCopyWithImpl;
@override @useResult
$Res call({
 String? houseNumber, String? street, String? area, String? city, String? state, String? pinCode,@JsonKey(name: '_id') String? id
});




}
/// @nodoc
class __$LoginVerifyAddressModelCopyWithImpl<$Res>
    implements _$LoginVerifyAddressModelCopyWith<$Res> {
  __$LoginVerifyAddressModelCopyWithImpl(this._self, this._then);

  final _LoginVerifyAddressModel _self;
  final $Res Function(_LoginVerifyAddressModel) _then;

/// Create a copy of LoginVerifyAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? houseNumber = freezed,Object? street = freezed,Object? area = freezed,Object? city = freezed,Object? state = freezed,Object? pinCode = freezed,Object? id = freezed,}) {
  return _then(_LoginVerifyAddressModel(
houseNumber: freezed == houseNumber ? _self.houseNumber : houseNumber // ignore: cast_nullable_to_non_nullable
as String?,street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pinCode: freezed == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
