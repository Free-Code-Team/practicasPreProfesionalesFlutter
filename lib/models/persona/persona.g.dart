// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persona.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Persona _$PersonaFromJson(Map<String, dynamic> json) {
  return Persona(
    id: json['id'] as int,
    nombres: json['nombres'] as String,
    apellidos: json['apellidos'] as String,
    dni: json['dni'] as String,
    telefono: json['telefono'] as String,
    direccion: json['direccion'] as String,
    uidUsuario: json['uidUsuario'] as String,
    sexo: json['sexo'] as String,
  );
}

Map<String, dynamic> _$PersonaToJson(Persona instance) => <String, dynamic>{
      'id': instance.id,
      'nombres': instance.nombres,
      'apellidos': instance.apellidos,
      'dni': instance.dni,
      'telefono': instance.telefono,
      'direccion': instance.direccion,
      'uidUsuario': instance.uidUsuario,
      'sexo': instance.sexo,
    };
