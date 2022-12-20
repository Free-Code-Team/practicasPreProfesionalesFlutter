import 'package:json_annotation/json_annotation.dart';
part 'persona.g.dart';

@JsonSerializable()
class Persona {
  final int? id;
  final String nombres;
  final String apellidos;
  final String dni;
  final String telefono;
  final String direccion;
  final String? uidUsuario;
  final String sexo;

  Persona copyWith({
    int? id,
    String? nombres,
    String? apellidos,
    String? dni,
    String? telefono,
    String? direccion,
    String? uidUsuario,
    String? sexo,
  }) =>
      Persona(
        id: id ?? this.id,
        nombres: nombres ?? this.nombres,
        apellidos: apellidos ?? this.apellidos,
        dni: dni ?? this.dni,
        telefono: telefono ?? this.telefono,
        direccion: direccion ?? this.direccion,
        uidUsuario: uidUsuario ?? this.uidUsuario,
        sexo: sexo ?? this.sexo,
      );

  Persona(
      {this.id,
      required this.nombres,
      required this.apellidos,
      required this.dni,
      required this.telefono,
      required this.direccion, this.uidUsuario,
      required this.sexo});

  factory Persona.fromJson(Map<String, dynamic> json) =>
      _$PersonaFromJson(json);
  Map<String, dynamic> toJson() => _$PersonaToJson(this);
}
