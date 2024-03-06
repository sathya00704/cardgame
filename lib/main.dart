import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cardgame/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    );
  }
}
