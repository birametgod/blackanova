import 'parents/model.dart';

class Role extends Model {
  String? _name;
  bool? _isdDefault;

  Role({String? id, String? name, bool? isdDefault}) {
    this.id = id;
    _name = name;
    _isdDefault = isdDefault;
  }

  String get name => _name ?? '';
  set name(String? value) {
    _name = value;
  }

  bool get isdDefault => _isdDefault ?? false;

  set isdDefault(bool? value) {
    _isdDefault = value;
  }

  Role.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    //name = transStringFromJson(json, 'name');
    isdDefault = boolFromJson(json, 'default');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['default'] = this.isdDefault;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other && other is Role && runtimeType == other.runtimeType && id == other.id && name == other.name && isdDefault == other.isdDefault;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ isdDefault.hashCode;
}
