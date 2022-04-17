import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/pages/persona_crud.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';

class PersonasPage extends StatefulWidget {
  const PersonasPage({Key? key}) : super(key: key);

  @override
  _PersonasPageState createState() => _PersonasPageState();
}

class _PersonasPageState extends State<PersonasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personas'),
        centerTitle: true,
      ),
      drawer: const PanelLateralWidget(),
      body: _lista(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonaCRUD(persona: Persona()),
            ),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _lista() {
    return FutureBuilder<List<Persona>>(
      future: fetchPersonas(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return PersonaLista(personas: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class PersonaLista extends StatefulWidget {
  const PersonaLista({Key? key, required this.personas}) : super(key: key);

  final List<Persona> personas;

  @override
  State<PersonaLista> createState() => _PersonaListaState();
}

class _PersonaListaState extends State<PersonaLista> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.personas.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(widget.personas[index].apellido! +
              ', ' +
              widget.personas[index].nombre!),
          trailing: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PersonaCRUD(persona: widget.personas[index]),
                ),
              );
            },
          ),
          subtitle: Text('Concat de bandas'),
        );
      },
    );
  }
}
