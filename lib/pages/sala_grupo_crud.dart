import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/sala_grupo.dart';

import '../models/clases_generales.dart';

class SalaGrupoCRUD extends StatefulWidget {
  const SalaGrupoCRUD({Key? key, required this.salagrupo}) : super(key: key);
  final SalaGrupo salagrupo;

  @override
  State<SalaGrupoCRUD> createState() => _SalaGrupoCRUDState();
}

class _SalaGrupoCRUDState extends State<SalaGrupoCRUD> {
  final _formKey = GlobalKey<FormState>();

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
          selectorGrupo(context, widget.salagrupo),
          selectorSala(context, widget.salagrupo),
        ],
      ),
    );
  }

  Widget selectorGrupo(BuildContext context, SalaGrupo salagrupo) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('Seleccionar Grupo'),
    );
  }

  Widget selectorSala(BuildContext context, SalaGrupo salagrupo) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('Seleccionar Sala'),
    );
  }

  Widget formulario(BuildContext context, SalaGrupo salagrupo) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            botonera(),
          ],
        ),
      ),
    );
  }

  Widget botonera() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.salagrupo.id != null) ...[
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            //   onPressed: () async {
            //     if (_formKey.currentState!.validate()) {
            //       Respuesta respuesta =
            //           await eliminarSalaGrupo(widget.sala.id!);
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text(respuesta.texto),
            //         backgroundColor: respuesta.color,
            //       ));
            //       Navigator.pop(context);
            //     }
            //   },
            //   child: const Text('Eliminar'),
            // ),
            const SizedBox(width: 25),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (_formKey.currentState!.validate()) {
            //       Respuesta respuesta = await modificarSalaGrupo(
            //           widget.sala.id!,
            //           nombreController.text,
            //           precioController.text,
            //           widget.sala.color!);
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text(respuesta.texto),
            //         backgroundColor: respuesta.color,
            //       ));
            //       Navigator.pop(context);
            //     }
            //   },
            //   child: const Text('Editar'),
            // ),
          ],
          if (widget.salagrupo.id == null) ...[
            ElevatedButton(
              onPressed: () async {
                // if (_formKey.currentState!.validate()) {
                //   Respuesta respuesta = await crearSala(nombreController.text,
                //       precioController.text, widget.sala.color!);
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text(respuesta.texto),
                //     backgroundColor: respuesta.color,
                //   ));
                //   Navigator.pop(context);
                // }
              },
              child: const Text('Guardar'),
            ),
          ],
        ],
      ),
    );
  }
}
