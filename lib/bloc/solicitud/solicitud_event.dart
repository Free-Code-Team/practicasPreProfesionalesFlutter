part of 'solicitud_bloc.dart';

@immutable
abstract class SolicitudEvent extends Equatable {
  const SolicitudEvent();
}

class LoadSolicitudEvent extends SolicitudEvent {
  @override
  List<Object> get props => [];
}