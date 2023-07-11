import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/persona.dart';
import 'package:sala_ensayo/models/clases_generales.dart';

class PersonaCRUD extends StatefulWidget {
  const PersonaCRUD({Key? key, required Persona this.persona})
      : super(key: key);

  final Persona persona;

  @override
  State<PersonaCRUD> createState() => _PersonaCRUDState();
}

class _PersonaCRUDState extends State<PersonaCRUD> {
  @override
  Widget build(BuildContext context) {
    String titulo =
        widget.persona.id == null ? 'Agregar persona' : 'Editar persona';
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: FormPersona(persona: widget.persona),
    );
  }
}

class FormPersona extends StatefulWidget {
  const FormPersona({Key? key, required this.persona}) : super(key: key);
  final Persona persona;

  @override
  FormPersonaState createState() {
    return FormPersonaState();
  }
}

class FormPersonaState extends State<FormPersona> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nombreController.text = widget.persona.nombre ?? '';
    apellidoController.text = widget.persona.apellido ?? '';
    telefonoController.text = widget.persona.telefono != null
        ? widget.persona.telefono.toString()
        : '';

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
                labelText: 'Apellido',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
              controller: apellidoController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Teléfono',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
              controller: telefonoController,
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
          if (widget.persona.id != null) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta =
                      await eliminarPersona(widget.persona.id!);
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
                  Respuesta respuesta = await modificarPersona(
                      widget.persona.id!,
                      nombreController.text,
                      apellidoController.text,
                      telefonoController.text);
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
          if (widget.persona.id == null) ...[
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Respuesta respuesta = await crearPersona(
                      nombreController.text,
                      apellidoController.text,
                      telefonoController.text);
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
