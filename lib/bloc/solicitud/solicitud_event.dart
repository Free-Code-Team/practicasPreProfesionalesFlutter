part of 'solicitud_bloc.dart';

@immutable
abstract class SolicitudEvent extends Equatable {}

class SolicitudListEvent extends SolicitudEvent {
  @override
  List<Object?> get props => [];
}

class SolicitudSaveEvent extends SolicitudEvent {
  final Solicitud solicitud;
  final int? id;

  SolicitudSaveEvent(this.solicitud, this.id);

  @override
  List<Object?> get props => [solicitud];
}

class SolicitudShowvent extends SolicitudEvent {
  final int id;

  SolicitudShowvent(this.id);

  @override
  List<Object?> get props => [id];
}

class TraerEstudianteYEmpresaEvent extends SolicitudEvent {
  final int? idEmpresa;
  final int? idEstudiante;

  TraerEstudianteYEmpresaEvent(this.idEmpresa, this.idEstudiante);

  @override
  List<Object?> get props => [idEmpresa, idEstudiante];
}