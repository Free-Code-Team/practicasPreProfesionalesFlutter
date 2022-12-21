import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/empresa/empresa_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';

class SolicitudHome extends StatefulWidget {
  const SolicitudHome({Key? key}) : super(key: key);

  @override
  State<SolicitudHome> createState() => SolicitudHomeState();
}

class SolicitudHomeState extends State<SolicitudHome> {
  List<Solicitud> responseData = [];
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

  Color? estadoColor(estado) {
    if (estado == '0') {
      return Colors.red;
    } else if (estado == '1') {
      return Colors.teal;
    } else if (estado == '2') {
      return Colors.deepOrange;
    } else {
      return Colors.pink;
    }
  }

  Widget listarResponseData() {
    return ListView(
      children: <Widget>[
        ...responseData.map(
          (e) => Card(
            elevation: 4,
            child: BlocProvider(
                create: (context) => SolicitudBloc(
                    RepositoryProvider.of<SolicitudRepository>(context,
                        listen: false),
                    RepositoryProvider.of<EmpresaRepository>(context,
                        listen: false),
                    RepositoryProvider.of<EstudianteRepository>(context,
                        listen: false),
                    RepositoryProvider.of<PersonaRepository>(context, listen: false)
                )
                  ..add(TraerEstudianteYEmpresaEvent(e.idEmpresa, e.idEstudiante)),
                child: BlocBuilder<SolicitudBloc, SolicitudState>(
                  builder: (context, state) {
                    if (state is SolicitudLoadingState) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is EmpresaYEstudianteListadoCorrecto) {
                      return ListTile(
                        onTap: () => Navigator.pushNamed(
                            context, '/solicitud_show',
                            arguments: e.id),
                        trailing: Text(
                          '${state.persona.nombres}',
                          style: const TextStyle(color: Colors.black54)),
                        leading: SizedBox(
                          height: double.infinity,
                          child: Icon(
                            Icons.description,
                            size: 30.0,
                            color: estadoColor(e.estado),
                          ),
                        ),
                        title: Text(
                          state.empresa.empresa,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        subtitle: Text(e.representante),
                      );
                    }
                    return Container();
                  },
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SolicitudBloc(
          RepositoryProvider.of<SolicitudRepository>(context, listen: false),
          RepositoryProvider.of<EmpresaRepository>(context, listen: false),
          RepositoryProvider.of<EstudianteRepository>(context, listen: false),
          RepositoryProvider.of<PersonaRepository>(context, listen: false)
      )
        ..add(SolicitudListEvent()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/solicitud_add');
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
        appBar: AppBar(
          title: const Text('Solicitudes'),
          centerTitle: true,
          backgroundColor: Colors.blue[900],
        ),
        drawer: const DrawerAdmin(),
        body: BlocBuilder<SolicitudBloc, SolicitudState>(
          builder: (context, state) {
            if (state is SolicitudLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SolicitudSuccessListState) {
              agregarData(state.responseData.data);
              List<String> listaDeOpciones = <String>["A", "B", "C", "D"];
              return listarResponseData();
            }

            if (state is SolicitudFailedState) {
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
