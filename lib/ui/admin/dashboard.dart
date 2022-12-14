import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/ui/comp/app_bar_actions.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: appBarActions(context),
        ),
        drawer: const DrawerAdmin(),
        body: const Text('Hola dashboard'));
  }
}
