// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_details_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalDetailsResponseModel {

 bool get success; String get uniqueKey; String get message; PersonalDetailsUserModel get user;
/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsResponseModelCopyWith<PersonalDetailsResponseModel> get copyWith => _$PersonalDetailsResponseModelCopyWithImpl<PersonalDetailsResponseModel>(this as PersonalDetailsResponseModel, _$identity);

  /// Serializes this PersonalDetailsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetailsResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'PersonalDetailsResponseModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsResponseModelCopyWith<$Res>  {
  factory $PersonalDetailsResponseModelCopyWith(PersonalDetailsResponseModel value, $Res Function(PersonalDetailsResponseModel) _then) = _$PersonalDetailsResponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, String uniqueKey, String message, PersonalDetailsUserModel user
});


$PersonalDetailsUserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$PersonalDetailsResponseModelCopyWithImpl<$Res>
    implements $PersonalDetailsResponseModelCopyWith<$Res> {
  _$PersonalDetailsResponseModelCopyWithImpl(this._self, this._then);

  final PersonalDetailsResponseModel _self;
  final $Res Function(PersonalDetailsResponseModel) _then;

/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PersonalDetailsUserModel,
  ));
}
/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalDetailsUserModelCopyWith<$Res> get user {
  
  return $PersonalDetailsUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalDetailsResponseModel].
extension PersonalDetailsResponseModelPatterns on PersonalDetailsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDetailsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDetailsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDetailsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  PersonalDetailsUserModel user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String uniqueKey,  String message,  PersonalDetailsUserModel user)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String uniqueKey,  String message,  PersonalDetailsUserModel user)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsResponseModel() when $default != null:
return $default(_that.success,_that.uniqueKey,_that.message,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalDetailsResponseModel implements PersonalDetailsResponseModel {
  const _PersonalDetailsResponseModel({required this.success, required this.uniqueKey, required this.message, required this.user});
  factory _PersonalDetailsResponseModel.fromJson(Map<String, dynamic> json) => _$PersonalDetailsResponseModelFromJson(json);

@override final  bool success;
@override final  String uniqueKey;
@override final  String message;
@override final  PersonalDetailsUserModel user;

/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDetailsResponseModelCopyWith<_PersonalDetailsResponseModel> get copyWith => __$PersonalDetailsResponseModelCopyWithImpl<_PersonalDetailsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDetailsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetailsResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.uniqueKey, uniqueKey) || other.uniqueKey == uniqueKey)&&(identical(other.message, message) || other.message == message)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,uniqueKey,message,user);

@override
String toString() {
  return 'PersonalDetailsResponseModel(success: $success, uniqueKey: $uniqueKey, message: $message, user: $user)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsResponseModelCopyWith<$Res> implements $PersonalDetailsResponseModelCopyWith<$Res> {
  factory _$PersonalDetailsResponseModelCopyWith(_PersonalDetailsResponseModel value, $Res Function(_PersonalDetailsResponseModel) _then) = __$PersonalDetailsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String uniqueKey, String message, PersonalDetailsUserModel user
});


@override $PersonalDetailsUserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$PersonalDetailsResponseModelCopyWithImpl<$Res>
    implements _$PersonalDetailsResponseModelCopyWith<$Res> {
  __$PersonalDetailsResponseModelCopyWithImpl(this._self, this._then);

  final _PersonalDetailsResponseModel _self;
  final $Res Function(_PersonalDetailsResponseModel) _then;

/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? uniqueKey = null,Object? message = null,Object? user = null,}) {
  return _then(_PersonalDetailsResponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,uniqueKey: null == uniqueKey ? _self.uniqueKey : uniqueKey // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PersonalDetailsUserModel,
  ));
}

/// Create a copy of PersonalDetailsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalDetailsUserModelCopyWith<$Res> get user {
  
  return $PersonalDetailsUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$PersonalDetailsUserModel {

 String get id; String get mobileNumber; String? get role; String? get fullName; String? get dateOfBirth; String? get panNumber; String? get aadhaarNumber; PersonalAddressModel? get address; String? get profileImage; String get status; bool get isApproved; String get createdAt; String get updatedAt; bool? get requiresAdminApproval;
/// Create a copy of PersonalDetailsUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsUserModelCopyWith<PersonalDetailsUserModel> get copyWith => _$PersonalDetailsUserModelCopyWithImpl<PersonalDetailsUserModel>(this as PersonalDetailsUserModel, _$identity);

  /// Serializes this PersonalDetailsUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetailsUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'PersonalDetailsUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsUserModelCopyWith<$Res>  {
  factory $PersonalDetailsUserModelCopyWith(PersonalDetailsUserModel value, $Res Function(PersonalDetailsUserModel) _then) = _$PersonalDetailsUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, PersonalAddressModel? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});


