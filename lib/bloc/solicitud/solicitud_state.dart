part of 'solicitud_bloc.dart';

@immutable
abstract class SolicitudState extends Equatable {}

class SolicitudInitialState extends SolicitudState {
  @override
  List<Object?> get props => [];
}

class SolicitudLoadingState extends SolicitudState {
  @override
  List<Object?> get props => [];
}

class SolicitudSuccessListState extends SolicitudState {
  final Response responseData;

  SolicitudSuccessListState(this.responseData);

  @override
  List<Object?> get props => [responseData];
}

class SolicitudSuccessSaveState extends SolicitudState {
  final bool res;

  SolicitudSuccessSaveState(this.res);

  @override
  List<Object?> get props => [res];
}

class SolicitudSuccessShowState extends SolicitudState {
  final Solicitud solicitud;

  SolicitudSuccessShowState(this.solicitud);

  @override
  List<Object?> get props => [solicitud];
}

class SolicitudFailedState extends SolicitudState {
  final String error;

  SolicitudFailedState(this.error);

  @override
  List<Object?> get props => [error];
}

class EmpresaYEstudianteListadoCorrecto extends SolicitudState {
  final Estudiante estudiante;
  final Empresa empresa;
  final Persona persona;

  EmpresaYEstudianteListadoCorrecto(this.estudiante, this.empresa, this.persona);

  @override
  List<Object?> get props => [estudiante, empresa, persona];
}