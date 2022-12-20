import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';

part 'estudiante_event.dart';
part 'estudiante_state.dart';

class EstudianteBloc extends Bloc<EstudianteEvent, EstudianteState> {
  final EstudianteRepository _estudianteRepository;
  final PersonaRepository _personaRepository;

  EstudianteBloc(this._estudianteRepository, this._personaRepository)
      : super(EstudianteInitialState()) {

    on<ObtenerPersonaPorUid>((event, emit) async {
      Persona persona = await _personaRepository.getPersonaPorUid(event.uid);
      if (persona.id == null) {
        emit(PersonaNoEncotradaState());
      } else {
        print(persona.id);
        Estudiante estudiante = await _estudianteRepository.getEstudiantePorId(persona.id);
        print(estudiante.semestre);
        emit(PersonaEncontradaState(persona, estudiante));
      }
    });

    on<EstudianteSaveEvent>((event, emit) async {
      emit(EstudianteLoadingState());
      try {
        if (event.id != null) {

        } else {
          Persona personaCopy = event.persona.copyWith(uidUsuario: event.uid);
          print(personaCopy.id);
          print(personaCopy.nombres);
          print(personaCopy.apellidos);
          print(personaCopy.direccion);
          print(personaCopy.sexo);
          print(personaCopy.telefono);
          Persona personaNew = await _personaRepository.addPersona(personaCopy);
          print(personaNew!.nombres);
          Estudiante estudianteCopy = event.estudiante.copyWith(idPersona: personaNew.id);
          Estudiante estudianteNew = await _estudianteRepository.addEstudiante(estudianteCopy);
          print(estudianteNew.semestre);
          if (personaNew.id! <= 0) {
            emit(EstudianteFailedSaveState('Ocurrió un error al crear la <persona>'));
          } else if (estudianteNew.id! <= 0) {
            emit(EstudianteFailedSaveState('Ocurrió un error al crear la <estudiante>'));
          } else {
            emit(EstudianteSuccessSaveState(true, event.estudiante, event.persona, event.uid!));
          }
        }
      } catch (e) {
        emit(EstudianteFailedState(e.toString()));
      }
    });
    /*on<SolicitudShowvent>((event, emit) async {
      try {
        final solicitud = await _solicitudRepository.getSolicitudById(event.id);
        emit(SolicitudSuccessShowState(solicitud));
      } catch (e) {
        emit(SolicitudFailedState(e.toString()));
      }
    });*/
  }
}
