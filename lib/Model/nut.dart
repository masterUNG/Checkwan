// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Nut {
  String? ndate;
  String? ntime;
  String? ndoc;
  String? nhos;

  Nut({
    this.ndate,
    this.ntime,
    this.ndoc,
    this.nhos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ndate': ndate,
      'ntime': ntime,
      'ndoc': ndoc,
      'nhos': nhos,
    };
  }

  factory Nut.fromMap(Map<String, dynamic> map) {
    return Nut(
      ndate: map['ndate'] ?? '',
      ntime: map['ntime'] ?? '',
      ndoc: map['ndoc'] ?? '',
      nhos: map['nhos'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Nut.fromJson(String source) => Nut.fromMap(json.decode(source) as Map<String, dynamic>);
}
