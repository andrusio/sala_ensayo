import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
// import 'package:sala_ensayo/pages/persona_crud.dart';
// import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';
import 'package:sala_ensayo/models/clases_generales.dart';

import '../models/sala_grupo.dart';

// Input buscador
// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685
class SalaGrupoAgregarPage extends StatefulWidget {
  const SalaGrupoAgregarPage(
      {Key? key, required this.salagrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salagrupo;
  final Grupo grupo;

  @override
  _SalaGrupoAgregarPageState createState() => _SalaGrupoAgregarPageState();
}

class _SalaGrupoAgregarPageState extends State<SalaGrupoAgregarPage> {
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return HoraDesde(
                          grupo: widget.grupos[index],
                          salaGrupo: widget.salaGrupo);
                    });
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
