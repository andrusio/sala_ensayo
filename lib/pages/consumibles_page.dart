import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
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
    );
  }

  Widget _lista() {
    return FutureBuilder<List<Persona>>(
      future: fetchPersonas(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
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

class PersonaLista extends StatelessWidget {
  const PersonaLista({Key? key, required this.personas}) : super(key: key);

  final List<Persona> personas;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: personas.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.account_circle),
          title: Text(personas[index].apellido),
          trailing: Icon(Icons.more_vert),
          subtitle: Text('Concat de bandas'),
        );
      },
    );
  }
}
