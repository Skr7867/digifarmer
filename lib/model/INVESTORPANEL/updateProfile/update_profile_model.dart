class UpdateProfileModel {
  bool? success;
  String? message;
  User? user;

  UpdateProfileModel({this.success, this.message, this.user});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? mobileNumber;
  Null email;
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

  User(
      {this.id,
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
      this.requiresAdminApproval});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    role = json['role'];
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
    panNumber = json['panNumber'];
    aadhaarNumber = json['aadhaarNumber'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    profileImage = json['profileImage'];
    status = json['status'];
    isApproved = json['isApproved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    requiresAdminApproval = json['requiresAdminApproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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

  Address(
      {this.houseNumber,
      this.street,
      this.area,
      this.city,
      this.state,
      this.pinCode,
      this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    houseNumber = json['houseNumber'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
    sId = json['_id'];
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
