import 'package:equatable/equatable.dart';

class DataModel extends Equatable {
  final String name;
  final String deskripsi;
  final String color;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const DataModel({
    required this.name,
    required this.deskripsi,
    required this.color,
    required this.createdAt,
    this.updatedAt,
  });

  DataModel copyWith({
    String? name,
    String? deskripsi,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DataModel(
      name: name ?? this.name,
      deskripsi: deskripsi ?? this.deskripsi,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'deskripsi': deskripsi,
      'color': color,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String() ?? '',
    };
  }

  factory DataModel.fromMap(Map<Object?, dynamic> map) {
    return DataModel(
      name: map['name'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      color: map['color'] ?? '',
      createdAt: map['created_at'] == null
          ? DateTime.parse(map['created_at'] ?? '')
          : DateTime.now(),
      updatedAt: map['updated_at'] == null
          ? null
          : (map['updated_at']).toString().isNotEmpty
              ? DateTime.parse(map['updated_at'] as String)
              : null,
    );
  }

  factory DataModel.initial(
    String name,
    String deskripsi,
    String color,
  ) =>
      DataModel(
        color: color,
        name: name,
        deskripsi: deskripsi,
        createdAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [name, deskripsi, color, createdAt, updatedAt];
}