$PersonalAddressModelCopyWith<$Res>? get address;

}
/// @nodoc
class _$PersonalDetailsUserModelCopyWithImpl<$Res>
    implements $PersonalDetailsUserModelCopyWith<$Res> {
  _$PersonalDetailsUserModelCopyWithImpl(this._self, this._then);

  final PersonalDetailsUserModel _self;
  final $Res Function(PersonalDetailsUserModel) _then;

/// Create a copy of PersonalDetailsUserModel
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
as PersonalAddressModel?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: freezed == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of PersonalDetailsUserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalAddressModelCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $PersonalAddressModelCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalDetailsUserModel].
extension PersonalDetailsUserModelPatterns on PersonalDetailsUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDetailsUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDetailsUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDetailsUserModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDetailsUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDetailsUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  PersonalAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetailsUserModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  PersonalAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsUserModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String mobileNumber,  String? role,  String? fullName,  String? dateOfBirth,  String? panNumber,  String? aadhaarNumber,  PersonalAddressModel? address,  String? profileImage,  String status,  bool isApproved,  String createdAt,  String updatedAt,  bool? requiresAdminApproval)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetailsUserModel() when $default != null:
return $default(_that.id,_that.mobileNumber,_that.role,_that.fullName,_that.dateOfBirth,_that.panNumber,_that.aadhaarNumber,_that.address,_that.profileImage,_that.status,_that.isApproved,_that.createdAt,_that.updatedAt,_that.requiresAdminApproval);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalDetailsUserModel implements PersonalDetailsUserModel {
  const _PersonalDetailsUserModel({required this.id, required this.mobileNumber, this.role, this.fullName, this.dateOfBirth, this.panNumber, this.aadhaarNumber, this.address, this.profileImage, required this.status, required this.isApproved, required this.createdAt, required this.updatedAt, this.requiresAdminApproval});
  factory _PersonalDetailsUserModel.fromJson(Map<String, dynamic> json) => _$PersonalDetailsUserModelFromJson(json);

@override final  String id;
@override final  String mobileNumber;
@override final  String? role;
@override final  String? fullName;
@override final  String? dateOfBirth;
@override final  String? panNumber;
@override final  String? aadhaarNumber;
@override final  PersonalAddressModel? address;
@override final  String? profileImage;
@override final  String status;
@override final  bool isApproved;
@override final  String createdAt;
@override final  String updatedAt;
@override final  bool? requiresAdminApproval;

/// Create a copy of PersonalDetailsUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDetailsUserModelCopyWith<_PersonalDetailsUserModel> get copyWith => __$PersonalDetailsUserModelCopyWithImpl<_PersonalDetailsUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDetailsUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetailsUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.panNumber, panNumber) || other.panNumber == panNumber)&&(identical(other.aadhaarNumber, aadhaarNumber) || other.aadhaarNumber == aadhaarNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.status, status) || other.status == status)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.requiresAdminApproval, requiresAdminApproval) || other.requiresAdminApproval == requiresAdminApproval));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,mobileNumber,role,fullName,dateOfBirth,panNumber,aadhaarNumber,address,profileImage,status,isApproved,createdAt,updatedAt,requiresAdminApproval);

@override
String toString() {
  return 'PersonalDetailsUserModel(id: $id, mobileNumber: $mobileNumber, role: $role, fullName: $fullName, dateOfBirth: $dateOfBirth, panNumber: $panNumber, aadhaarNumber: $aadhaarNumber, address: $address, profileImage: $profileImage, status: $status, isApproved: $isApproved, createdAt: $createdAt, updatedAt: $updatedAt, requiresAdminApproval: $requiresAdminApproval)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsUserModelCopyWith<$Res> implements $PersonalDetailsUserModelCopyWith<$Res> {
  factory _$PersonalDetailsUserModelCopyWith(_PersonalDetailsUserModel value, $Res Function(_PersonalDetailsUserModel) _then) = __$PersonalDetailsUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String mobileNumber, String? role, String? fullName, String? dateOfBirth, String? panNumber, String? aadhaarNumber, PersonalAddressModel? address, String? profileImage, String status, bool isApproved, String createdAt, String updatedAt, bool? requiresAdminApproval
});


