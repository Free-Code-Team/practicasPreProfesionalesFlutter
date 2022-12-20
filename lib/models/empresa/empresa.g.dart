// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Empresa _$EmpresaFromJson(Map<String, dynamic> json) {
  return Empresa(
    id: json['id'] as int,
    empresa: json['empresa'] as String,
    razonSocial: json['razonSocial'] as String,
    telefono: json['telefono'] as String,
    convenio: json['convenio'] as String,
    estado: json['estado'] as String,
  );
}

Map<String, dynamic> _$EmpresaToJson(Empresa instance) => <String, dynamic>{
      'id': instance.id,
      'empresa': instance.empresa,
      'razonSocial': instance.razonSocial,
      'telefono': instance.telefono,
      'convenio': instance.convenio,
      'estado': instance.estado,
    };
