import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
// import 'package:sala_ensayo/pages/persona_crud.dart';
// import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';
import 'package:sala_ensayo/models/clases_generales.dart';
import 'package:sala_ensayo/pages/sala_grupo_horario.dart';

import '../models/sala_grupo.dart';

// Input buscador
// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685
class SalaGrupoGrupoPage extends StatefulWidget {
  const SalaGrupoGrupoPage(
      {Key? key, required this.salagrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salagrupo;
  final Grupo grupo;

  @override
  _SalaGrupoGrupoPageState createState() => _SalaGrupoGrupoPageState();
}

class _SalaGrupoGrupoPageState extends State<SalaGrupoGrupoPage> {
  void seleccionarGrupo(int grupoId) => setState(() {
        widget.salagrupo.grupoId = grupoId;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar turno'),
      ),
      body: _grupoSelector(widget.salagrupo),
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

  Future<void> _selectDate(BuildContext context, grupo) async {
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SalaGrupoHorarioPage(salaGrupo: widget.salaGrupo, grupo: grupo),
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
                _selectDate(context, widget.grupos[index]);
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return SalaGrupoHorarioPage(
                //           grupo: widget.grupos[index],
                //           salaGrupo: widget.salaGrupo);
                //     });
              }),
        );
      },
    );
  }
}

class HoraDesde extends StatelessWidget {
  const HoraDesde({Key? key, required this.grupo, required this.salaGrupo})
      : super(key: key);

  final Grupo grupo;
  final SalaGrupo salaGrupo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sala ' + salaGrupo.sala! + ' - ' + grupo.nombre!),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const Text('widget horario inicio'),
              const Text('widget horario fin'),
            ],
          ),
        ),
      ),
    );
  }
}
