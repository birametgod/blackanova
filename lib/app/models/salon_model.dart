/*
 * File name: salon_model.dart
 * Last modified: 2022.10.16 at 12:23:16
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:core';

import '../../common/uuid.dart';
import 'address_model.dart';
import 'availability_hour_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'salon_level_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class Salon extends Model {

  String? _name;
  String? _description;
  List<Media>? _images;
  String? _phoneNumber;
  String? _mobileNumber;
  SalonLevel? _salonLevel;
  List<AvailabilityHour>? _availabilityHours;
  double? _availabilityRange;
  double? _distance;
  bool? _closed;
  bool? _featured;
  Address? _address;
  List<Tax>? _taxes;
  List<User>? _employees;
  double? _rate;
  List<Review>? _reviews;
  int? _totalReviews;
  bool? _verified;

  Salon(
      {String? id,
      String? name,
      String? description,
      String? phoneNumber,
      String? mobileNumber,
      SalonLevel? salonLevel,
      List<AvailabilityHour>? availabilityHours,
      double? availabilityRange,
      double? distance,
      bool? closed,
      bool? featured,
      Address? address,
      List<Tax>? taxes,
      List<User>? employees,
      double? rate,
      List<Review>? reviews,
      int? totalReviews,
      bool? verified}) {
    this.id = id;
    _name = name;
    _description = description;
    _phoneNumber = phoneNumber;
    _mobileNumber = mobileNumber;
    _salonLevel = salonLevel;
    _availabilityHours = availabilityHours;
    _availabilityRange = availabilityRange;
    _distance = distance;
    _closed = closed;
    _featured = featured;
    _address = address;
    _taxes = taxes;
    _employees = employees;
    _rate = rate;
    _reviews = reviews;
    _totalReviews = totalReviews;
    _verified = verified;
  }

  Salon.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _images = mediaListFromJson(json, 'images');
    _phoneNumber = stringFromJson(json, 'phone_number');
    _mobileNumber = stringFromJson(json, 'mobile_number');
    _salonLevel = objectFromJson(json, 'salon_level', (v) => SalonLevel.fromJson(v));
    _availabilityHours = listFromJson(json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    _availabilityRange = doubleFromJson(json, 'availability_range');
    _distance = doubleFromJson(json, 'distance');
    _closed = boolFromJson(json, 'closed');
    _featured = boolFromJson(json, 'featured');
    _address = objectFromJson(json, 'address', (v) => Address.fromJson(v));
    _taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    _employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    _rate = doubleFromJson(json, 'rate');
    _reviews = listFromJson(json, 'salon_reviews', (v) => Review.fromJson(v));
    if (reviews != null) {
      _totalReviews = reviews!.isEmpty ? intFromJson(json, 'total_reviews') : reviews!.length;
    }
    _verified = boolFromJson(json, 'verified');
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  String? get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  List<Media>? get images => _images;

  set images(List<Media>? value) {
    _images = value;
  }

  String? get phoneNumber => _phoneNumber ?? '';

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String? get mobileNumber => _mobileNumber ?? '';

  set mobileNumber(String? value) {
    _mobileNumber = value;
  }

  SalonLevel? get salonLevel => _salonLevel ?? SalonLevel();

  set salonLevel(SalonLevel? value) {
    _salonLevel = value;
  }

  List<AvailabilityHour>? get availabilityHours => _availabilityHours ?? [];

  set availabilityHours(List<AvailabilityHour>? value) {
    _availabilityHours = value;
  }

  double? get availabilityRange => _availabilityRange ?? 0.0;

  set availabilityRange(double? value) {
    _availabilityRange = value;
  }

  double? get distance => _distance ?? 0.0;

  set distance(double? value) {
    _distance = value;
  }

  bool? get closed => _closed ?? false;

  set closed(bool? value) {
    _closed = value;
  }

  bool? get featured => _featured ?? false;

  set featured(bool? value) {
    _featured = value;
  }

  Address? get address => _address ?? Address();

  set address(Address? value) {
    _address = value;
  }

  List<Tax>? get taxes => _taxes;

  set taxes(List<Tax>? value) {
    _taxes = value;
  }

  List<User>? get employees => _employees;

  set employees(List<User>? value) {
    _employees = value;
  }

  double? get rate => _rate ?? 0.0;

  set rate(double? value) {
    _rate = value;
  }

  List<Review>? get reviews => _reviews;

  set reviews(List<Review>? value) {
    _reviews = value;
  }

  int? get totalReviews => _totalReviews ?? 0;

  set totalReviews(int? value) {
    _totalReviews = value;
  }

  bool? get verified => _verified ?? false;

  set verified(bool? value) {
    _verified = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (description != null) data['description'] = this.description;
    if (closed != null) data['closed'] = this.closed;
    if (phoneNumber != null) data['phone_number'] = this.phoneNumber;
    if (mobileNumber != null) data['mobile_number'] = this.mobileNumber;
    if (rate != null) data['rate'] = this.rate;
    if (totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (verified != null) data['verified'] = this.verified;
    if (distance != null) data['distance'] = this.distance;
    if (this.salonLevel != null) {
      data['salon_level_id'] = this.salonLevel!.id;
    }
    if (this.images != null) {
      data['image'] = this.images!.where((element) => Uuid.isUuid(element.id!)).map((v) => v.id).toList();
    }
    if (this.address != null) {
      data['address_id'] = this.address!.id;
    }
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.id).toList();
    }
    if (this.taxes != null) {
      data['taxes'] = this.taxes!.map((v) => v.id).toList();
    }
    if (this.availabilityRange != null) {
      data['availability_range'] = availabilityRange;
    }
    return data;
  }

  String get firstImageUrl => this.images?.first.url ?? '';

  String get firstImageThumb => this.images?.first.thumb ?? '';

  String get firstImageIcon => this.images?.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  Map<String, List<AvailabilityHour>> groupedAvailabilityHours() {
    Map<String, List<AvailabilityHour>> result = {};
    this.availabilityHours!.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day]!.add(element);
      } else {
        result[element.day!] = [element];
      }
    });
    return result;
  }

  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    this.availabilityHours!.forEach((element) {
      if (element.day == day) {
        result.add(element.data!);
      }
    });
    return result;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || super == other && other is Salon &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          images == other.images &&
          phoneNumber == other.phoneNumber &&
          mobileNumber == other.mobileNumber &&
          salonLevel == other.salonLevel &&
          availabilityRange == other.availabilityRange &&
          distance == other.distance &&
          closed == other.closed &&
          featured == other.featured &&
          address == other.address &&
          rate == other.rate &&
          reviews == other.reviews &&
          totalReviews == other.totalReviews &&
          verified == other.verified;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      salonLevel.hashCode ^
      availabilityRange.hashCode ^
      distance.hashCode ^
      closed.hashCode ^
      featured.hashCode ^
      address.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode;
}
