import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/usuario/usuario_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/usuarios/usuario_add.dart';

class UsuarioHome extends StatefulWidget {
  const UsuarioHome({Key? key}) : super(key: key);

  @override
  State<UsuarioHome> createState() => _UsuarioHomeState();
}

class _UsuarioHomeState extends State<UsuarioHome> {
  List<Usuario> responseData = [];
  late String _value;

  @override
  void initState() {
    super.initState();
    listarResponseData();
    _value = '1';
  }

  void agregarData(data) {
    for (var item in data) {
      responseData.add(item);
    }
  }

  Icon? rolEstado(rol) {
    if (rol != 'Admin') {
      return Icon(
        Icons.supervisor_account,
        color: Colors.blue[900],
        size: 30,
      );
    } else {
      return const Icon(
        Icons.manage_accounts,
        color: Colors.red,
        size: 30,
      );
    }
  }

  Icon? validarEstadoUsuario(String email) {
    if (email.isNotEmpty) {
      return Icon(
        Icons.check,
        color: Colors.green[900],
        size: 30,
      );
    } else {
      return const Icon(
        Icons.error,
        color: Colors.red,
        size: 30,
      );
    }
  }

  Widget listarResponseData() {
    return ListView(
      children: <Widget>[
        ...responseData.map(
          (e) => Card(
            elevation: 2,
            child: ListTile(
              onTap: () {
                if (e.rol == 'Admin') {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Ocurrió un problema'),
                      content: const Text(
                          'No se puede agregar información a usuarios administrador...'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Bien'),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Agregar Información'),
                      content: Text(
                          '¿Deseas agregar información al usuario ${e.name}?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsuarioAdd(
                                  uid: e.uid,
                                  usuario: e.name
                                ),
                              ),
                            );
                          },
                          child: const Text('Vamos'),
                        ),
                      ],
                    ),
                  );
                }
              },
              trailing: validarEstadoUsuario(e.email),
              leading:
                  SizedBox(height: double.infinity, child: rolEstado(e.rol)),
              title: Text(
                e.name,
                style: const TextStyle(color: Colors.black54),
              ),
              subtitle: Text(e.email),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SolicitudBloc(RepositoryProvider.of<SolicitudRepository>(context))
                ..add(SolicitudListEvent()),
        ),
        BlocProvider(
          create: (context) =>
              UsuarioBloc(RepositoryProvider.of<AuthRepository>(context))
                ..add(ListarUsuariosEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Usuarios'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        drawer: const DrawerAdmin(),
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
        body: BlocBuilder<UsuarioBloc, UsuarioState>(
          builder: (context, state) {
            if (state is CargandoUsuariosState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ListadoDeUsuariosState) {
              agregarData(state.usuarios);
              return listarResponseData();
            }
            if (state is ErrorListadoDeUsuariosState) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
