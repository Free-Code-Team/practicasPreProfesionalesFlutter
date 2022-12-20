import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/empresa.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/response.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';

part 'empresa_event.dart';
part 'empresa_state.dart';

class EmpresaBloc extends Bloc<EmpresaEvent, EmpresaState> {
  final EmpresaRepository _empresaRepository;

  EmpresaBloc(this._empresaRepository) : super(EmpresaLoadingState()) {
    on<EmpresaListEvent>((event, emit) async {
      emit(EmpresaLoadingState());
      try {
        final response = await _empresaRepository.getAllEmpresas();
        emit(EmpresaSuccessListState(response));
      } catch (e) {
        emit(EmpresaFailedState(e.toString()));
      }
    });

    on<EmpresaSaveEvent>((event, emit) async {
      try {
        if (event.id != null) {
          Empresa response = await _empresaRepository.updateEmpresa(event.empresa);
          print(response);
          emit(EmpresaSuccessSaveState(response));
        } else {
          Empresa response = await _empresaRepository.addEmpresa(event.empresa);
          print(response);
          emit(EmpresaSuccessSaveState(response));
        }
      } catch (e) {
        emit(EmpresaFailedState(e.toString()));
      }
    });

    on<EmpresaShowEvent>((event, emit) async {
      try {
        final empresa = await _empresaRepository.getEmpresaById(event.id);
        emit(EmpresaSuccessShowState(empresa));
      } catch (e) {
        emit(EmpresaFailedState(e.toString()));
      }
    });
  }
}
