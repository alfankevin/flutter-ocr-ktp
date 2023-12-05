import 'package:equatable/equatable.dart';

class PenilaianModel extends Equatable {
  final String kriteriaId;
  final double nilai;
  final DateTime createdAt;

  const PenilaianModel({
    this.kriteriaId = '',
    this.nilai = 0,
    required this.createdAt,
  });

  factory PenilaianModel.fromJson(Map<String, Object?> json) {
    return PenilaianModel(
      kriteriaId: json['kriteria_id'] as String? ?? '',
      nilai: (json['nilai'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(json['created_at'] as String),
    );
  }
  factory PenilaianModel.initial(String kriteriaId, double nilai) {
    return PenilaianModel(
      kriteriaId: kriteriaId,
      nilai: nilai,
      createdAt: DateTime.now(),
    );
  }

  Map<String, Object?> toJson() => {
        'kriteria_id': kriteriaId,
        'nilai': nilai,
        'created_at': createdAt.toIso8601String(),
      };

  PenilaianModel copyWith({
    String? kriteriaId,
    double? nilai,
    DateTime? createdAt,
  }) {
    return PenilaianModel(
      kriteriaId: kriteriaId ?? this.kriteriaId,
      nilai: nilai ?? this.nilai,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [kriteriaId, nilai, createdAt];
}
