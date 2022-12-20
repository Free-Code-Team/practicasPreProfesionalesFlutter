part of 'estudiante_bloc.dart';

@immutable
abstract class EstudianteEvent extends Equatable {}

class EstudianteSaveEvent extends EstudianteEvent {
  final Estudiante estudiante;
  final Persona persona;
  final String? uid;
  final int? id;

  EstudianteSaveEvent(this.estudiante, this.persona, this.uid, this.id);

  @override
  List<Object?> get props => [estudiante, persona, uid, id];
}

class EstudianteShowEvent extends EstudianteEvent {
  final int id;

  EstudianteShowEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ObtenerPersonaPorUid extends EstudianteEvent {
  final String uid;

  ObtenerPersonaPorUid(this.uid);

  @override
  List<Object?> get props => [uid];
}
