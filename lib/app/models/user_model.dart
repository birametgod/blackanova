import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/uuid.dart';
import '../services/settings_service.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'role_model.dart';

class User extends Model {
  String? _name;
  String? _email;
  String? _password;
  Media? _avatar;
  String? _apiToken;
  String? _deviceToken;
  String? _phoneNumber;
  bool? _verifiedPhone;
  double? _latitude;
  double? _longitude;
  String? _verificationId;
  String? _address;
  String? _bio;
  int? _rate;
  String? _profileImageUrl;
  List<Role>? _roles;
  bool? _auth;

  User(
      {String? id,
        String? name,
        String? email,
        String? password,
        String? apiToken,
        String? deviceToken,
        String? phoneNumber,
        String? verificationId,
        String? address,
        double? latitude,
        double? longitude,
        String? description,
        String? profileImageUrl,
        String? bio,
        Media? avatar,
        int? rate,
        List<Role>? roles,
        bool? auth}) {
    this.id = id;
    _auth = auth;
    _bio = bio;
    _address = address;
    _verificationId = verificationId;
    _phoneNumber = phoneNumber;
    _deviceToken = deviceToken;
    _apiToken = apiToken;
    _avatar = avatar;
    _longitude = longitude;
    _latitude = latitude;
    _rate = rate;
    _password = password;
    _email = email;
    _name = name;
    _roles = roles;
    _profileImageUrl = profileImageUrl;
  }

  User.fromJson(Map<String, dynamic>? json) {
    _name = stringFromJson(json, 'name');
    _email = stringFromJson(json, 'email');
    _apiToken = stringFromJson(json, 'api_token');
    _deviceToken = stringFromJson(json, 'device_token');
    _phoneNumber = stringFromJson(json, 'phone_number');
    _verifiedPhone = boolFromJson(json, 'phone_verified_at');
    _avatar = mediaFromJson(json, 'avatar');
    _latitude = doubleFromJson(json, 'latitude', decimal: 10);
    _longitude = doubleFromJson(json, 'longitude', decimal: 10);
    _auth = boolFromJson(json, 'auth');
    _rate = intFromJson(json, 'rate');
    _profileImageUrl = stringFromJson(json, 'profileImageUrl');
    try {
      _address = json?['custom_fields']['address']['view'];
    } catch (e) {
      _address = stringFromJson(json, 'address');
    }
    _roles = listFromJson(json, 'roles', (v) => Role.fromJson(v));
    try {
      _bio = json?['custom_fields']['bio']['view'];
    } catch (e) {
      _bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }
  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  String? get password => _password ?? '';

  set password(String? value) {
    _password = value;
  }

  String? get phoneNumber => _phoneNumber ?? '';

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  double get latitude => _latitude ?? 0;

  set latitude(double? value) {
    _latitude = value;
  }

  double get longitude => _longitude ?? 0;

  set longitude(double? value) {
    _longitude = value;
  }

  String get verificationId => _verificationId ?? '';

  set verificationId(String? value) {
    _verificationId = value;
  }

  bool? get verifiedPhone => _verifiedPhone ?? false;

  set verifiedPhone(bool? value) {
    _verifiedPhone = value;
  }

  int? get rate => _rate ?? 0;

  set rate(int? value) {
    _rate = value;
  }

  String get address => _address ?? '';

  set address(String? value) {
    _address = value;
  }

  String get apiToken {
    if ((_auth ?? false)) {
      return _apiToken ?? '';
    } else {
      return '';
    }
  }

  set apiToken(String? value) {
    _apiToken = value;
  }

  bool? get auth => _auth;

  set auth(bool? value) {
    _auth = value;
  }

  Media? get avatar => _avatar;

  set avatar(Media? value) {
    _avatar = value;
  }

  String get bio => _bio ?? '';

  set bio(String? value) {
    _bio = value;
  }

  String get profileImageUrl => _profileImageUrl ?? '';

  set profileImageUrl(String ? value) {
    _profileImageUrl = value;
  }

  String? get deviceToken => _deviceToken ?? '';

  set deviceToken(String? value) {
    _deviceToken = value;
  }

  String get email => _email ?? '';

  set email(String? value) {
    _email = value;
  }

  List<Role>? get roles => _roles ?? [];

  set roles(List<Role>? value) {
    _roles = value;
  }

  LatLng getLatLng() {
    if (this.isUnknown()) {
      return LatLng(38.806103, 52.4964453);
    } else {
      return LatLng(this.latitude, this.longitude);
    }
  }

  bool isUnknown() {
    return _latitude == null && _longitude == null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (password != null && password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this.apiToken;
    if (deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;

    if (_latitude != null) {
      data['latitude'] = _latitude;
    }
    if (_longitude != null) {
      data['longitude'] = _longitude;
    }
    if (verifiedPhone != null && verifiedPhone!) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    data["rate"] = rate;
    data["profileImageUrl"] = profileImageUrl;
    /* if (this.avatar != null && Uuid.isUuid(avatar!.id!)) {
      data['avatar'] = this.avatar!.id;
    }*/
    if (avatar != null) {
      data["media"] = [avatar!.toJson()];
    }
    data['auth'] = this.auth;
    if (roles != null) {
      data['roles'] = this.roles!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar!.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  PhoneNumber getPhoneNumber() {
    if (phoneNumber != null && phoneNumber!.length >= 4) {
      phoneNumber = phoneNumber!.replaceAll(' ', '');
      String dialCode1 = phoneNumber!.substring(1, 2);
      String dialCode2 = phoneNumber!.substring(1, 3);
      String dialCode3 = phoneNumber!.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode1, number: phoneNumber!.substring(2));
        } else if (countries[i].dialCode == dialCode2) {
          return PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode2, number: phoneNumber!.substring(3));
        } else if (countries[i].dialCode == dialCode3) {
          return PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode3, number: phoneNumber!.substring(4));
        }
      }
    }
    return PhoneNumber(countryISOCode: Get.find<SettingsService>().setting.value.defaultCountryCode!, countryCode: '1', number: '');
  }

  bool get isAdmin => (this.roles?.where((element) => element.name == 'admin').length ?? 0) > 0;

  bool get isSalonOwner => (this.roles?.where((element) => element.name == 'salon owner' || element.name == 'admin').length ?? 0) > 0;

  bool get isCustomer => (this.roles?.where((element) => element.isdDefault).length ?? 0) > 0;

  @override
  bool operator ==(dynamic other) =>
      super == other &&
          other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          avatar == other.avatar &&
          apiToken == other.apiToken &&
          deviceToken == other.deviceToken &&
          phoneNumber == other.phoneNumber &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          verifiedPhone == other.verifiedPhone &&
          verificationId == other.verificationId &&
          address == other.address &&
          bio == other.bio &&
          roles == other.roles &&
          rate == other.rate &&
          profileImageUrl == other.profileImageUrl &&
          auth == other.auth;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      longitude.hashCode ^
      latitude.hashCode ^
      roles.hashCode ^
      rate.hashCode ^
      profileImageUrl.hashCode ^
      auth.hashCode;
}