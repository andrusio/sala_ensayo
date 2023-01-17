import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/grupo.dart';

class GrupoCRUD extends StatefulWidget {
  const GrupoCRUD({Key? key, required this.grupo}) : super(key: key);

  final Grupo grupo;

  @override
  State<GrupoCRUD> createState() => _GrupoCRUDState();
}

class _GrupoCRUDState extends State<GrupoCRUD> {
  @override
  Widget build(BuildContext context) {
    String titulo = widget.grupo.id == null ? 'Agregar Grupo' : 'Editar Grupo';
    return Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: Column(
          children: [
            FormGrupo(grupo: widget.grupo),
            Text(widget.grupo.personas.first.nombre.toString()),
            // Text(integrantes.toString()),
          ],
        ));
  }
}

class FormGrupo extends StatefulWidget {
  const FormGrupo({Key? key, required this.grupo}) : super(key: key);
  final Grupo grupo;

  @override
  FormGrupoState createState() {
    return FormGrupoState();
  }
}

class FormGrupoState extends State<FormGrupo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nombreController.text = widget.grupo.nombre ?? '';

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nombre',
              ),
              //initialValue: widget.persona.nombre,
              //onFieldSubmitted: //aca
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
              controller: nombreController,
            ),
            botonera(),
          ],
        ),
      ),
    );
  }

  Widget botonera() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.grupo.id != null) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await eliminarGrupo(widget.grupo.id!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(respuesta.texto),
                    backgroundColor: respuesta.color,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Eliminar'),
            ),
            const SizedBox(width: 25),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await modificarGrupo(
                      widget.grupo.id!, nombreController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(respuesta.texto),
                    backgroundColor: respuesta.color,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Editar'),
            ),
          ],
          if (widget.grupo.id == null) ...[
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await crearGrupo(nombreController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(respuesta.texto),
                    backgroundColor: respuesta.color,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ],
      ),
    );
  }
}
