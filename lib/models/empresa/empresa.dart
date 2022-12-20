import 'package:json_annotation/json_annotation.dart';
part 'empresa.g.dart';

@JsonSerializable()
class Empresa {
  final int? id;
  final String empresa;
  final String razonSocial;
  final String telefono;
  final String convenio;
  final String estado;

  Empresa copyWith({
    int? id,
    String? empresa,
    String? razonSocial,
    String? telefono,
    String? convenio,
    String? estado,
  }) =>
      Empresa(
          id: id ?? this.id,
          empresa: empresa ?? this.empresa,
          razonSocial: razonSocial ?? this.razonSocial,
          telefono: telefono ?? this.telefono,
          convenio: convenio ?? this.convenio,
          estado: estado ?? this.estado);

  Empresa(
      {this.id,
      required this.empresa,
      required this.razonSocial,
      required this.telefono,
      required this.convenio,
      required this.estado});

  factory Empresa.fromJson(Map<String, dynamic> json) =>
      _$EmpresaFromJson(json);
  Map<String, dynamic> toJson() => _$EmpresaToJson(this);
}
