import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';
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

    on<ObtenerEstadoEvent>((event, emit) async {
      Usuario? usuario = await _estudianteRepository.updateUsuario(event.uid!, event.estado);
      emit(MostrarEstadoState(usuario!.estado));
      print('estado de verdad ${usuario.estado}');
    });

    on<EstudianteSaveEvent>((event, emit) async {
      emit(EstudianteLoadingState());
      try {
        if (event.id != null) {
          print('Se encontró al id ${event.id}');
          Persona personaCopy = event.persona.copyWith(uidUsuario: event.uid);
          print(personaCopy.id);
          print(personaCopy.sexo);
          print(personaCopy.apellidos);
          print(personaCopy.nombres);
          print(personaCopy.direccion);
          Persona personaNew = await _personaRepository.actualizarPersona(personaCopy);
          Estudiante estudianteCopy = event.estudiante.copyWith(idPersona: personaNew.id);
          print('----------------------');
          print(estudianteCopy.id);
          print(estudianteCopy.semestre);
          print(estudianteCopy.codigo);
          print(estudianteCopy.idPersona);
          Estudiante estudianteNew = await _estudianteRepository.actualizarEstudiante(estudianteCopy);
          print(estudianteNew.id);

          Usuario? usuario = await _estudianteRepository.updateUsuario(event.uid!, '1');
          print('estado de verdad ${usuario!.estado}');
          emit(MostrarEstadoState(usuario!.estado));

          if (personaNew.id! <= 0) {
            emit(EstudianteFailedSaveState('Ocurrió un error al crear la <persona>'));
          } else if (estudianteNew.id! <= 0) {
            emit(EstudianteFailedSaveState('Ocurrió un error al crear la <estudiante>'));
          } else {
            emit(EstudianteSuccessSaveState(true, event.estudiante, event.persona, event.uid!));
          }
        } else {
          Persona personaCopy = event.persona.copyWith(uidUsuario: event.uid);
          Persona personaNew = await _personaRepository.addPersona(personaCopy);
          Estudiante estudianteCopy = event.estudiante.copyWith(idPersona: personaNew.id);
          Estudiante estudianteNew = await _estudianteRepository.addEstudiante(estudianteCopy);
          Usuario? usuario = await _estudianteRepository.updateUsuario(event.uid!, '1');
          print('estado de verdad ${usuario!.estado}');
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
  }
}
