import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sala_ensayo/pages/sala_crud.dart';
import 'package:sala_ensayo/pages/sala_grupo_crud.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/grupo.dart';
import '../models/sala.dart';
import '../models/sala_grupo.dart';

// https://pub.dev/packages/syncfusion_flutter_calendar/example

class AgendaPage extends StatelessWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        centerTitle: true,
      ),
      drawer: const PanelLateralWidget(),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: _turnos(),
          ),
          const Expanded(
            flex: 2,
            child: Text("Aca va caja con referencia de colores/salas"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalaGrupoCRUD(
                salagrupo: SalaGrupo(
                  horaDesde: DateTime.now(),
                  horaHasta: DateTime.now(),
                ),
                grupo: Grupo(),
              ),
            ),
          );
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ), // This t
    );
  }
}

Widget _turnos() {
  return FutureBuilder<List<SalaGrupo>>(
      future: fetchSalaGrupo(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('No se puso conectar con el servidor'),
          );
        } else if (snapshot.hasData) {
          return Calendario(salagrupo: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

class Calendario extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const Calendario({Key? key, required this.salagrupo}) : super(key: key);
  final List<SalaGrupo> salagrupo;

  @override
  // ignore: library_private_types_in_public_api
  CalendarioState createState() => CalendarioState();
}

class CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.timelineDay,

      dataSource: MeetingDataSource(widget.salagrupo),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      // monthViewSettings: const MonthViewSettings(
      // appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    );
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<SalaGrupo> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).horaDesde;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).horaHasta;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).grupo;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).salaColor;
  }

  SalaGrupo _getMeetingData(int index) {
    final dynamic turno = appointments![index];
    late final SalaGrupo turnosData;
    if (turno is SalaGrupo) {
      turnosData = turno;
    }

    return turnosData;
  }
}
