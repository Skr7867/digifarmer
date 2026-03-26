part of 'land_location_bloc.dart';

class LandLocationState extends Equatable {
  const LandLocationState({
    this.tempId = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.village = '',
    this.tehsil = '',
    this.district = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.imageFile,
    this.responseTempId = '',
    this.currentStep = 2,
    this.nextStep = '',
    this.expiresAt,
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String tempId;
  final String address;
  final String city;
  final String state;
  final String pinCode;
  final String village;
  final String tehsil;
  final String district;
  final double latitude;
  final double longitude;
  final File? imageFile;

  // Response fields
  final String responseTempId;
  final int currentStep;
  final String nextStep;
  final DateTime? expiresAt;

  final String message;
  final PostApiStatus postApiStatus;

  LandLocationState copyWith({
    String? tempId,
    String? address,
    String? city,
    String? state,
    String? pinCode,
    String? village,
    String? tehsil,
    String? district,
    double? latitude,
    double? longitude,
    File? imageFile,
    String? responseTempId,
    int? currentStep,
    String? nextStep,
    DateTime? expiresAt,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return LandLocationState(
      tempId: tempId ?? this.tempId,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      village: village ?? this.village,
      tehsil: tehsil ?? this.tehsil,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageFile: imageFile ?? this.imageFile,
      responseTempId: responseTempId ?? this.responseTempId,
      currentStep: currentStep ?? this.currentStep,
      nextStep: nextStep ?? this.nextStep,
      expiresAt: expiresAt ?? this.expiresAt,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    tempId,
    address,
    city,
    state,
    pinCode,
    village,
    tehsil,
    district,
    latitude,
    longitude,
    imageFile,
    responseTempId,
    currentStep,
    nextStep,
    expiresAt,
    message,
    postApiStatus,
  ];
}
