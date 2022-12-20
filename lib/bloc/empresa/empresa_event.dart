part of 'empresa_bloc.dart';

@immutable
abstract class EmpresaEvent extends Equatable {}

class EmpresaListEvent extends EmpresaEvent {
  @override
  List<Object?> get props => [];
}

class EmpresaSaveEvent extends EmpresaEvent {
  final Empresa empresa;
  final int? id;

  EmpresaSaveEvent(this.empresa, this.id);

  @override
  List<Object?> get props => [empresa];
}

class EmpresaShowEvent extends EmpresaEvent {
  final int id;

  EmpresaShowEvent(this.id);

  @override
  List<Object?> get props => [id];
}