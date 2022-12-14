import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/comp/app_bar_actions.dart';

class SolicitudHome extends StatefulWidget {
  const SolicitudHome({Key? key}) : super(key: key);

  @override
  State<SolicitudHome> createState() => SolicitudHomeState();
}

class SolicitudHomeState extends State<SolicitudHome> {
  List<Solicitud> responseData = [];

  @override
  void initState() {
    super.initState();
    listarResponseData();
  }

  List<Widget>? establecerEstado(estado) {
    if (estado == '0') {
      return const <Widget>[
        Icon(Icons.watch_later, color: Colors.orangeAccent, size: 20),
        SizedBox(width: 10),
        Text("Pendiente", style: TextStyle(color: Colors.white))
      ];
    } else if (estado == '1') {
      return const <Widget>[
        Icon(Icons.check, color: Colors.lightGreenAccent, size: 20),
        SizedBox(width: 10),
        Text("Realizado", style: TextStyle(color: Colors.white))
      ];
    } else if (estado == '2') {
      return const <Widget>[
        Icon(Icons.linear_scale, color: Colors.yellowAccent, size: 20),
        SizedBox(width: 10),
        Text("Cancelado", style: TextStyle(color: Colors.white))
      ];
    }
    return null;
  }

  void agregarData(data) {
    for (var item in data) {
      responseData.add(item);
    }
  }

  void handleClick(int item, int? id) {
    switch (item) {
      case 0:
        String? nombre = 'asdadas';
        Navigator.pushNamed(context, '/solicitud_edit', arguments: id);
        break;
      case 1:
        break;
    }
  }

  Widget listarResponseData() {
    return ListView(
      children: <Widget>[
        ...responseData.map(
          (e) => ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(
                '${e.idEstudiante.toString()} - ${e.idEmpresa.toString()}'),
            trailing: PopupMenuButton<int>(
              onSelected: (item) => handleClick(item, e.id),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                    value: 0, child: Text('Editar')),
                const PopupMenuItem<int>(value: 1, child: Text('Cambiar estado')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SolicitudBloc(RepositoryProvider.of<SolicitudRepository>(context))
            ..add(SolicitudListEvent()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/solicitud_add');
            }),
        appBar: AppBar(
          title: const Text('Solicitudes'),
          actions: appBarActions(context),
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
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: listarResponseData(),
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
