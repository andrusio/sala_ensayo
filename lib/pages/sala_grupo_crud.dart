import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/sala_grupo.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/pages/sala_grupo_agregar.dart';
import '../models/clases_generales.dart';
import '../models/sala.dart';

class SalaGrupoCRUD extends StatefulWidget {
  const SalaGrupoCRUD({Key? key, required this.salagrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salagrupo;
  final Grupo grupo;

  @override
  State<SalaGrupoCRUD> createState() => _SalaGrupoCRUDState();
}

class _SalaGrupoCRUDState extends State<SalaGrupoCRUD> {
  final _formKey = GlobalKey<FormState>();

  void seleccionarSala(int salaId, String salaNombre) => setState(() {
        widget.salagrupo.salaId = salaId;
        widget.salagrupo.sala = salaNombre;
      });

  @override
  Widget build(BuildContext context) {
    String titulo =
        widget.salagrupo.id == null ? 'Agregar turno' : 'Editar turno';
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Column(
        children: [
          _salaSelector()
          // selectorSala(context, widget.salagrupo),
          // selectorGrupo(context, widget.salagrupo),
        ],
      ),
    );
  }

  Widget _salaSelector() {
    return FutureBuilder<List<Sala>>(
      future: fetchSalas(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return _salaLista(snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _salaLista(List<Sala> salas) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: salas.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            seleccionarSala(salas[index].id!, salas[index].nombre!);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SalaGrupoAgregarPage(
                    salagrupo: widget.salagrupo, grupo: widget.grupo),
              ),
            );
          },
          child: Container(
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: salas[index].color),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  salas[index].nombre!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
  }

  Widget selectorGrupo(BuildContext context, SalaGrupo salagrupo) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: const Text('Seleccionar Grupo'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalaGrupoAgregarPage(
                  salagrupo: widget.salagrupo, grupo: widget.grupo),
            ),
          );
        });
  }
}
