// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitud.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Solicitud _$SolicitudFromJson(Map<String, dynamic> json) {
  return Solicitud(
    id: json['id'] as int,
    representante: json['representante'] as String,
    estado: json['estado'] as String,
    idEstudiante: json['idEstudiante'] as int,
    idEmpresa: json['idEmpresa'] as int,
  );
}

Map<String, dynamic> _$SolicitudToJson(Solicitud instance) => <String, dynamic>{
      'id': instance.id,
      'representante': instance.representante,
      'estado': instance.estado,
      'idEstudiante': instance.idEstudiante,
      'idEmpresa': instance.idEmpresa,
    };
