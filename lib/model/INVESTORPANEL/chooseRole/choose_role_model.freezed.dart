// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choose_role_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChooseRoleModel {

 bool get success; String get uniqueKey; String get message; ChooseRoleUser get user;
/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseRoleModelCopyWith<ChooseRoleModel> get copyWith => _$ChooseRoleModelCopyWithImpl<ChooseRoleModel>(this as ChooseRoleModel, _$identity);

  /// Serializes this ChooseRoleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseRoleModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'ChooseRoleModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class $ChooseRoleModelCopyWith<$Res>  {
  factory $ChooseRoleModelCopyWith(ChooseRoleModel value, $Res Function(ChooseRoleModel) _then) = _$ChooseRoleModelCopyWithImpl;
@useResult
$Res call({
 bool success, String uniqueKey, String message, ChooseRoleUser user
});


$ChooseRoleUserCopyWith<$Res> get user;

}
/// @nodoc
class _$ChooseRoleModelCopyWithImpl<$Res>
    implements $ChooseRoleModelCopyWith<$Res> {
  _$ChooseRoleModelCopyWithImpl(this._self, this._then);

  final ChooseRoleModel _self;
  final $Res Function(ChooseRoleModel) _then;

/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ChooseRoleUser,
  ));
}
/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChooseRoleUserCopyWith<$Res> get user {
  
  return $ChooseRoleUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChooseRoleModel].
extension ChooseRoleModelPatterns on ChooseRoleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChooseRoleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChooseRoleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChooseRoleModel value)  $default,){
final _that = this;
switch (_that) {
case _ChooseRoleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChooseRoleModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChooseRoleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  ChooseRoleUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChooseRoleModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  ChooseRoleUser user)  $default,) {final _that = this;
switch (_that) {
case _ChooseRoleModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String uniqueKey,  String message,  ChooseRoleUser user)?  $default,) {final _that = this;
switch (_that) {
case _ChooseRoleModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChooseRoleModel implements ChooseRoleModel {
  const _ChooseRoleModel({required this.success, required this.uniqueKey, required this.message, required this.user});
  factory _ChooseRoleModel.fromJson(Map<String, dynamic> json) => _$ChooseRoleModelFromJson(json);

@override final  bool success;
@override final  String uniqueKey;
@override final  String message;
@override final  ChooseRoleUser user;

/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChooseRoleModelCopyWith<_ChooseRoleModel> get copyWith => __$ChooseRoleModelCopyWithImpl<_ChooseRoleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChooseRoleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChooseRoleModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'ChooseRoleModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class _$ChooseRoleModelCopyWith<$Res> implements $ChooseRoleModelCopyWith<$Res> {
  factory _$ChooseRoleModelCopyWith(_ChooseRoleModel value, $Res Function(_ChooseRoleModel) _then) = __$ChooseRoleModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String uniqueKey, String message, ChooseRoleUser user
});


@override $ChooseRoleUserCopyWith<$Res> get user;

}
/// @nodoc
class __$ChooseRoleModelCopyWithImpl<$Res>
    implements _$ChooseRoleModelCopyWith<$Res> {
  __$ChooseRoleModelCopyWithImpl(this._self, this._then);

  final _ChooseRoleModel _self;
  final $Res Function(_ChooseRoleModel) _then;

/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_ChooseRoleModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ChooseRoleUser,
  ));
}

/// Create a copy of ChooseRoleModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChooseRoleUserCopyWith<$Res> get user {
  
  return $ChooseRoleUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$ChooseRoleUser {

 String get id; String get mobileNumber; String? get role; String? get fullName; String? get dateOfBirth; String? get panNumber; String? get aadhaarNumber; String? get address; String? get profileImage; String get status; bool get isApproved; String get createdAt; String get updatedAt; bool? get requiresAdminApproval;
/// Create a copy of ChooseRoleUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseRoleUserCopyWith<ChooseRoleUser> get copyWith => _$ChooseRoleUserCopyWithImpl<ChooseRoleUser>(this as ChooseRoleUser, _$identity);

  /// Serializes this ChooseRoleUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseRoleUser&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'ChooseRoleUser(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class $ChooseRoleUserCopyWith<$Res>  {
  factory $ChooseRoleUserCopyWith(ChooseRoleUser value, $Res Function(ChooseRoleUser) _then) = _$ChooseRoleUserCopyWithImpl;
@useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class _$ChooseRoleUserCopyWithImpl<$Res>
    implements $ChooseRoleUserCopyWith<$Res> {
  _$ChooseRoleUserCopyWithImpl(this._self, this._then);

  final ChooseRoleUser _self;
  final $Res Function(ChooseRoleUser) _then;

/// Create a copy of ChooseRoleUser
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


/// Adds pattern-matching-related methods to [ChooseRoleUser].
extension ChooseRoleUserPatterns on ChooseRoleUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChooseRoleUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChooseRoleUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChooseRoleUser value)  $default,){
final _that = this;
switch (_that) {
case _ChooseRoleUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChooseRoleUser value)?  $default,){
final _that = this;
switch (_that) {
case _ChooseRoleUser() when $default != null:
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
case _ChooseRoleUser() when $default != null:
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
case _ChooseRoleUser():
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
case _ChooseRoleUser() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChooseRoleUser implements ChooseRoleUser {
  const _ChooseRoleUser({required this.id, required this.mobileNumber, this.role, this.fullName, this.dateOfBirth, this.panNumber, this.aadhaarNumber, this.address, this.profileImage, required this.status, required this.isApproved, required this.createdAt, required this.updatedAt, this.requiresAdminApproval});
  factory _ChooseRoleUser.fromJson(Map<String, dynamic> json) => _$ChooseRoleUserFromJson(json);

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

/// Create a copy of ChooseRoleUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChooseRoleUserCopyWith<_ChooseRoleUser> get copyWith => __$ChooseRoleUserCopyWithImpl<_ChooseRoleUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChooseRoleUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChooseRoleUser&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'ChooseRoleUser(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class _$ChooseRoleUserCopyWith<$Res> implements $ChooseRoleUserCopyWith<$Res> {
  factory _$ChooseRoleUserCopyWith(_ChooseRoleUser value, $Res Function(_ChooseRoleUser) _then) = __$ChooseRoleUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, String? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});




}
/// @nodoc
class __$ChooseRoleUserCopyWithImpl<$Res>
    implements _$ChooseRoleUserCopyWith<$Res> {
  __$ChooseRoleUserCopyWithImpl(this._self, this._then);

  final _ChooseRoleUser _self;
  final $Res Function(_ChooseRoleUser) _then;

/// Create a copy of ChooseRoleUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = freezed,}) {
  return _then(_ChooseRoleUser(
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
