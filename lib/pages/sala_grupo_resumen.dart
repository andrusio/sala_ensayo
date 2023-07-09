import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/models/clases_generales.dart';
import 'package:sala_ensayo/pages/sala_grupo_grupo.dart';
import 'package:sala_ensayo/pages/sala_grupo_sala.dart';

import '../models/sala_grupo.dart';

// Input buscador
// https://karthikponnam.medium.com/flutter-search-in-listview-1ffa40956685
class SalaGrupoResumenPage extends StatefulWidget {
  const SalaGrupoResumenPage(
      {Key? key, required this.salaGrupo, required this.grupo})
      : super(key: key);
  final SalaGrupo salaGrupo;
  final Grupo grupo;

  @override
  _SalaGrupoResumenPageState createState() => _SalaGrupoResumenPageState();
}

class _SalaGrupoResumenPageState extends State<SalaGrupoResumenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar turno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const Text('Fecha: '),
                ElevatedButton(
                  child: Text(
                      "${widget.salaGrupo.horaDesde.toLocal()}".split(' ')[0]),
                  onPressed: () => {},
                ),
              ],
            ),
            Row(
              children: [
                const Text('Desde: '),
                ElevatedButton(
                  child: Text("${widget.salaGrupo.horaDesde.toLocal()}"),
                  onPressed: () => {
                    displayTimePickerDesde(context,
                        TimeOfDay.fromDateTime(widget.salaGrupo.horaDesde))
                  },
                  // child: Text("${widget.salaGrupo.horaDesde.toLocal()}".split(' ')[0]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Hasta: '),
                ElevatedButton(
                  child: Text("${widget.salaGrupo.horaHasta.toLocal()}"),
                  onPressed: () => {
                    displayTimePickerHasta(context,
                        TimeOfDay.fromDateTime(widget.salaGrupo.horaHasta))
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Sala: '),
                ElevatedButton(
                  child: Text("${widget.salaGrupo.sala}"),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalaGrupoSala(
                            salaGrupo: widget.salaGrupo, grupo: widget.grupo),
                      ),
                    ),
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Grupo: '),
                ElevatedButton(
                  child: Text("${widget.salaGrupo.grupo}"),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalaGrupoGrupoPage(
                            salaGrupo: widget.salaGrupo, grupo: widget.grupo),
                      ),
                    ),
                  },
                ),
              ],
            ),
            Row(
              children: [
                botonera(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future displayTimePickerDesde(BuildContext context, TimeOfDay hora) async {
    var time = await showTimePicker(context: context, initialTime: hora);

    if (time != null) {
      setState(() {
        widget.salaGrupo.horaDesde = DateTime(
            widget.salaGrupo.horaDesde.year,
            widget.salaGrupo.horaDesde.month,
            widget.salaGrupo.horaDesde.day,
            time.hour,
            time.minute);
        // widget.salaGrupo.horaDesde = "${time.hour}:${time.minute}";
      });
    }
  }

  Future displayTimePickerHasta(BuildContext context, TimeOfDay hora) async {
    var time = await showTimePicker(context: context, initialTime: hora);

    if (time != null) {
      setState(() {
        widget.salaGrupo.horaHasta = DateTime(
            widget.salaGrupo.horaHasta.year,
            widget.salaGrupo.horaHasta.month,
            widget.salaGrupo.horaHasta.day,
            time.hour,
            time.minute);
        // widget.salaGrupo.horaDesde = "${time.hour}:${time.minute}";
      });
    }
  }

  Widget botonera() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.salaGrupo.id != null) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Respuesta respuesta =
                    await eliminarSalaGrupo(widget.salaGrupo.id!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(respuesta.texto),
                  backgroundColor: respuesta.color,
                ));
                Navigator.pop(context);
              },
              child: const Text('Eliminar'),
            ),
            const SizedBox(width: 25),
            ElevatedButton(
              onPressed: () async {
                Respuesta respuesta = await modificarSalaGrupo(
                    widget.salaGrupo.id!,
                    widget.salaGrupo.salaId!,
                    widget.salaGrupo.grupoId!,
                    widget.salaGrupo.horaDesde,
                    widget.salaGrupo.horaHasta);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(respuesta.texto),
                  backgroundColor: respuesta.color,
                ));
                Navigator.pop(context);
              },
              child: const Text('Editar'),
            ),
          ],
          if (widget.salaGrupo.id == null) ...[
            ElevatedButton(
              onPressed: () async {
                Respuesta respuesta = await crearSalaGrupo(
                    widget.salaGrupo.salaId!,
                    widget.salaGrupo.grupoId!,
                    widget.salaGrupo.horaDesde,
                    widget.salaGrupo.horaHasta);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(respuesta.texto),
                  backgroundColor: respuesta.color,
                ));
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ],
      ),
    );
  }
}
