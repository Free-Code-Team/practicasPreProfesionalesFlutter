// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    estado: json['estado'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Persona.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    mensaje: json['mensaje'] as String,
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'estado': instance.estado,
      'data': instance.data,
      'mensaje': instance.mensaje,
    };
