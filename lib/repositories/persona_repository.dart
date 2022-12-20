import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicas_pre_profesionales_flutter/models/persona/persona.dart';
import 'package:practicas_pre_profesionales_flutter/models/persona/response.dart';

class PersonaRepository {
  static const String _baseUrl = "http://10.0.2.2:8000/api";

  Future<Persona> getPersonaById(int id) async {
    var response = await http.get(Uri.parse("$_baseUrl/personas/$id"));
    var jsonPersona = Persona.fromJson(json.decode(response.body));
    return jsonPersona;
  }

  Future<Persona> getPersonaPorUid(String uid) async {
    var response = await http.get(Uri.parse("$_baseUrl/personas/ver/$uid"));
    var persona = Persona.fromJson(json.decode(response.body));
    if (response.body.isEmpty) {
      return persona;
    }
    return persona;
  }

  Future<Persona> addPersona(Persona persona) async {
    var response = await http.post(
      Uri.parse("$_baseUrl/personas"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        persona.toJson(),
      ),
    );
    print(response.body);
    var personaT = Persona.fromJson(json.decode(response.body));
    print(personaT);
    return personaT;
  }

  /*Future<bool> updatePersona(Persona persona) async {
    var response = await http.put(
      Uri.parse("$_baseUrl/solicitudes/${persona.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(persona.toJson()),
    );
    return response.statusCode == 200;
  }*/
}
