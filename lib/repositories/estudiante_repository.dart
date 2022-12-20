import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:practicas_pre_profesionales_flutter/models/estudiante/estudiante.dart';
import 'package:practicas_pre_profesionales_flutter/models/estudiante/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';

class EstudianteRepository {
  static const String _baseUrl = "http://10.0.2.2:8000/api";

  CollectionReference usuarios =
      FirebaseFirestore.instance.collection('usuarios');

  Future<Estudiante> getEstudiantePorId(int? id) async {
    var response = await http.get(Uri.parse("$_baseUrl/estudiantes/ver/$id"));
    var estudiante = Estudiante.fromJson(json.decode(response.body));
    print(response.body);
    if (response.body.isEmpty) {
      return estudiante;
    }
    return estudiante;
  }

  //intercambiar
  Future<Usuario?> updateUsuario(String uid, String estado) async {
      await usuarios
        .doc(uid)
        .update({'estado': estado})
        .then((value) => value)
        .catchError((error) => error);
      return _getUser(uid);
  }
  //intercambiar

  Future<Estudiante> getEstudianteById(int? id) async {
    var response = await http.get(Uri.parse("$_baseUrl/estudiantes/$id"));
    var jsonEstudiante = Estudiante.fromJson(json.decode(response.body));
    return jsonEstudiante;
  }

  Future<Estudiante> addEstudiante(Estudiante estudiante) async {
    var response = await http.post(
      Uri.parse("$_baseUrl/estudiantes"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        estudiante.toJson(),
      ),
    );
    var estudianteT = Estudiante.fromJson(json.decode(response.body));
    return estudianteT;
  }

  Future<Estudiante> actualizarEstudiante(Estudiante estudiante) async {
    var response = await http.put(
      Uri.parse("$_baseUrl/estudiantes/${estudiante.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(estudiante.toJson()),
    );
    print(response.body);
    var estudianteT = Estudiante.fromJson(json.decode(response.body));

    return estudianteT;
  }

  Future<String> _postDetailsToFirestore(
      String email, String rool, String name, String token) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = firebaseFirestore.collection('usuarios');
    ref.doc(token).set({'email': email, 'rol': rool, 'name': name});
    print('${token}token de revelacion');
    return token;
  }

  Future<Usuario?> _getUser(String uid) async {
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
          estado: documentSnapshot.get('estado'),
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

  Future<String> addUsuario(
      {required String email,
      required String password,
      required String rol,
      required String name}) async {
    String uid = '';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        uid = await _postDetailsToFirestore(email, rol, name, value.user!.uid);
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
    return uid;
  }
}
