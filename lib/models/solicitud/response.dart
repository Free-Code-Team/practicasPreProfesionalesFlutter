import 'package:json_annotation/json_annotation.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
part 'response.g.dart';

@JsonSerializable()
class Response {
  final String estado;
  final List<Solicitud?>? data;
  final String mensaje;

  Response({required this.estado, required this.data, required this.mensaje});

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}