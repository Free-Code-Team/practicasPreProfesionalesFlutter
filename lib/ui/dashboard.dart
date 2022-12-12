import 'dart:ffi';

import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/solicitud/solicitud_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/ui/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(onPressed: () => context.read<AuthBloc>().add(SignOutRequested()), icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                // Navigate to the sign in screen when the user Signs Out
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignIn()),
                  (route) => false,
                );
              }
            },
          )
        ],
        child: BlocBuilder<SolicitudBloc, SolicitudState>(
          builder: (context, state) {
            if (state is SolicitudLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SolicitudLoadedState) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Email: \n ${user.email}',
                            style: const TextStyle(fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                          user.photoURL != null
                              ? Image.network("${user.photoURL}")
                              : Container(),
                          user.displayName != null
                              ? Text("${user.displayName}")
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ExpansionTile(
                      title: Text(
                        state.solicitudes.mensaje!,
                        textAlign: TextAlign.center,
                      ),
                      children: [
                        Padding(padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                ...state.solicitudes.data!.map((s) => Text(s!.representante)),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              );
            }
            if (state is SolicitudErrorState) {
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
