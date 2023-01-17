import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import '../env.dart';

class Grupo {
  int? id;
  String? nombre;
  List<Persona>? personas;

  Grupo({
    this.id,
    this.nombre,
    this.personas,
  });

  factory Grupo.fromJson(Map<String, dynamic> json) {
    final personasLista = json['personas'] as List<Persona>;
    List<Persona> personas =
        personasLista.map((i) => Persona.fromJson(i)).toList();
    return Grupo(
      id: json['id'],
      nombre: json['nombre'],
      // personas: json['personas'],
      personas: personasLista,
    );
  }
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

Future<List<Grupo>> fetchGrupos(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl + '/grupos'));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Grupo>((json) => Grupo.fromJson(json)).toList();
}

crearGrupo(String nombre) async {
  final response = await http.post(Uri.parse(Env.baseUrl + '/grupo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
      }));

  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Grupo creado con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al crear Grupo', status: false);
    return respuesta;
  }
}

eliminarGrupo(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/grupo/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 204) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala eliminada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al eliminar Sala', status: false);
    return respuesta;
  }
}

modificarGrupo(int id, String nombre) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/grupo/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
      }));

  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Grupo modificada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al editar Grupo', status: false);
    return respuesta;
  }
}