@override $PersonalAddressModelCopyWith<$Res>? get address;

}
/// @nodoc
class __$PersonalDetailsUserModelCopyWithImpl<$Res>
    implements _$PersonalDetailsUserModelCopyWith<$Res> {
  __$PersonalDetailsUserModelCopyWithImpl(this._self, this._then);

  final _PersonalDetailsUserModel _self;
  final $Res Function(_PersonalDetailsUserModel) _then;

/// Create a copy of PersonalDetailsUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mobileNumber = null,Object? role = freezed,Object? fullName = freezed,Object? dateOfBirth = freezed,Object? panNumber = freezed,Object? aadhaarNumber = freezed,Object? address = freezed,Object? profileImage = freezed,Object? status = null,Object? isApproved = null,Object? createdAt = null,Object? updatedAt = null,Object? requiresAdminApproval = freezed,}) {
  return _then(_PersonalDetailsUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: null == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,panNumber: freezed == panNumber ? _self.panNumber : panNumber // ignore: cast_nullable_to_non_nullable
as String?,aadhaarNumber: freezed == aadhaarNumber ? _self.aadhaarNumber : aadhaarNumber // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as PersonalAddressModel?,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,requiresAdminApproval: freezed == requiresAdminApproval ? _self.requiresAdminApproval : requiresAdminApproval // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of PersonalDetailsUserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalAddressModelCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $PersonalAddressModelCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$PersonalAddressModel {

 String? get houseNumber; String? get street; String? get area; String? get city; String? get state; String? get pinCode;@JsonKey(name: '_id') String? get id;
/// Create a copy of PersonalAddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalAddressModelCopyWith<PersonalAddressModel> get copyWith => _$PersonalAddressModelCopyWithImpl<PersonalAddressModel>(this as PersonalAddressModel, _$identity);

  /// Serializes this PersonalAddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalAddressModel&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,houseNumber,street,area,city,state,pinCode,id);

@override
String toString() {
  return 'PersonalAddressModel(houseNumber: $houseNumber, street: $street, area: $area, city: $city, state: $state, pinCode: $pinCode, id: $id)';
}


}

/// @nodoc
abstract mixin class $PersonalAddressModelCopyWith<$Res>  {
  factory $PersonalAddressModelCopyWith(PersonalAddressModel value, $Res Function(PersonalAddressModel) _then) = _$PersonalAddressModelCopyWithImpl;
@useResult
$Res call({
 String? houseNumber, String? street, String? area, String? city, String? state, String? pinCode,@JsonKey(name: '_id') String? id
});




}
/// @nodoc
class _$PersonalAddressModelCopyWithImpl<$Res>
    implements $PersonalAddressModelCopyWith<$Res> {
  _$PersonalAddressModelCopyWithImpl(this._self, this._then);

  final PersonalAddressModel _self;
  final $Res Function(PersonalAddressModel) _then;

/// Create a copy of PersonalAddressModel
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


/// Adds pattern-matching-related methods to [PersonalAddressModel].
extension PersonalAddressModelPatterns on PersonalAddressModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalAddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalAddressModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalAddressModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalAddressModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalAddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalAddressModel() when $default != null:
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
case _PersonalAddressModel() when $default != null:
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
case _PersonalAddressModel():
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
case _PersonalAddressModel() when $default != null:
return $default(_that.houseNumber,_that.street,_that.area,_that.city,_that.state,_that.pinCode,_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalAddressModel implements PersonalAddressModel {
  const _PersonalAddressModel({this.houseNumber, this.street, this.area, this.city, this.state, this.pinCode, @JsonKey(name: '_id') this.id});
  factory _PersonalAddressModel.fromJson(Map<String, dynamic> json) => _$PersonalAddressModelFromJson(json);

@override final  String? houseNumber;
@override final  String? street;
@override final  String? area;
@override final  String? city;
@override final  String? state;
@override final  String? pinCode;
@override@JsonKey(name: '_id') final  String? id;

/// Create a copy of PersonalAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalAddressModelCopyWith<_PersonalAddressModel> get copyWith => __$PersonalAddressModelCopyWithImpl<_PersonalAddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalAddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalAddressModel&&(identical(other.houseNumber, houseNumber) || other.houseNumber == houseNumber)&&(identical(other.street, street) || other.street == street)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,houseNumber,street,area,city,state,pinCode,id);

@override
String toString() {
  return 'PersonalAddressModel(houseNumber: $houseNumber, street: $street, area: $area, city: $city, state: $state, pinCode: $pinCode, id: $id)';
}


}

/// @nodoc
abstract mixin class _$PersonalAddressModelCopyWith<$Res> implements $PersonalAddressModelCopyWith<$Res> {
  factory _$PersonalAddressModelCopyWith(_PersonalAddressModel value, $Res Function(_PersonalAddressModel) _then) = __$PersonalAddressModelCopyWithImpl;
@override @useResult
$Res call({
 String? houseNumber, String? street, String? area, String? city, String? state, String? pinCode,@JsonKey(name: '_id') String? id
});




}
/// @nodoc
class __$PersonalAddressModelCopyWithImpl<$Res>
    implements _$PersonalAddressModelCopyWith<$Res> {
  __$PersonalAddressModelCopyWithImpl(this._self, this._then);

  final _PersonalAddressModel _self;
  final $Res Function(_PersonalAddressModel) _then;

/// Create a copy of PersonalAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? houseNumber = freezed,Object? street = freezed,Object? area = freezed,Object? city = freezed,Object? state = freezed,Object? pinCode = freezed,Object? id = freezed,}) {
  return _then(_PersonalAddressModel(
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
