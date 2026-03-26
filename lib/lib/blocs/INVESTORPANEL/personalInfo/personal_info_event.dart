part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object?> get props => [];
}

class SetUniqueKey extends PersonalInfoEvent {
  final String uniqueKey;
  const SetUniqueKey(this.uniqueKey);

  @override
  List<Object?> get props => [uniqueKey];
}

class FullNameChanged extends PersonalInfoEvent {
  final String fullName;
  const FullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

class DobChanged extends PersonalInfoEvent {
  final String dateOfBirth;
  const DobChanged(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

class PanChanged extends PersonalInfoEvent {
  final String panNumber;
  const PanChanged(this.panNumber);

  @override
  List<Object?> get props => [panNumber];
}

class AadhaarChanged extends PersonalInfoEvent {
  final String aadhaarNumber;
  const AadhaarChanged(this.aadhaarNumber);

  @override
  List<Object?> get props => [aadhaarNumber];
}

class AddressChanged extends PersonalInfoEvent {
  final String houseNumber;
  final String street;
  final String area;
  final String city;
  final String state;
  final String pinCode;

  const AddressChanged({
    required this.houseNumber,
    required this.street,
    required this.area,
    required this.city,
    required this.state,
    required this.pinCode,
  });

  @override
  List<Object?> get props => [houseNumber, street, area, city, state, pinCode];
}

class SubmitPersonalInfo extends PersonalInfoEvent {}
