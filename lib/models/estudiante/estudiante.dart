import 'package:json_annotation/json_annotation.dart';
part 'estudiante.g.dart';

@JsonSerializable()
class Estudiante {
  final int? id;
  final String codigo;
  final String semestre;
  final int? idPersona;

  Estudiante copyWith({
    int? id,
    String? codigo,
    String? semestre,
    int? idPersona,
  }) =>
      Estudiante(
        id: id ?? this.id,
        codigo: codigo ?? this.codigo,
        semestre: semestre ?? this.semestre,
        idPersona: idPersona ?? this.idPersona
      );

  Estudiante({this.id, required this.codigo, required this.semestre, this.idPersona});

  factory Estudiante.fromJson(Map<String, dynamic> json) => _$EstudianteFromJson(json);
  Map<String, dynamic> toJson() => _$EstudianteToJson(this);
}