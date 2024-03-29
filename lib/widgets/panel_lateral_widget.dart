import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sala_ensayo/pages/personas_page.dart';
import 'package:sala_ensayo/pages/salas_page.dart';
import 'package:sala_ensayo/pages/grupos_page.dart';
import 'package:sala_ensayo/pages/agenda_page.dart';
import '../env.dart';

class PanelLateralWidget extends StatelessWidget {
  const PanelLateralWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              Env.nombreComercio,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Agenda'),
            onTap: () {
              Navigator.pushNamed(context, '/agenda');
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_music),
            title: const Text('Salas'),
            onTap: () {
              Navigator.pushNamed(context, '/salas');
            },
          ),
          const ListTile(
            leading: Icon(Icons.local_drink),
            title: Text('Consumibles'),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Grupos'),
            onTap: () {
              Navigator.pushNamed(context, '/grupos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Personas'),
            onTap: () {
              Navigator.pushNamed(context, '/personas');
            },
          ),
          const ListTile(
            leading: Icon(Icons.radio),
            title: Text('Equipamiento'),
          ),
        ],
      ),
    );
  }
}
