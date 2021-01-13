import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:di_lenguaje_smx/screens/inicio.dart';
import 'package:di_lenguaje_smx/screens/camara.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      routes: {
        '/inicio': (context) => Inicio(),
        '/camara': (context) => CameraScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Reconocimiento de LSM',
      home: Inicio()));
}
