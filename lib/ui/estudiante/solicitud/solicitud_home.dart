import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/estudiante/drawer_estudiante.dart';

class SolicitudHomeEstudiante extends StatefulWidget {
  const SolicitudHomeEstudiante({Key? key}) : super(key: key);

  @override
  State<SolicitudHomeEstudiante> createState() =>
      _SolicitudHomeEstudianteState();
}

class _SolicitudHomeEstudianteState extends State<SolicitudHomeEstudiante> {
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
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, '/solicitud_show',
                  arguments: e.id),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Text(e.idEstudiante.toString()),
                    onPressed: () {},
                  ),
                ],
              ),
              leading: SizedBox(
                height: double.infinity,
                child: Icon(
                  Icons.description,
                  size: 30.0,
                  color: estadoColor(e.estado),
                ),
              ),
              title: Text(
                e.idEmpresa.toString(),
                style: const TextStyle(color: Colors.black54),
              ),
              subtitle: Text(e.representante),
            ),
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
          RepositoryProvider.of<PersonaRepository>(context, listen: false))
        ..add(SolicitudListEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes'),
        ),
        drawer: const DrawerEstudiante(),
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
              return Center(
                child: Text('listado de mis solicitudes'),
              );
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
