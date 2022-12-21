import 'package:flutter/services.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/empresa_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/estudiante_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/persona_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/test/screens/principales/viewPdf.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/dashboard.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/empresas/empresa_add.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/empresas/empresa_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/estudiante/estudiante_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/practicas/practica_home.dart';
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
import 'package:practicas_pre_profesionales_flutter/ui/estudiante/estudianteUI.dart';
import 'package:practicas_pre_profesionales_flutter/ui/estudiante/solicitud/solicitud_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/test/test_content.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        RepositoryProvider(
          create: (context) => EmpresaRepository(),
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
            '/practica_home': (context) => const PracticaHome(),
            '/viewPdf': (context) => const ViewPdf(),
            '/usuario_home': (context) => const UsuarioHome(),
            '/empresa_home': (context) => const EmpresaHome(),
            '/empresa_add': (context) => const EmpresaAdd(),
            '/hogar_estudiante': (context) => const EstudianteUI(),
            '/mis_practicas_home': (context) => const EstudianteUI(),
            '/mis_solicitudes_home': (context) => const SolicitudHomeEstudiante(),
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
