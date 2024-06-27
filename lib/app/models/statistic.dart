import 'package:flutter/material.dart';

import 'parents/model.dart';

class Statistic extends Model {
  String? _value;
  String? _description;
  Color? _textColor;
  Color? _backgroundColor;

  Statistic(
      {String? id,
      String? value,
      String? description,
      Color? textColor,
      Color? backgroundColor}) {
    this.id = id;
    _value = value;
    _description = description;
    _textColor = textColor;
    _backgroundColor = backgroundColor;
  }

  String get value => _value ?? '';

  set value(String? value) {
    _value = value;
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  Color get textColor => _textColor ?? Colors.black;

  set textColor(Color? value) {
    _textColor = value;
  }

  Color get backgroundColor => _backgroundColor ?? Colors.white;

  set backgroundColor(Color? value) {
    _backgroundColor = value;
  }



  Statistic.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _value = stringFromJson(json, 'value', defaultValue: '0');
    _description = stringFromJson(json, 'description');
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["value"] = value;
    map["description"] = description;
    return map;
  }
}
