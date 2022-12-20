import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/dashboard.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/estudiante/estudiante_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_add.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_edit.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_show.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/usuarios/usuario_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/ui/test/test_content.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => SolicitudRepository(),
        ),
        RepositoryProvider(
          create: (context) => EstudianteRepository(),
        ),
        RepositoryProvider(
          create: (context) => PersonaRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
            RepositoryProvider.of<AuthRepository>(context, listen: false)),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/dashboard': (context) => const Dashboard(),
            '/solicitud_home': (context) => const SolicitudHome(),
            '/solicitud_add': (context) => const SolicitudAdd(),
            '/solicitud_edit': (context) => SolicitudEdit(),
            '/solicitud_show': (context) => SolicitudShow(),
            '/estudiante_home': (context) => const EstudianteHome(),
            '/usuario_home': (context) => const UsuarioHome(),
            '/test': (context) => TestContent(),
          },
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Dashboard();
              }
              return const SignIn();
            },
          ),
        ),
      ),
    );
  }
}
