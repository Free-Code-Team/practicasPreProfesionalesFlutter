import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
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
          RepositoryProvider.of<SolicitudRepository>(context, listen: false))
        ..add(SolicitudShowvent(args as int)),
      child: Scaffold(
        appBar: AppBar(title: Text('$args')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SolicitudBloc, SolicitudState>(
            builder: (context, state) {
              if (state is SolicitudSuccessShowState) {
                final tfRepresentante = TextEditingController(text: state.solicitud.representante);
                final tfEstado = TextEditingController(text: state.solicitud.estado);
                final tfIdEstudiante = TextEditingController(text: '${state.solicitud.idEstudiante}');
                final tfIdEmpresa = TextEditingController(text: '${state.solicitud.idEmpresa}');
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(state.solicitud.representante),

                      Text(state.solicitud.estado),

                      Text(state.solicitud.idEstudiante.toString()),

                      Text(state.solicitud.idEmpresa.toString()),

                      Container(
                          padding:
                          const EdgeInsets.only(left: 150.0, top: 40.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/solicitud_edit', arguments: state.solicitud.id);
                            },
                            color: Colors.lightGreenAccent,
                            child: const Text('Editar'),
                          )),
                      Container(
                          padding:
                          const EdgeInsets.only(left: 150.0, top: 40.0),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/solicitud_home');
                            },
                            color: Colors.lightGreenAccent,
                            child: const Text('Ver documento'),
                          )),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
