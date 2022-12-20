import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/empresa/empresa_bloc.dart';
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
  String? gender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar empresa'),
          backgroundColor: Colors.blue[900],
        ),
        floatingActionButton: BlocBuilder<SolicitudBloc, SolicitudState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.save),
              onPressed: () {
                Solicitud solicitud = Solicitud(
                    representante: tfRepresentante.text,
                    estado: tfEstado.text,
                    idEstudiante: int.parse(tfIdEstudiante.text),
                    idEmpresa: int.parse(tfIdEmpresa.text));
                BlocProvider.of<SolicitudBloc>(context)
                    .add(SolicitudSaveEvent(solicitud, null));
                Navigator.pushNamed(context, '/empresa_home');
              },
            );
          },
        ),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocBuilder<SolicitudBloc, SolicitudState>(
          builder: (context, state) {
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
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
                        controller: tfIdEmpresa,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: 'Ingrese la empresa (ID)',
                          labelText: 'Empresa',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
