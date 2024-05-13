import 'parents/model.dart';

class Coupon extends Model {
  String? _code;
  double? _discount;
  String? _discountType;
  double? _value;

  Coupon({String? id, String? code, double? discount = 0, String? discountType, double? value}) {
    this.id = id;
    _discountType = discountType;
    _discount = discount;
    _code = code;
    _value = value;
  }




  Coupon.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    code = stringFromJson(json, 'code');
    discount = doubleFromJson(json, 'discount');
    discountType = stringFromJson(json, 'discount_type');
    value = doubleFromJson(json, 'value');
  }



  String get code => _code ?? '';

  set code(String? value) {
    _code = value;
  }

  double get discount => _discount ?? 0;

  set discount(double? value) {
    _discount = value;
  }

  String get discountType => _discountType ?? '';

  set discountType(String? value) {
    _discountType = value;
  }

  double get value => _value ?? 0;

  set value(double? value) {
    _value = value;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['value'] = this.value;
    return data;
  }
}
