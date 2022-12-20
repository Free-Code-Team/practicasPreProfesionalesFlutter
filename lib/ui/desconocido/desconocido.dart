import 'package:flutter/material.dart';

class Desconocido extends StatelessWidget {

  const Desconocido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitado'),
      ),
      body: const Center(
        child: Text('Invitado'),
      )
    );
  }
}
