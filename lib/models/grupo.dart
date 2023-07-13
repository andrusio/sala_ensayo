import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import '../env.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sala_ensayo/models/clases_generales.dart';
part 'grupo.g.dart';

// https://docs.flutter.dev/development/data-and-backend/json#which-json-serialization-method-is-right-for-me

@JsonSerializable(explicitToJson: true)
class Grupo {
  int? id;
  String? nombre;
  List<Persona> personas;

  Grupo({this.id, this.nombre, List<Persona>? personas})
      : personas = personas ?? <Persona>[];

  factory Grupo.fromJson(Map<String, dynamic> json) => _$GrupoFromJson(json);
  Map<String, dynamic> toJson() => _$GrupoToJson(this);

  // factory Grupo.fromJson(Map<String, dynamic> json) {
  //   final personasLista = json['personas'] as List<Persona>;
  //   List<Persona> personas =
  //       personasLista.map((i) => Persona.fromJson(i)).toList();
  //   return Grupo(
  //     id: json['id'],
  //     nombre: json['nombre'],
  //     // personas: json['personas'],
  //     personas: personasLista,
  //   );
  // }
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

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Grupo creado con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

eliminarGrupo(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/grupo/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Grupo eliminado con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

modificarGrupo(int id, String nombre) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/grupo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'nombre': nombre,
      }));

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Grupo modificado con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

agregarIntegrante(int idGrupo, int idPersona) async {
  final response = await http.post(
    Uri.parse(Env.baseUrl + '/persona_grupo/$idGrupo/$idPersona'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green,
        texto: 'Integrante agregado con éxito',
        status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

Future<Grupo> fetchPersonasGrupo(http.Client client, int idGrupo) async {
  final response =
      await client.get(Uri.parse(Env.baseUrl + '/persona_grupo/$idGrupo'));
  return Grupo.fromJson(json.decode(response.body));
}
