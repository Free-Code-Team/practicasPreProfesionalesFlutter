part of 'estudiante_bloc.dart';

@immutable
abstract class EstudianteState extends Equatable {}

class EstudianteInitialState extends EstudianteState {
  @override
  List<Object?> get props => [];
}

class EstudianteLoadingState extends EstudianteState {
  @override
  List<Object?> get props => [];
}

class EstudianteSuccessListState extends EstudianteState {
  final Response responseData;

  EstudianteSuccessListState(this.responseData);

  @override
  List<Object?> get props => [responseData];
}

class EstudianteSuccessSaveState extends EstudianteState {
  final bool res;
  final Persona persona;
  final Estudiante estudiante;
  final String uid;

  EstudianteSuccessSaveState(this.res, this.estudiante, this.persona, this.uid);

  @override
  List<Object?> get props => [res, persona, estudiante, uid];
}

class EstudianteFailedSaveState extends EstudianteState {
  final String error;

  EstudianteFailedSaveState(this.error);

  @override
  List<Object?> get props => [error];
}

class EstudianteSuccessShowState extends EstudianteState {
  final Estudiante estudiante;

  EstudianteSuccessShowState(this.estudiante);

  @override
  List<Object?> get props => [estudiante];
}

class EstudianteFailedState extends EstudianteState {
  final String error;

  EstudianteFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class PersonaEncontradaState extends EstudianteState {
  final Persona? persona;
  final Estudiante? estudiante;

  PersonaEncontradaState(this.persona, this.estudiante);

  @override
  List<Object?> get props => [persona, estudiante];
}

class PersonaNoEncotradaState extends EstudianteState {
  @override
  List<Object?> get props => [];
}

class MostrarEstadoState extends EstudianteState {
  final String estado;

  MostrarEstadoState(this.estado);

  @override
  List<Object?> get props => [estado];
}