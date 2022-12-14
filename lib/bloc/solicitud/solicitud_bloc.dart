import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

part 'solicitud_event.dart';
part 'solicitud_state.dart';

class SolicitudBloc extends Bloc<SolicitudEvent, SolicitudState> {

  final SolicitudRepository _solicitudRepository;

  SolicitudBloc(this._solicitudRepository) : super(SolicitudLoadingState()) {
    on<SolicitudListEvent>((event, emit) async {
      emit(SolicitudLoadingState());
      try {
        final response = await _solicitudRepository.getAllSolicitudes();
        emit(SolicitudSuccessListState(response));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });

    on<SolicitudAddEvent>((event, emit) async {
      try {
        final response = await _solicitudRepository.addSolicitud(event.solicitud);
        emit(SolicitudSuccessAddState(response));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });

    on<SolicitudShowvent>((event, emit) async {
      try {
        final solicitud = await _solicitudRepository.getSolicitudById(event.id);
        print(solicitud);
        emit(SolicitudSuccessShowState(solicitud));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });
  }
}
