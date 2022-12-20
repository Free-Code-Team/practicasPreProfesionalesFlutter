import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';

class TestContent extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );
  TestContent({Key? key}) : super(key: key);

  Widget _buildRepresentante() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/imagen/man-icon.png'),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Empresa")
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Razon Social",)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Telefono"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Convenios"),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text("Estudiante:",
                        textAlign: TextAlign.center),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text("Nombre:",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 10),
                        child: Text("Ingrese Nombre"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Apellido:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Text("Ingrese Apellido"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("DNI:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Text("Ingrese DNI"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Telefono:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Text("Ingrese Telefono"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Direccion:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10),
                        child: Text("Ingrese Direccion"),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Solicitud"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Mensaje de confirmacion"),
                    content: Text("Desea Eliminar?"),
                    actions: [
                      FloatingActionButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop('Failure');
                        },
                      ),
                      FloatingActionButton(
                          child: const Text('ACCEPT'),
                          onPressed: () {
                            Navigator.of(context).pop('Success');
                          })
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[_buildRepresentante()],
                ),
              ))),
    );
  }
}
