part of 'land_location_bloc.dart';

abstract class LandLocationEvent extends Equatable {
  const LandLocationEvent();

  @override
  List<Object?> get props => [];
}

class SetTempId extends LandLocationEvent {
  final String tempId;
  const SetTempId(this.tempId);

  @override
  List<Object?> get props => [tempId];
}

class AddressChanged extends LandLocationEvent {
  final String address;
  const AddressChanged(this.address);

  @override
  List<Object?> get props => [address];
}

class CityChanged extends LandLocationEvent {
  final String city;
  const CityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class StateChanged extends LandLocationEvent {
  final String state;
  const StateChanged(this.state);

  @override
  List<Object?> get props => [state];
}

class PinCodeChanged extends LandLocationEvent {
  final String pinCode;
  const PinCodeChanged(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}

class VillageChanged extends LandLocationEvent {
  final String village;
  const VillageChanged(this.village);

  @override
  List<Object?> get props => [village];
}

class TehsilChanged extends LandLocationEvent {
  final String tehsil;
  const TehsilChanged(this.tehsil);

  @override
  List<Object?> get props => [tehsil];
}

class DistrictChanged extends LandLocationEvent {
  final String district;
  const DistrictChanged(this.district);

  @override
  List<Object?> get props => [district];
}

class LatitudeChanged extends LandLocationEvent {
  final double latitude;
  const LatitudeChanged(this.latitude);

  @override
  List<Object?> get props => [latitude];
}

class LongitudeChanged extends LandLocationEvent {
  final double longitude;
  const LongitudeChanged(this.longitude);

  @override
  List<Object?> get props => [longitude];
}

class LocationImageChanged extends LandLocationEvent {
  final File? imageFile;
  const LocationImageChanged(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class SetLocationFromCoordinates extends LandLocationEvent {
  final double latitude;
  final double longitude;
  final String address;
  final String? city;
  final String? state;
  final String? pinCode;
  final String? village;
  final String? tehsil;
  final String? district;

  const SetLocationFromCoordinates({
    required this.latitude,
    required this.longitude,
    required this.address,
    this.city,
    this.state,
    this.pinCode,
    this.village,
    this.tehsil,
    this.district,
  });

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    address,
    city,
    state,
    pinCode,
    village,
    tehsil,
    district,
  ];
}

class SubmitLandLocation extends LandLocationEvent {}

class ResetLocationState extends LandLocationEvent {}
