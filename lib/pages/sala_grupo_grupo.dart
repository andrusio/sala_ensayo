import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
// import 'package:sala_ensayo/pages/persona_crud.dart';
// import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';
import 'package:sala_ensayo/models/clases_generales.dart';
import 'package:sala_ensayo/pages/sala_grupo_resumen.dart';

import '../models/sala_grupo.dart';

// Input buscador
// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685
class SalaGrupoGrupoPage extends StatefulWidget {
  const SalaGrupoGrupoPage(
      {Key? key, required this.salaGrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salaGrupo;
  final Grupo grupo;

  @override
  _SalaGrupoGrupoPageState createState() => _SalaGrupoGrupoPageState();
}

class _SalaGrupoGrupoPageState extends State<SalaGrupoGrupoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar turno'),
      ),
      body: _grupoSelector(widget.salaGrupo),
    );
  }

  Widget _grupoSelector(SalaGrupo salaGrupo) {
    return FutureBuilder<List<Grupo>>(
      future: fetchGrupos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return SalaGrupoLista(
            grupos: snapshot.data!,
            salaGrupo: salaGrupo,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SalaGrupoLista extends StatefulWidget {
  const SalaGrupoLista(
      {Key? key, required this.grupos, required this.salaGrupo})
      : super(key: key);

  final List<Grupo> grupos;
  final SalaGrupo salaGrupo;

  @override
  State<SalaGrupoLista> createState() => _SalaGrupoListaState();
}

class _SalaGrupoListaState extends State<SalaGrupoLista> {
  DateTime selectedDate = DateTime.now();

  void seleccionarGrupo(Grupo grupo) => setState(() {
        widget.salaGrupo.grupoId = grupo.id;
        widget.salaGrupo.grupo = grupo.nombre!;
      });

  Future<void> _selectDate(BuildContext context, Grupo grupo) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    widget.salaGrupo.horaDesde = selectedDate;
    widget.salaGrupo.horaHasta = selectedDate;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SalaGrupoResumenPage(salaGrupo: widget.salaGrupo, grupo: grupo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.grupos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.grupos[index].nombre!),
          leading: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                seleccionarGrupo(widget.grupos[index]);
                if (widget.salaGrupo.horaDesde == widget.salaGrupo.horaHasta) {
                  _selectDate(context, widget.grupos[index]);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalaGrupoResumenPage(
                          salaGrupo: widget.salaGrupo,
                          grupo: widget.grupos[index]),
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
