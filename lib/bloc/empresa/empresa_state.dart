part of 'empresa_bloc.dart';

@immutable
abstract class EmpresaState extends Equatable {}

class EmpresaInitialState extends EmpresaState {
  @override
  List<Object?> get props => [];
}

class EmpresaLoadingState extends EmpresaState {
  @override
  List<Object?> get props => [];
}

class EmpresaSuccessListState extends EmpresaState {
  final Response responseData;

  EmpresaSuccessListState(this.responseData);

  @override
  List<Object?> get props => [responseData];
}

class EmpresaSuccessSaveState extends EmpresaState {
  final Empresa empresa;

  EmpresaSuccessSaveState(this.empresa);

  @override
  List<Object?> get props => [empresa];
}

class EmpresaSuccessShowState extends EmpresaState {
  final Empresa empresa;

  EmpresaSuccessShowState(this.empresa);

  @override
  List<Object?> get props => [empresa];
}

class EmpresaFailedState extends EmpresaState {
  final String error;

  EmpresaFailedState(this.error);

  @override
  List<Object?> get props => [error];
}