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
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: widget.grupos.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            height: 290,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GrupoCRUD(grupo: widget.grupos[index])),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://tech.pelmorex.com/wp-content/uploads/2020/10/flutter.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.grupos[index].nombre!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        mainAxisExtent: 200,
      ),
    );
  }
}
