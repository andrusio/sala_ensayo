import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/clases_generales.dart';
import '../env.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sala.g.dart';

@JsonSerializable(explicitToJson: true)
class Sala {
  int? id;
  String? nombre;
  double? precio;
  Color? color;

  Sala({this.id, this.nombre, this.precio, this.color = Colors.blueAccent});

  factory Sala.fromJson(Map<String, dynamic> json) => _$SalaFromJson(json);
  Map<String, dynamic> toJson() => _$SalaToJson(this);
}

Future<List<Sala>> fetchSalas(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl + '/salas'));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<Sala>((json) => Sala.fromJson(json)).toList();
}

crearSala(String nombre, String precio, Color color) async {
  final response = await http.post(Uri.parse(Env.baseUrl + '/sala'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'precio': double.parse(precio),
        'color': color.value
      }));

  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala creada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: response.body, status: false);
    return respuesta;
  }
}

eliminarSala(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/sala/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala eliminada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: response.body, status: false);
    return respuesta;
  }
}

modificarSala(int id, String nombre, String precio, Color color) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/sala'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'nombre': nombre,
        'precio': double.parse(precio),
        'color': color.value
      }));
  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Sala modificada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: response.body, status: false);
    return respuesta;
  }
}
