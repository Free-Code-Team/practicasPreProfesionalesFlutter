import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/dashboard.dart';
import 'package:practicas_pre_profesionales_flutter/ui/desconocido/desconocido.dart';
import 'package:practicas_pre_profesionales_flutter/ui/estudiante/estudianteUI.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _tfEmail = TextEditingController();
  final _tfName = TextEditingController();
  final _tfToken = TextEditingController();
  final _tfPassword = TextEditingController();

  final String tokenValue = 'a1b2c3';
  final String rolName = 'Estudiante';

  @override
  void dispose() {
    _tfEmail.dispose();
    _tfPassword.dispose();
    _tfName.dispose();
    _tfToken.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AutenticadoConExitoState) {
            if (state.usuario.rol == 'Estudiante') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const EstudianteUI()));
            } else if (state.usuario.rol == 'Admin') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Desconocido()));
            }
          }
          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState> (
        builder: (context, state) {
          if (state is CargandoState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DesautenticadoState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Registrarse",
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _tfToken,
                                decoration: const InputDecoration(
                                  hintText: "Token",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value != tokenValue
                                      ? 'Ingrese un usuario válido'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                controller: _tfName,
                                decoration: const InputDecoration(
                                  hintText: "Usuario",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 5
                                      ? 'Ingrese un usuario válido'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _tfEmail,
                                decoration: const InputDecoration(
                                  hintText: "Correo",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Ingrese un email válido'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: _tfPassword,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: "Contraseña",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? 'Ingrese una contraseña válida'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 1,
                                    minimumSize: const Size(0, 50),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    _createAccountWithEmailAndPassword(context);
                                  },
                                  child: const Text('Registrar',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text("¿Ya tienes una cuenta?"),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignIn()),
                                      );
                                    },
                                    child: const Text("Ingresar"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Ingrese como invitado (Google o Facebook)",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              _authenticateWithGoogle(context);
                            },
                            icon: Image.asset(
                              'assets/icons/google300.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _authenticateWithGoogle(context);
                            },
                            icon: Image.asset(
                              'assets/icons/facebook300.png',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        RegistrarEvent(
            email: _tfEmail.text,
            name: _tfName.text,
            password: _tfPassword.text,
            rol: rolName,
            token: _tfToken.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      AutenticarConGoogleEvent(),
    );
  }
}
