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

class PracticaHome extends StatefulWidget {
  const PracticaHome({Key? key}) : super(key: key);

  @override
  State<PracticaHome> createState() => _PracticaHomeState();
}

class _PracticaHomeState extends State<PracticaHome> {
  List<Solicitud> responseData = [];
  late String _value;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Practicas'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      drawer: const DrawerAdmin(),
      body: ListView(
        children: <Widget>[
          Card(
              elevation: 4,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.description),
                  onPressed: () => Navigator.pushNamed(
                      context, '/viewPdf'),
                ),
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    Icons.work,
                    size: 30.0,
                    color: estadoColor('3'),
                  ),
                ),
                title: Text(
                  'Juan Jhan Apaza',
                  style: const TextStyle(color: Colors.black54),
                ),
                subtitle: Text('Estudiante del 7 Ciclo'),
              )
          ),
          Card(
              elevation: 4,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.description),
                  onPressed: () => Navigator.pushNamed(
                      context, '/viewPdf'),
                ),
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    Icons.work,
                    size: 30.0,
                    color: estadoColor('2'),
                  ),
                ),
                title: Text(
                  'Tadeo Jones Lopez',
                  style: const TextStyle(color: Colors.black54),
                ),
                subtitle: Text('Estudiante del 6 Ciclo'),
              )
          ),
          Card(
              elevation: 4,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.description),
                  onPressed: () => Navigator.pushNamed(
                      context, '/viewPdf'),
                ),
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    Icons.work,
                    size: 30.0,
                    color: estadoColor('2'),
                  ),
                ),
                title: Text(
                  'Rodrigo Lopez Zapata',
                  style: const TextStyle(color: Colors.black54),
                ),
                subtitle: Text('Estudiante del 8 Ciclo'),
              )
          ),
          Card(
              elevation: 4,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.description),
                  onPressed: () => Navigator.pushNamed(
                      context, '/viewPdf'),
                ),
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    Icons.work,
                    size: 30.0,
                    color: estadoColor('0'),
                  ),
                ),
                title: Text(
                  'Maria Andrea Lipa',
                  style: const TextStyle(color: Colors.black54),
                ),
                subtitle: Text('Estudiante del 6 Ciclo'),
              )
          ),
          Card(
              elevation: 4,
              child: ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.description),
                  onPressed: () => Navigator.pushNamed(
                      context, '/viewPdf'),
                ),
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    Icons.work,
                    size: 30.0,
                    color: estadoColor('1'),
                  ),
                ),
                title: Text(
                  'Pedro Martínez Apaza',
                  style: const TextStyle(color: Colors.black54),
                ),
                subtitle: Text('Estudiante del 6 Ciclo'),
              )
          ),
        ],
      )
    );
  }
}
