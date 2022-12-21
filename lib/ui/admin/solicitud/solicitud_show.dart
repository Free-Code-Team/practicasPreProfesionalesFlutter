import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

import '../../../models/solicitud/solicitud.dart';

class SolicitudShow extends StatelessWidget {
  SolicitudShow({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false),
          RepositoryProvider.of<EmpresaRepository>(context, listen: false),
          RepositoryProvider.of<EstudianteRepository>(context, listen: false),
          RepositoryProvider.of<PersonaRepository>(context, listen: false))
        ..add(SolicitudShowvent(args as int)),
      child: BlocBuilder<SolicitudBloc, SolicitudState>(
        builder: (context, state1) {
          if (state1 is SolicitudSuccessShowState) {
            return BlocProvider(
              create: (context) => SolicitudBloc(
                  RepositoryProvider.of<SolicitudRepository>(context,
                      listen: false),
                  RepositoryProvider.of<EmpresaRepository>(context,
                      listen: false),
                  RepositoryProvider.of<EstudianteRepository>(context,
                      listen: false),
                  RepositoryProvider.of<PersonaRepository>(context,
                      listen: false))
                ..add(TraerEstudianteYEmpresaEvent(
                    state1.solicitud.idEmpresa, state1.solicitud.idEstudiante)),
              child: BlocBuilder<SolicitudBloc, SolicitudState>(
                builder: (context, state) {
                  if (state is SolicitudLoadingState) {
                    return Scaffold(
                        appBar: AppBar(
                            backgroundColor: Colors.blue[900],
                            title: const Text('Cargando...')),
                        body: const Center(child: CircularProgressIndicator()));
                  }
                  if (state is EmpresaYEstudianteListadoCorrecto) {
                    return Scaffold(
                      appBar: AppBar(
                          backgroundColor: Colors.blue[900],
                          title: Text(
                              'Solicitud para la ${state.empresa.empresa}')),
                      floatingActionButton: state1.solicitud.estado == '0' ?
                       null : FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/solicitud_edit',
                              arguments: args as int);
                        },
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: BottomAppBar(
                        color: Colors.blue[900],
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.account_circle),
                                color: Colors.white,
                                onPressed: () {}),
                            const Spacer(),
                            IconButton(
                                icon: const Icon(Icons.logout),
                                color: Colors.white,
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(DesautenticarEvent());
                                }),
                          ],
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Nombres: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.persona.nombres}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Apellidos: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.persona.apellidos}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Telefono: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.persona.telefono}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Dirección: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.persona.direccion}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'DNI: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.persona.dni}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Semestre: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.estudiante.semestre} Ciclo',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Codigo universitario: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.estudiante.codigo}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Empresa: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.empresa.empresa}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Telefono: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.empresa.telefono}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Razón social: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.empresa.razonSocial}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Estado: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.empresa.estado == '0' ? "Inactivo" : "Activo"}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Convenio: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state.empresa.convenio == '0' ? "no" : "si"}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: Card(
                                elevation: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Estado de la solicitud: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state1.solicitud.estado == "3" ? "Rechazado" : state1.solicitud.estado == '1' ? "Aceptado" : state1.solicitud.estado == '2' ? "En progreso" : "Eliminado"}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Representate: ',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            '${state1.solicitud.representante}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
