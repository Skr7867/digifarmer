class UserProfileModel {
  bool? success;
  User? user;

  UserProfileModel({this.success, this.user});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? mobileNumber;
  String? email;
  String? role;
  String? fullName;
  String? dateOfBirth;
  String? panNumber;
  String? aadhaarNumber;
  Address? address;
  String? profileImage;
  String? status;
  bool? isApproved;
  String? createdAt;
  String? updatedAt;
  bool? requiresAdminApproval;

  User({
    this.id,
    this.mobileNumber,
    this.email,
    this.role,
    this.fullName,
    this.dateOfBirth,
    this.panNumber,
    this.aadhaarNumber,
    this.address,
    this.profileImage,
    this.status,
    this.isApproved,
    this.createdAt,
    this.updatedAt,
    this.requiresAdminApproval,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    mobileNumber = json['mobileNumber']?.toString();
    email = json['email']?.toString();
    role = json['role']?.toString();
    fullName = json['fullName']?.toString();
    dateOfBirth = json['dateOfBirth']?.toString();
    panNumber = json['panNumber']?.toString();
    aadhaarNumber = json['aadhaarNumber']?.toString();

    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;

    profileImage = json['profileImage']?.toString();
    status = json['status']?.toString();
    isApproved = json['isApproved'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    requiresAdminApproval = json['requiresAdminApproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = id;
    data['mobileNumber'] = mobileNumber;
    data['email'] = email;
    data['role'] = role;
    data['fullName'] = fullName;
    data['dateOfBirth'] = dateOfBirth;
    data['panNumber'] = panNumber;
    data['aadhaarNumber'] = aadhaarNumber;

    if (address != null) {
      data['address'] = address!.toJson();
    }

    data['profileImage'] = profileImage;
    data['status'] = status;
    data['isApproved'] = isApproved;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['requiresAdminApproval'] = requiresAdminApproval;

    return data;
  }
}

class Address {
  String? houseNumber;
  String? street;
  String? area;
  String? city;
  String? state;
  String? pinCode;
  String? sId;

  Address({
    this.houseNumber,
    this.street,
    this.area,
    this.city,
    this.state,
    this.pinCode,
    this.sId,
  });

  Address.fromJson(Map<String, dynamic> json) {
    houseNumber = json['houseNumber']?.toString();
    street = json['street']?.toString();
    area = json['area']?.toString();
    city = json['city']?.toString();
    state = json['state']?.toString();
    pinCode = json['pinCode']?.toString();
    sId = json['_id']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['houseNumber'] = houseNumber;
    data['street'] = street;
    data['area'] = area;
    data['city'] = city;
    data['state'] = state;
    data['pinCode'] = pinCode;
    data['_id'] = sId;
    return data;
  }
}