/*
 * File name: e_service_model.dart
 * Last modified: 2022.03.12 at 01:21:41
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2022
 */

import '../../common/uuid.dart';
import 'category_model.dart';
import 'media_model.dart';
import 'option_group_model.dart';
import 'parents/model.dart';
import 'salon_model.dart';

class EService extends Model {
  String? _name;
  String? _description;
  List<Media>? _images;
  double? _price;
  double? _discountPrice;
  String? _duration;
  bool? _featured;
  bool? _enableBooking;
  bool? _enableAtSalon;
  bool? _enableAtCustomerAddress;
  bool? _isFavorite;
  List<Category>? _categories;
  List<Category>? _subCategories;
  List<OptionGroup>? _optionGroups;
  Salon? _salon;

  EService(
      {String? id,
      String? name,
      String? description,
      List<Media>? images,
      double? price,
      double? discountPrice,
      String? duration,
      bool? featured,
      bool? enableBooking,
      bool? enableAtSalon,
      bool? enableAtCustomerAddress,
      bool? isFavorite,
      List<Category>? categories,
      List<Category>? subCategories,
      List<OptionGroup>? optionGroups,
      Salon? salon}) {
    this.id = id;
    this._name = name;
    this._description = description;
    this._images = images;
    this._price = price;
    this._discountPrice = discountPrice;
    this._duration = duration;
    this._featured = featured;
    this._enableBooking = enableBooking;
    this._enableAtSalon = enableAtSalon;
    this._enableAtCustomerAddress = enableAtCustomerAddress;
    this._isFavorite = isFavorite;
    this._categories = categories;
    this._subCategories = subCategories;
    this._optionGroups = optionGroups;
    this._salon = salon;
  }


  EService.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _images = mediaListFromJson(json, 'images');
    _price = doubleFromJson(json, 'price');
    _discountPrice = doubleFromJson(json, 'discount_price');
    _duration = durationFromJson(json, 'duration');
    _featured = boolFromJson(json, 'featured');
    _enableBooking = boolFromJson(json, 'enable_booking');
    _enableAtSalon = boolFromJson(json, 'enable_at_salon');
    _enableAtCustomerAddress = boolFromJson(json, 'enable_at_customer_address');
    _isFavorite = boolFromJson(json, 'is_favorite');
    _categories = listFromJson<Category>(json, 'categories', (value) => Category.fromJson(value));
    _subCategories = listFromJson<Category>(json, 'sub_categories', (value) => Category.fromJson(value));
    _optionGroups = listFromJson<OptionGroup>(json, 'option_groups', (value) => OptionGroup.fromJson(value, eServiceId: id));
    _salon = objectFromJson(json, 'salon', (value) => Salon.fromJson(value));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['duration'] = this.duration;
    data['featured'] = this.featured;
    data['enable_booking'] = this.enableBooking ?? false;
    data['enable_at_salon'] = this.enableAtSalon ?? false;
    data['enable_at_customer_address'] = this.enableAtCustomerAddress ?? false;
    data['is_favorite'] = this.isFavorite;
    data['categories'] = this.categories.map((v) => v.id).toList();
    data['image'] = this.images.where((element) => Uuid.isUuid(element.id!)).map((v) => v.id).toList();
    data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    data['option_groups'] = this.optionGroups.map((v) => v.toJson()).toList();
    if (this.salon.hasData) {
      data['salon_id'] = this.salon.id;
    }
    return data;
  }

  String get firstImageUrl => this.images.first.url ?? '';

  String get firstImageThumb => this.images.first.thumb ?? '';

  String get firstImageIcon => this.images.first.icon ?? '';

  @override
  bool get hasData {
    return id != null && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice : price;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price : 0;
  }


  List<Media> get images => _images ?? [];

  set images(List<Media> value) {
    _images = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
  }

  double get price => _price ?? 0;

  set price(double? value) {
    _price = value;
  }

  double get discountPrice => _discountPrice ?? 0;

  set discountPrice(double? value) {
    _discountPrice = value;
  }

  String? get duration => _duration;

  set duration(String? value) {
    _duration = value;
  }

  bool get featured => _featured ?? false;

  set featured(bool? value) {
    _featured = value;
  }

  bool get enableBooking => _enableBooking ?? false;

  set enableBooking(bool? value) {
    _enableBooking = value;
  }

  bool get enableAtSalon => _enableAtSalon ?? false;

  set enableAtSalon(bool? value) {
    _enableAtSalon = value;
  }

  bool get enableAtCustomerAddress => _enableAtCustomerAddress ?? false;

  set enableAtCustomerAddress(bool? value) {
    _enableAtCustomerAddress = value;
  }

  bool get isFavorite => _isFavorite ?? false;

  set isFavorite(bool? value) {
    _isFavorite = value;
  }

  List<Category> get categories => _categories ?? [];

  set categories(List<Category>? value) {
    _categories = value;
  }

  List<Category> get subCategories => _subCategories ?? [];

  set subCategories(List<Category>? value) {
    _subCategories = value;
  }

  List<OptionGroup> get optionGroups => _optionGroups ?? [];

  set optionGroups(List<OptionGroup>? value) {
    _optionGroups = value;
  }

  Salon get salon => _salon ?? Salon();

  set salon(Salon? value) {
    _salon = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isFavorite == other.isFavorite &&
          enableBooking == other.enableBooking &&
          categories == other.categories &&
          subCategories == other.subCategories &&
          salon == other.salon;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      salon.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
