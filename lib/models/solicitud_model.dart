import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SolicitudModel {
  int? id = 0, idEstudiante = 0, idEmpresa = 0;
  String representante, estado;

  SolicitudModel({this.id, required this.representante, required this.estado, this.idEstudiante, this.idEmpresa});

  factory SolicitudModel.fromJson(Map<String, dynamic> json) => SolicitudModel(
    representante: json["representante"],
    estado: json["estado"],
    idEstudiante: json["idEstudiante"],
    idEmpresa: json["idEmpresa"],
  );

  Map<String, dynamic> toJson(){
    return{
      'id':id,
      'representante': representante,
      'estado': estado,
      'idEstudiante': idEstudiante,
      'idEmpresa': idEmpresa,
    };
  }
}

@JsonSerializable()
class ResModel{

  String? estado;
  List<SolicitudModel?>? data;
  String? mensaje ;

  ResModel({
    this.estado,
    this.data,
    this.mensaje,
  });

  factory ResModel.fromJson(Map<String, dynamic> json) => ResModel(
    estado: json["estado"],
    data: (json['data'] as List).map((e) => e == null ? null : SolicitudModel.fromJson(e as Map<String, dynamic>)).toList(),
    mensaje: json["mensaje"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "estado": estado,
    "data": data,
    "mensaje": mensaje,
  };
}