import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  _postDetailsToFirestore(String email, String rool, String name, String uid) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('usuarios');
    ref.doc(uid).set({'email': email, 'rol': rool, 'name': name});
  }

  Future<Usuario?> getUser(String uid) async {
    Usuario? data;

    var kk = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data = Usuario(
          email: documentSnapshot.get('email'),
          name: documentSnapshot.get('name'),
          rol: documentSnapshot.get('rol'),
          uid: uid,
        );
      } else {
        data = null;
      }
    }).catchError((e) {
      data = null;
    });
    return data;
  }

  Future<List<Usuario>> getUsers() async {
    List<Usuario> usuarios = [];
    Usuario usuario;
    await FirebaseFirestore.instance.collection('usuarios').get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        usuario = Usuario(name: doc['name'], email: doc['email'], rol: doc['rol'], uid: doc.id);
        usuarios.add(usuario);
      }
    }
    ).catchError((e) => print(e));
    return usuarios;
  }

  Future<Usuario?> signUp(
      {required String email,
      required String password,
      required String rol,
      required String name}) async {
    Usuario? data;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await _postDetailsToFirestore(email, rol, name, value.user!.uid);
        data = await getUser(value.user!.uid);
        print(data!.email);
      }).catchError((e) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return data;
  }

  Future<Usuario?> signIn({
    required String email,
    required String password,
  }) async {
    Usuario? data;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        data = await getUser(value.user!.uid);
      }).catchError((e) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
    return data;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
