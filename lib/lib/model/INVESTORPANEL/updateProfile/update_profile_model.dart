class UpdateProfileModel {
  bool? success;
  String? message;
  User? user;

  UpdateProfileModel({this.success, this.message, this.user});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    profileImage = json['profileImage'];
    status = json['status'];
    isApproved = json['isApproved'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    requiresAdminApproval = json['requiresAdminApproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobileNumber'] = this.mobileNumber;
    data['email'] = this.email;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['panNumber'] = this.panNumber;
    data['aadhaarNumber'] = this.aadhaarNumber;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['profileImage'] = this.profileImage;
    data['status'] = this.status;
    data['isApproved'] = this.isApproved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['requiresAdminApproval'] = this.requiresAdminApproval;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['houseNumber'] = this.houseNumber;
    data['street'] = this.street;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['_id'] = this.sId;
    return data;
  }
}
