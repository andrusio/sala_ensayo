import 'package:flutter/material.dart';
import 'package:sala_ensayo/pages/personas_page.dart';
import '../main.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const MyApp(),
    'personas': (BuildContext context) => const PersonasPage(),
  };
}
