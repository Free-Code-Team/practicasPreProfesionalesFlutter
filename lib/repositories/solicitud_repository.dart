import 'package:practicas_pre_profesionales_flutter/models/solicitud_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SolicitudRepository {
  static const String baseUrl = "http://10.0.2.2:8000/api";

  Future<ResModel> getAllSolicitudes() async {
    var response = await http.get(Uri.parse("$baseUrl/solicitudes"));
    if (response.statusCode == 200) {
      return ResModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falló la conexión al listar las solicitudes.");
    }
  }

  /*Future<User> getUserById(String id) async {
    var response = await http.get("$baseUrl/users/$id?$apiKey");
    var jsonUser = json.decode(response.body);
    User user = User.fromJson(jsonUser);
    return user;
  }

  Future<bool> createUser(User user) async {
    var response = await http.post(
      "$baseUrl/users?$apiKey",
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        user.toJson(),
      ),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateUser(User user) async {
    var response = await http.put(
      "$baseUrl/users/${user.id}?$apiKey",
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteUser(String id) async {
    var response = await http.delete("$baseUrl/users/$id?$apiKey");
    return response.statusCode == 200;
  }*/
}
