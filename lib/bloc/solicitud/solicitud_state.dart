part of 'solicitud_bloc.dart';

@immutable
abstract class SolicitudState extends Equatable {}

class SolicitudLoadingState extends SolicitudState {
  @override
  List<Object?> get props => [];
}

class SolicitudLoadedState extends SolicitudState {
  final ResModel solicitudes;

  SolicitudLoadedState(this.solicitudes);

  @override
  List<Object?> get props => [solicitudes];
}

class SolicitudErrorState extends SolicitudState {
  final String error;

  SolicitudErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
