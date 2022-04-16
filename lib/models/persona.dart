import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Persona {
  int? id;
  String? nombre;
  String? apellido;
  int? telefono;

  Persona({
    this.id,
    this.nombre,
    this.apellido,
    this.telefono,
  });

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        telefono: json['telefono'],
      );
}

Future<List<Persona>> fetchPersonas(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl + '/personas'));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
}

// Future<List<Persona>> fetchPersonas(http.Client client) async {
//   final response = await client.get(Uri.parse(Env.baseUrl + '/personas'));
//   return compute(parsePersonas, response.body);
// }

// List<Persona> parsePersonas(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
// }
