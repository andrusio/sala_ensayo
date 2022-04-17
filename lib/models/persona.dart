import 'dart:convert';
import 'package:flutter/material.dart';
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

class Respuesta {
  Color color;
  String texto;
  bool status;

  Respuesta({
    required this.color,
    required this.texto,
    required this.status,
  });
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

crearPersona(String nombre, String apellido, String telefono) async {
  final response = await http.post(Uri.parse(Env.baseUrl + '/personas/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono.toString(),
      }));

  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Persona creada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al crear persona', status: false);
    return respuesta;
  }
}

eliminarPersona(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/personas/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 204) {
    Respuesta respuesta = Respuesta(
        color: Colors.green,
        texto: 'Persona eliminada con éxito',
        status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al eliminar persona', status: false);
    return respuesta;
  }
}

modificarPersona(
    int id, String nombre, String apellido, String telefono) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/personas/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono.toString(),
      }));

  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green,
        texto: 'Persona modificada con éxito',
        status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al editar persona', status: false);
    return respuesta;
  }
}
