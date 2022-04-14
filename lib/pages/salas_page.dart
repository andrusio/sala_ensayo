import 'package:flutter/material.dart';
import 'package:sala_ensayo/widgets/panel_lateral_widget.dart';

class SalasPage extends StatefulWidget {
  const SalasPage({Key? key}) : super(key: key);

  @override
  _SalasPageState createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salas'),
        centerTitle: true,
      ),
      drawer: const PanelLateralWidget(),
    );
  }
}
