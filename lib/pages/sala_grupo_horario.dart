import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/models/clases_generales.dart';

import '../models/sala_grupo.dart';

// Input buscador
// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685
class SalaGrupoHorarioPage extends StatefulWidget {
  const SalaGrupoHorarioPage(
      {Key? key, required this.salaGrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salaGrupo;
  final Grupo grupo;

  @override
  _SalaGrupoHorarioPageState createState() => _SalaGrupoHorarioPageState();
}

class _SalaGrupoHorarioPageState extends State<SalaGrupoHorarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar turno'),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                      "${widget.salaGrupo.horaDesde.toLocal()}".split(' ')[0]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
