import 'package:equatable/equatable.dart';

class KriteriaModel extends Equatable {
  final String name;
  final num w;
  final bool isBenefit;

  const KriteriaModel({
    this.name = '',
    this.w = 0,
    this.isBenefit = true,
  });

  KriteriaModel copyWith({
    String? name,
    num? w,
    bool? isBenefit,
  }) {
    return KriteriaModel(
      name: name ?? this.name,
      w: w ?? this.w,
      isBenefit: isBenefit ?? this.isBenefit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'w': w,
      'is_benefit': isBenefit,
    };
  }

  factory KriteriaModel.fromMap(Map<dynamic, dynamic> map) {
    return KriteriaModel(
      name: map['name'] ?? '',
      w: map['w'] ?? 0,
      isBenefit: map['is_benefit'] ?? false,
    );
  }

  @override
  List<Object> get props => [name, w, isBenefit];
}
