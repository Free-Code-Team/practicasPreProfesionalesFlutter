import 'package:json_annotation/json_annotation.dart';
part 'solicitud.g.dart';

@JsonSerializable()
class Solicitud {
  final int? id;
  final String representante;
  final String estado;
  final int idEstudiante;
  final int idEmpresa;

  Solicitud({this.id, required this.representante, required this.estado, required this.idEstudiante, required this.idEmpresa});

  factory Solicitud.fromJson(Map<String, dynamic> json) => _$SolicitudFromJson(json);
  Map<String, dynamic> toJson() => _$SolicitudToJson(this);
}