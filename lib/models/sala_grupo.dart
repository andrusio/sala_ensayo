import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/clases_generales.dart';
import '../env.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
part 'sala_grupo.g.dart';

@JsonSerializable(explicitToJson: true)
class SalaGrupo {
  int? id;
  String? sala;
  int? salaId;
  Color salaColor;
  String grupo;
  int? grupoId;
  DateTime horaDesde;
  DateTime horaHasta;

  SalaGrupo(
      {this.id,
      this.sala,
      this.salaId,
      this.salaColor = Colors.blueAccent,
      this.grupo = '',
      this.grupoId,
      required this.horaDesde,
      required this.horaHasta});

  factory SalaGrupo.fromJson(Map<String, dynamic> json) =>
      _$SalaGrupoFromJson(json);
  Map<String, dynamic> toJson() => _$SalaGrupoToJson(this);
}

Future<List<SalaGrupo>> fetchSalaGrupo(http.Client client) async {
  final response = await client.get(Uri.parse(Env.baseUrl +
      '/sala_grupo/?fecha=' +
      DateFormat('yyyy-MM-dd').format(DateTime.now())));
  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
  return parsed.map<SalaGrupo>((json) => SalaGrupo.fromJson(json)).toList();
}

crearSalaGrupo(
    int salaId, int grupoId, DateTime horaDesde, DateTime horaHasta) async {
  final response = await http.post(Uri.parse(Env.baseUrl + '/sala_grupo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sala_id': salaId,
        'grupo_id': grupoId,
        'hora_desde': DateFormat('yyyy-MM-dd HH:mm').format(horaDesde),
        'hora_hasta': DateFormat('yyyy-MM-dd HH:mm').format(horaHasta)
      }));

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 201) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Turno creado con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

eliminarSalaGrupo(int id) async {
  final response = await http.delete(
    Uri.parse(Env.baseUrl + '/sala_grupo/$id/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 204) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'turno eliminada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}

modificarSalaGrupo(int id, int salaId, int grupoId, DateTime horaDesde,
    DateTime horaHasta) async {
  final response = await http.put(Uri.parse(Env.baseUrl + '/sala/$id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sala_id': salaId,
        'grupo_id': grupoId,
        'hora_desde': DateFormat('yyyy-MM-dd HH:mm').format(horaDesde),
        'hora_hasta': DateFormat('yyyy-MM-dd HH:mm').format(horaHasta)
      }));

  final jsonBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    Respuesta respuesta = Respuesta(
        color: Colors.green, texto: 'Turno modificada con éxito', status: true);
    return respuesta;
  } else {
    Respuesta respuesta =
        Respuesta(color: Colors.red, texto: jsonBody['error'], status: false);
    return respuesta;
  }
}
