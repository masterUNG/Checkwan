// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sugar {
  String? sugar;

  Sugar({
    this.sugar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sugar': sugar,
    };
  }

  factory Sugar.fromMap(Map<String, dynamic> map) {
    return Sugar(
      sugar: map['sugar'] != null ? map['sugar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sugar.fromJson(String source) => Sugar.fromMap(json.decode(source) as Map<String, dynamic>);
}
