import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';



List<Widget> appBarActions(BuildContext context) {

  void handleClick(int item) {
    switch (item) {
      case 0:
        context.read<AuthBloc>().add(SignOutRequested());
        break;
      case 1:
        break;
    }
  }

  return [
    PopupMenuButton<int>(
      onSelected: (item) => handleClick(item),
      itemBuilder: (context) => [
        const PopupMenuItem<int>(value: 0, child: Text('Cerrar sesión')),
        const PopupMenuItem<int>(value: 1, child: Text('Usuario')),
      ],
    ),
  ];
}