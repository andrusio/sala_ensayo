import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/pages/persona_crud.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';
import 'package:sala_ensayo/models/clases_generales.dart';

class GrupoPersonaPage extends StatefulWidget {
  const GrupoPersonaPage({Key? key, required this.grupo}) : super(key: key);

  final Grupo grupo;

  @override
  _GrupoPersonaPageState createState() => _GrupoPersonaPageState();
}

class _GrupoPersonaPageState extends State<GrupoPersonaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Integrante'),
      ),
      body: _lista(widget.grupo),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonaCRUD(persona: Persona()),
            ),
          );
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _lista(Grupo grupo) {
    return FutureBuilder<List<Persona>>(
      future: fetchPersonas(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return GrupoPersonaLista(personas: snapshot.data!, grupo: grupo);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class GrupoPersonaLista extends StatefulWidget {
  const GrupoPersonaLista(
      {Key? key, required this.personas, required this.grupo})
      : super(key: key);

  final List<Persona> personas;
  final Grupo grupo;

  @override
  State<GrupoPersonaLista> createState() => _GrupoPersonaListaState();
}

class _GrupoPersonaListaState extends State<GrupoPersonaLista> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.personas.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Respuesta respuesta = await agregarIntegrante(
                  widget.grupo.id!, widget.personas[index].id!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(respuesta.texto),
                backgroundColor: respuesta.color,
              ));
              Navigator.pop(context);
            },
          ),
          title: Text(widget.personas[index].apellido! +
              ', ' +
              widget.personas[index].nombre!),
          // subtitle: Text('Concat de bandas'),
        );
      },
    );
  }
}
