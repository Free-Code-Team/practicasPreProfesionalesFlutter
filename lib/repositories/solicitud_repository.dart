import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicas_pre_profesionales_flutter/models/solicitud/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';

class SolicitudRepository {
  static const String _baseUrl = "http://10.0.2.2:8000/api";

  Future<Response> getAllSolicitudes() async {
    final response = await http.get(Uri.parse('$_baseUrl/solicitudes'));
    if (response.statusCode == 200) {
      return Response.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load joke");
    }
  }

  Future<Solicitud> getSolicitudById(int id) async {
    var response = await http.get(Uri.parse("$_baseUrl/solicitudes/$id"));
    var jsonSolicitud = Solicitud.fromJson(json.decode(response.body));
    return jsonSolicitud;
  }

  Future<bool> addSolicitud(Solicitud solicitud) async {
    var response = await http.post(
      Uri.parse("$_baseUrl/solicitudes"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        solicitud.toJson(),
      ),
    );
    return response.statusCode == 200;
  }

  Future<bool> updateSolicitud(Solicitud solicitud) async {
    var response = await http.put(
      Uri.parse("$_baseUrl/solicitudes/${solicitud.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(solicitud.toJson()),
    );
    return response.statusCode == 200;
  }

  /*Future<bool> deleteUser(String id) async {
    var response = await http.delete("$baseUrl/users/$id?$apiKey");
    return response.statusCode == 200;
  }*/
}
