import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
part 'sala_grupo.g.dart';

@JsonSerializable(explicitToJson: true)
class SalaGrupo {
  int? id;
  String? sala;
  Color salaColor;
  String grupo;
  DateTime horaDesde;
  DateTime horaHasta;

  SalaGrupo(
      {this.id,
      this.sala,
      required this.salaColor,
      required this.grupo,
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
