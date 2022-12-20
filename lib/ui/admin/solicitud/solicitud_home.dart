import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';
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

/*
DropdownSearch(
                mode: Mode.DIALOG,
                items: ["Brazil", "France", "Tunisia", "Canada", "sadasd", "asdsad", "sdsad", "asdsad", "sdasd", "saww2"],
                dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                onChanged: print,
                selectedItem: "Tunisia",
                validator: (String? item) {
                  if (item == null) return "Required field";
                  else if (item == "Brazil") return "Invalid item";
                  else return null;
                },
                : 150,
              );
 */

/*

Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Rechazados",
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              color: Colors.teal,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Aceptados",
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "3",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "En proceso",
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "4",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Eliminados",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
 */
