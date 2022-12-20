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
  String? gender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Hola')),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text("Ingrese el estado", style: TextStyle(
                                  fontSize: 18,
                                color: Colors.black54
                              ),),
                            ),
                            RadioListTile(
                              title: Text("Aceptado"),
                              value: "1",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Rechazado"),
                              value: "0",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("Cancelado"),
                              value: "0",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text("En proceso"),
                              value: "other",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding:
                              const EdgeInsets.only(left: 150.0, top: 40.0),
                          child: MaterialButton(
                            onPressed: () {
                              Solicitud solicitud = Solicitud(
                                  representante: tfRepresentante.text,
                                  estado: tfEstado.text,
                                  idEstudiante: int.parse(tfIdEstudiante.text),
                                  idEmpresa: int.parse(tfIdEmpresa.text));
                              BlocProvider.of<SolicitudBloc>(context)
                                  .add(SolicitudSaveEvent(solicitud, null));
                              Navigator.pushNamed(context, '/solicitud_home');
                            },
                            color: Colors.lightGreenAccent,
                            child: const Text('Submit'),
                          )),
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
