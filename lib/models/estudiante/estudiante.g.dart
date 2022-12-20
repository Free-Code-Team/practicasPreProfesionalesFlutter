// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estudiante.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estudiante _$EstudianteFromJson(Map<String, dynamic> json) {
  return Estudiante(
    id: json['id'] as int,
    codigo: json['codigo'] as String,
    semestre: json['semestre'] as String,
    idPersona: json['idPersona'] as int,
  );
}

Map<String, dynamic> _$EstudianteToJson(Estudiante instance) =>
    <String, dynamic>{
      'id': instance.id,
      'codigo': instance.codigo,
      'semestre': instance.semestre,
      'idPersona': instance.idPersona,
    };
