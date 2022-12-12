import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud_model.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

part 'solicitud_event.dart';
part 'solicitud_state.dart';

class SolicitudBloc extends Bloc<SolicitudEvent, SolicitudState> {
  final SolicitudRepository _solicitudRepository;

  SolicitudBloc(this._solicitudRepository) : super(SolicitudLoadingState()) {
    on<LoadSolicitudEvent>((event, emit) async {
      emit(SolicitudLoadingState());
      try {
        final solicitudes = await _solicitudRepository.getAllSolicitudes();
        emit(SolicitudLoadedState(solicitudes));
      } catch (e) {
        emit(SolicitudErrorState(e.toString()));
      }
    });
  }
}