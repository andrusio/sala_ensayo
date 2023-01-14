import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../env.dart';

class Sala {
  int? id;
  String? nombre;
  double? precioHora;

  Sala({
    this.id,
    this.nombre,
    this.precioHora,
  });

  factory Sala.fromJson(Map<String, dynamic> json) => Sala(
        id: json['id'],
        nombre: json['nombre'],
        precioHora: (json['precioHora'].toDouble()),
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

Future<List<Sala>> fetchSalas(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl + '/salas'));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Sala>((json) => Sala.fromJson(json)).toList();
}

crearSala(String nombre, String precioHora) async {
  final response = await http.post(Uri.parse(Env.baseUrl + '/sala'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'precioHora': double.parse(precioHora),
      }));

  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala creada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al crear Sala', status: false);
    return respuesta;
  }
}

eliminarSala(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/sala/$id/'),
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

modificarSala(int id, String nombre, String precioHora) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/sala/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'precioHora': precioHora,
      }));

  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala modificada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta = Respuesta(
        color: Colors.red, texto: 'Error al editar Sala', status: false);
    return respuesta;
  }
}
