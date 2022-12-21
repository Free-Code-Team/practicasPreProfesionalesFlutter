import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

import '../../../models/solicitud/solicitud.dart';

class SolicitudEdit extends StatelessWidget {
  SolicitudEdit({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String estado = 'n';
    final items = ['n', '0', '1', '2', '3'];
    final args = ModalRoute.of(context)!.settings.arguments;

    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false),
          RepositoryProvider.of<EmpresaRepository>(context, listen: false),
          RepositoryProvider.of<EstudianteRepository>(context, listen: false),
          RepositoryProvider.of<PersonaRepository>(context, listen: false))
        ..add(SolicitudShowvent(args as int)),
      child: BlocBuilder<SolicitudBloc, SolicitudState>(
        builder: (context, state) {
          if (state is SolicitudSuccessShowState) {
            estado = state.solicitud.estado;
            return Scaffold(
              appBar: AppBar(title: Text('${state.solicitud.estado}')),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.red,
                child: const Icon(Icons.save),
                onPressed: () {
                  Solicitud solicitud = Solicitud(
                      id: state.solicitud.id,
                      representante: state.solicitud.representante,
                      estado: state.solicitud.representante,
                      idEstudiante: state.solicitud.idEstudiante,
                      idEmpresa: state.solicitud.idEmpresa);
                  BlocProvider.of<SolicitudBloc>(context)
                      .add(SolicitudSaveEvent(solicitud, args as int));
                  Navigator.pushNamed(context, '/solicitud_home');
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
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.transgender),
                          labelText: 'Estado',
                        ),
                        isExpanded: true,
                        isDense: false,
                        value: estado,
                        validator: (value) =>
                            value == 'n' ? "Ingrese su estado" : null,
                        alignment: Alignment.topRight,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items == 'n'
                                ? 'Ingrese su estado'
                                : items == '0'
                                    ? 'Eliminado'
                                    : items == '1'
                                        ? 'Aceptado'
                                        : items == '2'
                                            ? 'En progreso'
                                            : 'Rechazado'),
                          );
                        }).toList(),
                        onChanged: (String? newGenero) {
                          estado = newGenero!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
