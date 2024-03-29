import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/pages/sala_crud.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';

import '../models/sala.dart';

class SalasPage extends StatefulWidget {
  const SalasPage({Key? key}) : super(key: key);

  @override
  _SalasPageState createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salas'),
        centerTitle: true,
      ),
      drawer: const PanelLateralWidget(),
      body: _lista(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalaCRUD(sala: Sala()),
            ),
          ).then((value) => setState((() {})));
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ), // This t
    );
  }

  Widget _lista() {
    return FutureBuilder<List<Sala>>(
      future: fetchSalas(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return SalaLista(salas: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class SalaLista extends StatefulWidget {
  const SalaLista({Key? key, required this.salas}) : super(key: key);
  final List<Sala> salas;

  @override
  State<SalaLista> createState() => _SalaListaState();
}

class _SalaListaState extends State<SalaLista> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: widget.salas.length,
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
                              SalaCRUD(sala: widget.salas[index])),
                    ).then((value) => setState((() {})));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://s3.us-west-2.amazonaws.com/static.ernieball.com/website/images/products/image_front/large/P09332.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        widget.salas[index].nombre!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Precio/hora: ' +
                                widget.salas[index].precio!.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: widget.salas[index].color,
                    ),
                  ],
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
