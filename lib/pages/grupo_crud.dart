import 'package:flutter/material.dart';
import 'package:sala_ensayo/models/grupo.dart';
import 'package:sala_ensayo/pages/grupo_persona.dart';
import 'package:sala_ensayo/pages/persona_crud.dart';
import 'package:sala_ensayo/models/clases_generales.dart';

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
          Integrantes(grupo: widget.grupo),
        ],
      ),
    );
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

    return Card(
      child: Form(
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
      ),
    );
  }

  Widget botonera() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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

class Integrantes extends StatefulWidget {
  const Integrantes({Key? key, required this.grupo}) : super(key: key);
  final Grupo grupo;

  @override
  State<Integrantes> createState() => _IntegrantesState();
}

class _IntegrantesState extends State<Integrantes> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          if (widget.grupo.id != null) ...[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              child: const Text(
                "Integrantes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: widget.grupo.personas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 100),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      hoverColor: Colors.blueAccent,
                      color: Colors.blueAccent,
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonaCRUD(
                                persona: widget.grupo.personas[index]),
                          ),
                        );
                      },
                    ),
                    Text(
                        widget.grupo.personas[index].nombre! +
                            ' ' +
                            widget.grupo.personas[index].apellido!,
                        overflow: TextOverflow.ellipsis),
                  ],
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GrupoPersonaPage(grupo: widget.grupo),
                  ),
                ),
              },
              child: Icon(Icons.add),
            )
          ],
        ],
      ),
    );
  }
}
