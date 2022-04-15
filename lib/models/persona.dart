import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Persona {
  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  int id;
  String nombre;
  String apellido;
  int telefono;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        telefono: json['telefono'],
      );
}

// Future<List<Persona>> fetchPersonas(http.Client client) async {
//   final response =
//       await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//   final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
//   return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
// }

// Future<List<Persona>> fetchPersonas(http.Client client) async {
//   final response =
//       await client.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
//   return compute(parsePersonas, response.body);
// }

// List<Persona> parsePersonas(String responseBody) {
//   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//   print(parsed);

//   return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
// }

Future<List<Persona>> fetchPersonas(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl + '/personas'));
  return compute(parsePersonas, response.body);
}

List<Persona> parsePersonas(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Persona>((json) => Persona.fromJson(json)).toList();
}
