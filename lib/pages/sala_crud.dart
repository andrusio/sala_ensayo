import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sala_ensayo/models/sala.dart';

import '../models/clases_generales.dart';

class SalaCRUD extends StatefulWidget {
  const SalaCRUD({Key? key, required Sala this.sala}) : super(key: key);

  final Sala sala;

  @override
  State<SalaCRUD> createState() => _SalaCRUDState();
}

class _SalaCRUDState extends State<SalaCRUD> {
  void guardarEstado(Color color, String nombre, String precio) => setState(() {
        widget.sala.color = color;
        widget.sala.nombre = nombre;
        widget.sala.precio = double.tryParse(precio);
      });
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String titulo = widget.sala.id == null ? 'Agregar Sala' : 'Editar Sala';
    nombreController.text = widget.sala.nombre ?? '';
    precioController.text =
        widget.sala.precio != null ? widget.sala.precio.toString() : '';

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Column(
        children: [
          selectorColor(context, widget.sala.color!),
          formulario(context, widget.sala),
        ],
      ),
    );
  }

  Widget selectorColor(BuildContext context, Color colorSala) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        fillColor: colorSala,
        padding: const EdgeInsets.all(15),
        child: const Icon(
          Icons.colorize,
          size: 30,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Selecciona un color'),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: colorSala, //default color
                      onColorChanged: (color) {
                        //on color picked
                        guardarEstado(color, nombreController.text,
                            precioController.text);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop(); //dismiss the color picker
                      },
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  Widget formulario(BuildContext context, Sala sala) {
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
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Precio por Hora',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
              controller: precioController,
            ),
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
          if (widget.sala.id != null) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await eliminarSala(widget.sala.id!);
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
                  Respuesta respuesta = await modificarSala(
                      widget.sala.id!,
                      nombreController.text,
                      precioController.text,
                      widget.sala.color!);
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
          if (widget.sala.id == null) ...[
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await crearSala(nombreController.text,
                      precioController.text, widget.sala.color!);
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
