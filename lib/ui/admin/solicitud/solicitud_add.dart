import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';

import '../../../models/solicitud/solicitud.dart';

class SolicitudAdd extends StatefulWidget {
  const SolicitudAdd({Key? key}) : super(key: key);

  @override
  State<SolicitudAdd> createState() => _SolicitudAddState();
}

class _SolicitudAddState extends State<SolicitudAdd> {
  final _formKey = GlobalKey<FormState>();
  final tfRepresentante = TextEditingController();
  final tfEstado = TextEditingController();
  final tfIdEstudiante = TextEditingController();
  final tfIdEmpresa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Hola')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SolicitudBloc, SolicitudState>(
            builder: (context, state) {
              return Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: tfRepresentante,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Ingrese al representante',
                        labelText: 'Representante',
                      ),
                    ),
                    TextFormField(
                      controller: tfEstado,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Ingrese el estado',
                        labelText: 'Estado',
                      ),
                    ),
                    TextFormField(
                      controller: tfIdEstudiante,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        hintText: 'Ingrese al estudiante (ID)',
                        labelText: 'Estudiante',
                      ),
                    ),
                    TextFormField(
                      controller: tfIdEmpresa,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        hintText: 'Ingrese la empresa (ID)',
                        labelText: 'Empresa',
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                        child: MaterialButton(
                          onPressed: () {
                            Solicitud solicitud = Solicitud(
                                representante: tfRepresentante.text,
                                estado: tfEstado.text,
                                idEstudiante: int.parse(tfIdEstudiante.text),
                                idEmpresa: int.parse(tfIdEmpresa.text));
                            BlocProvider.of<SolicitudBloc>(context)
                                .add(SolicitudAddEvent(solicitud));
                            Navigator.pushNamed(context, '/solicitud_home');
                          },
                          color: Colors.lightGreenAccent,
                          child: const Text('Submit'),
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
