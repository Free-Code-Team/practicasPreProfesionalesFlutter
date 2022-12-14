import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/solicitud_repository.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/dashboard.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_add.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_edit.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/solicitud/solicitud_home.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: BlocProvider(
        create: (context) =>
            AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/dashboard': (context) => const Dashboard(),
            '/solicitud_home': (context) => const SolicitudHome(),
            '/solicitud_add': (context) => const SolicitudAdd(),
            '/solicitud_edit': (context) => SolicitudEdit(),
          },
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Dashboard();
                }
                return const SignIn();
              }),
        ),
      ),
    );
  }
}
