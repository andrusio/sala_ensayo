import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/sala_grupo.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/pages/sala_grupo_grupo.dart';
import 'package:sala_ensayo/pages/sala_grupo_resumen.dart';
import '../models/clases_generales.dart';
import '../models/sala.dart';

class SalaGrupoSala extends StatefulWidget {
  const SalaGrupoSala({Key? key, required this.salaGrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salaGrupo;
  final Grupo grupo;

  @override
  State<SalaGrupoSala> createState() => _SalaGrupoSalaState();
}

class _SalaGrupoSalaState extends State<SalaGrupoSala> {
  final _formKey = GlobalKey<FormState>();

  void seleccionarSala(Sala sala) => setState(() {
        widget.salaGrupo.salaId = sala.id;
        widget.salaGrupo.sala = sala.nombre;
        widget.salaGrupo.salaColor = sala.color!;
      });
  @override
  Widget build(BuildContext context) {
    String titulo =
        widget.salaGrupo.id == null ? 'Agregar turno' : 'Editar turno';
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Column(
        children: [_salaSelector()],
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
            seleccionarSala(salas[index]);
            if (widget.grupo.id == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalaGrupoGrupoPage(
                      salaGrupo: widget.salaGrupo, grupo: widget.grupo),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalaGrupoResumenPage(
                      salaGrupo: widget.salaGrupo, grupo: widget.grupo),
                ),
              );
            }
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
}
