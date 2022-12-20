import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practicas_pre_profesionales_flutter/models/empresa/empresa.dart';
import 'package:practicas_pre_profesionales_flutter/models/empresa/response.dart';
import 'package:practicas_pre_profesionales_flutter/models/solicitud/solicitud.dart';

class EmpresaRepository {
  static const String _baseUrl = "http://10.0.2.2:8000/api";

  Future<Response> getAllEmpresas() async {
    final response = await http.get(Uri.parse('$_baseUrl/empresas'));
    if (response.statusCode == 200) {
      return Response.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load joke");
    }
  }

  Future<Empresa> getEmpresaById(int id) async {
    var response = await http.get(Uri.parse("$_baseUrl/empresas/$id"));
    var jsonEmpresa = Empresa.fromJson(json.decode(response.body));
    return jsonEmpresa;
  }

  Future<Empresa> addEmpresa(Empresa empresa) async {
    var response = await http.post(
      Uri.parse("$_baseUrl/empresas"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        empresa.toJson(),
      ),
    );
    print(response.statusCode);
    var empresaT = Empresa.fromJson(json.decode(response.body));
    return empresaT;
  }

  Future<Empresa> updateEmpresa(Empresa empresa) async {
    var response = await http.put(
      Uri.parse("$_baseUrl/empresas/${empresa.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(empresa.toJson()),
    );
    var empresaT = Empresa.fromJson(json.decode(response.body));
    return empresaT;
  }

/*Future<bool> deleteUser(String id) async {
    var response = await http.delete("$baseUrl/users/$id?$apiKey");
    return response.statusCode == 200;
  }*/
}
