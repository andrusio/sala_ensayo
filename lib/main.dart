import 'package:flutter/material.dart';
import 'package:sala_ensayo/pages/agenda_page.dart';
import 'package:sala_ensayo/pages/grupos_page.dart';
import 'package:sala_ensayo/pages/personas_page.dart';
import 'package:sala_ensayo/pages/salas_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión Salas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: const MyHomePage(title: Env.nombreComercio),
      initialRoute: '/agenda',
      routes: {
        // '/': (BuildContext context) => const MyApp(),
        '/agenda': (BuildContext context) => const AgendaPage(),
        '/personas': (BuildContext context) => const PersonasPage(),
        '/salas': (BuildContext context) => const SalasPage(),
        '/grupos': (BuildContext context) => const GruposPage(),
        // consumibles
        // equipamiento
      },
      // idioma para calendario
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
      locale: const Locale('es'),
      //fin idioma para calendario
    );
  }
}
