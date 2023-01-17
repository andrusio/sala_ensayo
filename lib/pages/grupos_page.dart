import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/pages/grupo_crud.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';

import '../models/grupo.dart';

class GruposPage extends StatelessWidget {
  const GruposPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
        centerTitle: true,
      ),
      drawer: const PanelLateralWidget(),
      body: _lista(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GrupoCRUD(grupo: Grupo()),
            ),
          );
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ), // This t
    );
  }

  Widget _lista() {
    return FutureBuilder<List<Grupo>>(
      future: fetchGrupos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return GrupoLista(grupos: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class GrupoLista extends StatefulWidget {
  const GrupoLista({Key? key, required this.grupos}) : super(key: key);
  final List<Grupo> grupos;

  @override
  State<GrupoLista> createState() => _GrupoListaState();
}

class _GrupoListaState extends State<GrupoLista> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.grupos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.people),
          title: Text(widget.grupos[index].nombre!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GrupoCRUD(grupo: widget.grupos[index]),
              ),
            );
          },
        );
      },
    );
  }
}
