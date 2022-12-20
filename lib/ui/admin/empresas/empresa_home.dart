import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/empresa/empresa_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/estudiante/estudiante_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/usuario/usuario_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/empresa.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/usuarios/usuario_add.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';

class EmpresaHome extends StatefulWidget {
  const EmpresaHome({Key? key}) : super(key: key);

  @override
  State<EmpresaHome> createState() => _EmpresaHomeState();
}

class _EmpresaHomeState extends State<EmpresaHome> {
  List<Empresa> responseData = [];
  late String _value;
  String estado = '';

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
    if (rol == '0') {
      return Icon(
        Icons.business,
        color: Colors.red[900],
        size: 30,
      );
    } else {
      return Icon(
        Icons.business,
        color: Colors.blue[900],
        size: 30,
      );
    }
  }

  Icon? convenioEmpresa(String estado) {
    if (estado == '0') {
      return Icon(
        Icons.circle,
        color: Colors.orange[900],
        size: 30,
      );
    } else {
      return Icon(
        Icons.circle,
        color: Colors.blue[900],
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
              onTap: () => Navigator.pushNamed(context, '/empresa_edit',
                  arguments: e.id),
              trailing: convenioEmpresa(e.convenio),
              leading:
                  SizedBox(height: double.infinity, child: rolEstado(e.estado)),
              title: Text(
                e.empresa,
                style: const TextStyle(color: Colors.black54),
              ),
              subtitle: Text(e.telefono),
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
              EmpresaBloc(RepositoryProvider.of<EmpresaRepository>(context))
                ..add(EmpresaListEvent()),
        ),
        BlocProvider(
          create: (context) =>
              UsuarioBloc(RepositoryProvider.of<AuthRepository>(context))
                ..add(ListarUsuariosEvent()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is DesautenticadoState) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Empresas'),
            centerTitle: true,
            backgroundColor: Colors.blue[900],
          ),
          drawer: const DrawerAdmin(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/empresa_add');
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
          body: BlocBuilder<EmpresaBloc, EmpresaState>(
            builder: (context, state) {
              if (state is EmpresaLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is EmpresaSuccessListState) {
                agregarData(state.responseData.data);
                return listarResponseData();
              }
              if (state is EmpresaFailedState) {
                return Center(
                  child: Text(state.error.toString()),
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
