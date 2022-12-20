import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/empresa/empresa_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/estudiante/estudiante_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/usuario/usuario_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/empresa.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/usuarios/usuario_home.dart';

import '../../../models/solicitud/solicitud.dart';

class EmpresaAdd extends StatefulWidget {
  const EmpresaAdd({Key? key}) : super(key: key);

  @override
  State<EmpresaAdd> createState() => _EmpresaAddState();
}

class _EmpresaAddState extends State<EmpresaAdd> {
  final _formKey = GlobalKey<FormState>();
  //persona
  var tfEmpresa = TextEditingController();
  var tfRazonSocial = TextEditingController();
  var tfTelefono = TextEditingController();
  var tfConvenio = TextEditingController();
  var tfEstado = TextEditingController(text: '1');

  var convenio = 'n';

  var items = ['n', '1', '0'];
  //estudiante
  var tfCodigo = TextEditingController();
  // Initial Selected Value

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmpresaBloc(
              RepositoryProvider.of<EmpresaRepository>(context, listen: false)),
        ),
        BlocProvider(
          create: (context) => UsuarioBloc(
              RepositoryProvider.of<AuthRepository>(context, listen: false)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar empresa'),
          backgroundColor: Colors.blue[900],
        ),
        floatingActionButton: BlocBuilder<EmpresaBloc, EmpresaState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.save),
              onPressed: () {
                Empresa empresa = Empresa(
                    empresa: tfEmpresa.text,
                    estado: tfEstado.text,
                    razonSocial: tfRazonSocial.text,
                    telefono: tfTelefono.text,
                    convenio: convenio);
                BlocProvider.of<EmpresaBloc>(context)
                    .add(EmpresaSaveEvent(empresa, null));
                Navigator.pushNamed(context, '/empresa_home');
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        body: BlocBuilder<EmpresaBloc, EmpresaState>(
          builder: (context, state) {
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: tfEmpresa,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese la empresa',
                          labelText: 'Empresa',
                        ),
                      ),
                      TextFormField(
                        controller: tfRazonSocial,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese la razón social',
                          labelText: 'Razón social',
                        ),
                      ),
                      TextFormField(
                        controller: tfTelefono,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese el telefono',
                          labelText: 'Telefono',
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.transgender),
                          labelText: 'Convenio',
                        ),
                        isExpanded: true,
                        isDense: false,
                        value: convenio,
                        validator: (value) =>
                            value == 'n' ? "Ingrese su convenio" : null,
                        alignment: Alignment.topRight,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items == 'n'
                                ? 'Ingrese su convenio'
                                : items == '1'
                                    ? 'Si'
                                    : 'No'),
                          );
                        }).toList(),
                        onChanged: (String? newConvenio) {
                          convenio = newConvenio!;
                        },
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
