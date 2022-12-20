import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerAdmin extends StatelessWidget {

  const DrawerAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: BlocProvider(
        create: (context) => AuthBloc(RepositoryProvider.of<AuthRepository>(context, listen: false))..add(AutenticarEvent(user!.uid)),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is CargandoState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AutenticadoConExitoState) {
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      state.usuario.name, style: (const TextStyle(fontSize: 17)),),
                    accountEmail: Text(
                      state.usuario.email, style: (const TextStyle(fontSize: 15)),),
                    currentAccountPicture: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 70,
                        )
                    ),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/icons/fondo.jpg',
                            ),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                    ),
                    title: const Text('Dashboard'),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                    ),
                    title: const Text('Solicitudes'),
                    onTap: () {
                      Navigator.pushNamed(context, '/solicitud_home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.business,
                    ),
                    title: const Text('Empresas'),
                    onTap: () {
                      Navigator.pushNamed(context, '/empresa_home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.business,
                    ),
                    title: const Text('Usuarios'),
                    onTap: () {
                      Navigator.pushNamed(context, '/usuario_home');
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
