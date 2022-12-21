import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/empresa.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

part 'solicitud_event.dart';
part 'solicitud_state.dart';

class SolicitudBloc extends Bloc<SolicitudEvent, SolicitudState> {

  final SolicitudRepository _solicitudRepository;
  final EmpresaRepository _empresaRepository;
  final EstudianteRepository _estudianteRepository;
  final PersonaRepository _personaRepository;

  SolicitudBloc(this._solicitudRepository, this._empresaRepository, this._estudianteRepository, this._personaRepository) : super(SolicitudLoadingState()) {
    on<SolicitudListEvent>((event, emit) async {
      emit(SolicitudLoadingState());
      try {
        final response = await _solicitudRepository.getAllSolicitudes();
        emit(SolicitudSuccessListState(response));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });

    on<SolicitudSaveEvent>((event, emit) async {
      try {
        if (event.id != null) {
          final response = await _solicitudRepository.updateSolicitud(event.solicitud);
          emit(SolicitudSuccessSaveState(response));
        } else {
          final response = await _solicitudRepository.addSolicitud(event.solicitud);
          emit(SolicitudSuccessSaveState(response));
        }
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });

    on<SolicitudShowvent>((event, emit) async {
      try {
        final solicitud = await _solicitudRepository.getSolicitudById(event.id);
        emit(SolicitudSuccessShowState(solicitud));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });

    on<TraerEstudianteYEmpresaEvent>((event, emit) async {
      emit(SolicitudLoadingState());
      try {
        final empresa = await _empresaRepository.getEmpresaById(event.idEmpresa!);
        final estudiante = await _estudianteRepository.getEstudianteById(event.idEstudiante);
        final persona = await _personaRepository.getPersonaById(estudiante.idPersona!);
        emit(EmpresaYEstudianteListadoCorrecto(estudiante, empresa, persona));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });
  }
}
