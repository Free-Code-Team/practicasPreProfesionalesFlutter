import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/bloc/auth/auth_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/ui/auth/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicas_pre_profesionales_flutter/ui/admin/drawer_admin.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Jhobany Ticona', style: (TextStyle(fontSize: 17)),),
                  accountEmail: Text('Jhobany@gmail.com', style: (TextStyle(fontSize: 15)),),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://media-exp1.licdn.com/dms/image/C4D03AQFQ4EsbEQOP9g/profile-displayphoto-shrink_200_200/0/1650294861122?e=1675900800&v=beta&t=WNC7VAtLDtJlf-dTeayN6zYP3EAQQsUBkSVmVwsNpIo',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                      'https://cloudraya.com/blog/wp-content/uploads/2021/10/Blog-Oct-3-1.jpg',
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
                Container(     
                  margin: const EdgeInsets.only(top: 150, bottom: 12, left: 12, right: 12),
                  width: double.infinity,
                  //color: Color.fromARGB(255, 0, 7, 109),
                  child: Image.network(
                        'https://upeu.edu.pe/wp-content/uploads/2022/03/04.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover
                      ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
