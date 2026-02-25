part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  const PersonalInfoState({
    this.uniqueKey = '',
    this.fullName = '',
    this.dateOfBirth = '',
    this.panNumber = '',
    this.aadhaarNumber = '',
    this.houseNumber = '',
    this.street = '',
    this.area = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String uniqueKey;
  final String fullName;
  final String dateOfBirth;
  final String panNumber;
  final String aadhaarNumber;
  final String houseNumber;
  final String street;
  final String area;
  final String city;
  final String state;
  final String pinCode;
  final String message;
  final PostApiStatus postApiStatus;

  PersonalInfoState copyWith({
    String? uniqueKey,
    String? fullName,
    String? dateOfBirth,
    String? panNumber,
    String? aadhaarNumber,
    String? houseNumber,
    String? street,
    String? area,
    String? city,
    String? state,
    String? pinCode,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return PersonalInfoState(
      uniqueKey: uniqueKey ?? this.uniqueKey,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      panNumber: panNumber ?? this.panNumber,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      houseNumber: houseNumber ?? this.houseNumber,
      street: street ?? this.street,
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    uniqueKey,
    fullName,
    dateOfBirth,
    panNumber,
    aadhaarNumber,
    houseNumber,
    street,
    area,
    city,
    state,
    pinCode,
    message,
    postApiStatus,
  ];
}
