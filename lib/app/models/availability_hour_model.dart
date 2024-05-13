/*
 * File name: availability_hour_model.dart
 * Last modified: 2022.10.16 at 12:23:16
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import 'dart:core';

import 'parents/model.dart';
import 'salon_model.dart';

class AvailabilityHour extends Model {
  String? _day;
  String? _startAt;
  String? _endAt;
  String? _data;
  Salon? _salon;

  AvailabilityHour(
      {String? id,
      String? day,
      String? startAt,
      String? endAt,
      String? data,
      Salon? salon}) {
    this.id = id;
    _day = day;
    _startAt = startAt;
    _endAt = endAt;
    _data = data;
    _salon = salon;
  }

  AvailabilityHour.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _day = transStringFromJson(json, 'day');
    _startAt = stringFromJson(json, 'start_at');
    _endAt = stringFromJson(json, 'end_at');
    _data = transStringFromJson(json, 'data');
    _salon = objectFromJson(json, 'salon', (value) => Salon.fromJson(value));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    if (this.hasData) map['id'] = this.id;
    if (day != null) map['day'] = this.day;
    if (startAt != null) map['start_at'] = this.startAt;
    if (endAt != null) map['end_at'] = this.endAt;
    if (data != null) map['data'] = this.data;
    if (this.salon != null) map['salon_id'] = this.salon!.id;
    return map;
  }

  String toDuration() {
    return '$startAt - $endAt';
  }

  String? get day => _day ?? '';

  set day(String? value) {
    _day = value;
  }

  String? get startAt => _startAt  ?? '';

  set startAt(String? value) {
    _startAt = value;
  }

  String? get endAt => _endAt  ?? '' ;

  set endAt(String? value) {
    _endAt = value;
  }

  String? get data => _data ?? '';

  set data(String? value) {
    _data = value;
  }

  Salon? get salon => _salon;

  set salon(Salon? value) {
    _salon = value;
  }


  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is AvailabilityHour &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          day == other.day &&
          startAt == other.startAt &&
          endAt == other.endAt &&
          data == other.data &&
          salon == other.salon;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ day.hashCode ^ startAt.hashCode ^ endAt.hashCode ^ data.hashCode ^ salon.hashCode;
}
