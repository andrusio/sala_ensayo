import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/persona.dart';

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
  @override
  Widget build(BuildContext context) {
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
              initialValue: widget.persona.nombre,
              //onFieldSubmitted: //aca
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Apellido',
              ),
              initialValue: widget.persona.apellido,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Teléfono',
              ),
              keyboardType: TextInputType.number,
              initialValue: widget.persona.telefono != null
                  ? widget.persona.telefono.toString()
                  : '',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'No puede estar vacio';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Procesando...')),
                    );
                  }
                },
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
