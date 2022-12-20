import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/estudiante/estudiante_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/usuario/usuario_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/usuarios/usuario_home.dart';

import '../../../models/solicitud/solicitud.dart';

class UsuarioAdd extends StatefulWidget {
  final String uid;
  final String usuario;
  const UsuarioAdd({Key? key, required this.uid, required this.usuario})
      : super(key: key);

  @override
  State<UsuarioAdd> createState() => _UsuarioAddState();
}

class _UsuarioAddState extends State<UsuarioAdd> {
  final _formKey = GlobalKey<FormState>();
  //persona
  var tfNombres = TextEditingController();
  var tfApellidos = TextEditingController();
  var tfDni = TextEditingController();
  var tfTelefono = TextEditingController();
  var tfDireccion = TextEditingController();
  var genero = 'n';
  var semestre = 'Ingrese su semestre';
  // List of items in our dropdown menu
  var items = ['Ingrese su semestre', '6', '7', '8', '9', '10'];

  var items2 = [
    'n',
    '1',
    '0',
  ];
  //estudiante
  var tfCodigo = TextEditingController();
  // Initial Selected Value

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EstudianteBloc(
              RepositoryProvider.of<EstudianteRepository>(context,
                  listen: false),
              RepositoryProvider.of<PersonaRepository>(context, listen: false))
            ..add(ObtenerPersonaPorUid(widget.uid)),
        ),
        BlocProvider(
          create: (context) => UsuarioBloc(
              RepositoryProvider.of<AuthRepository>(context, listen: false)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.usuario),
          backgroundColor: Colors.blue[900],
        ),
        floatingActionButton: BlocBuilder<EstudianteBloc, EstudianteState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.save),
              onPressed: () async {
                if (state is PersonaEncontradaState) {
                  if (_formKey.currentState!.validate()) {
                    Persona persona = Persona(
                        id: state.persona!.id,
                        nombres: tfNombres.text,
                        apellidos: tfApellidos.text,
                        dni: tfDni.text,
                        direccion: tfDireccion.text,
                        telefono: tfTelefono.text,
                        sexo: genero);
                    Estudiante estudiante = Estudiante(
                        id: state.estudiante!.id,
                        codigo: tfCodigo.text,
                        semestre: semestre);
                    BlocProvider.of<EstudianteBloc>(context).add(
                        EstudianteSaveEvent(estudiante, persona, widget.uid,
                            state.persona!.id));
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/usuario_home', (Route<dynamic> route) => false);
                  }
                }
                if (state is PersonaNoEncotradaState) {
                  Persona persona = Persona(
                      nombres: tfNombres.text,
                      apellidos: tfApellidos.text,
                      dni: tfDni.text,
                      direccion: tfDireccion.text,
                      telefono: tfTelefono.text,
                      sexo: genero);
                  Estudiante estudiante = Estudiante(
                    codigo: tfCodigo.text,
                    semestre: semestre,
                  );
                  BlocProvider.of<EstudianteBloc>(context).add(
                      EstudianteSaveEvent(
                          estudiante, persona, widget.uid, null));
                  Navigator.pop(context);
                }
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
        body: BlocBuilder<EstudianteBloc, EstudianteState>(
          builder: (context, state) {
            if (state is PersonaEncontradaState) {
              //persona
              tfNombres = TextEditingController(text: state.persona!.nombres);
              tfApellidos =
                  TextEditingController(text: state.persona!.apellidos);
              tfDni = TextEditingController(text: state.persona!.dni);
              tfTelefono = TextEditingController(text: state.persona!.telefono);
              tfDireccion =
                  TextEditingController(text: state.persona!.direccion);
              genero = state.persona!.sexo;

              print(genero);
              //estudiante
              tfCodigo = TextEditingController(text: state.estudiante!.codigo);
              semestre = state.estudiante!.semestre;
            }
            if (state is PersonaNoEncotradaState) {}
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: tfNombres,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese sus nombres',
                          labelText: 'Nombres',
                        ),
                      ),
                      TextFormField(
                        controller: tfApellidos,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese sus apellidos',
                          labelText: 'Apellidos',
                        ),
                      ),
                      TextFormField(
                        controller: tfDni,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Ingrese su DNI',
                          labelText: 'DNI',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null && value.length != 8
                              ? "Ingrese un DNI válido"
                              : null;
                        },
                      ),
                      TextFormField(
                        controller: tfDireccion,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.directions),
                          hintText: 'Ingrese su dirección',
                          labelText: 'Dirección',
                        ),
                      ),
                      TextFormField(
                        controller: tfTelefono,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.directions),
                          hintText: 'Ingrese su telefono',
                          labelText: 'Telefono',
                        ),
                      ),
                      TextFormField(
                        controller: tfCodigo,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.key),
                          hintText: 'Ingrese su código',
                          labelText: 'Código',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null && value.length != 9
                              ? "Ingrese un código válido"
                              : null;
                        },
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.local_library),
                          labelText: 'Semestre',
                        ),
                        validator: (value) => value == "Ingrese su semestre"
                            ? "Ingrese su semestre"
                            : null,
                        isExpanded: true,
                        isDense: false,
                        value: semestre,
                        alignment: Alignment.topRight,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newSemestre) {
                          semestre = newSemestre!;
                        },
                      ),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.transgender),
                          labelText: 'Género',
                        ),
                        isExpanded: true,
                        isDense: false,
                        value: genero,
                        validator: (value) =>
                            value == 'n' ? "Ingrese su genero" : null,
                        alignment: Alignment.topRight,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items2.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items == 'n'
                                ? 'Ingrese su género'
                                : items == '1'
                                    ? 'Masculino'
                                    : 'Femenino'),
                          );
                        }).toList(),
                        onChanged: (String? newGenero) {
                          genero = newGenero!;
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
