part of 'solicitud_bloc.dart';

@immutable
abstract class SolicitudEvent extends Equatable {}

class SolicitudListEvent extends SolicitudEvent {
  @override
  List<Object?> get props => [];
}

class SolicitudAddEvent extends SolicitudEvent {
  final Solicitud solicitud;

  SolicitudAddEvent(this.solicitud);

  @override
  List<Object?> get props => [solicitud];
}

class SolicitudShowvent extends SolicitudEvent {
  final int id;

  SolicitudShowvent(this.id);

  @override
  List<Object?> get props => [id];
}