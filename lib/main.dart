import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For managing device orientation
import 'package:cardgame/screens/home.dart'; // Importing the Home screen

// Entry point of the Flutter application
void main() {
  // Ensure that Flutter bindings are initialized before other setups
  WidgetsFlutterBinding.ensureInitialized();

  // Set the preferred device orientations for the app to landscape
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft, // Landscape orientation with the device held to the left
    DeviceOrientation.landscapeRight, // Landscape orientation with the device held to the right
  ]);

  // Start the Flutter application
  runApp(const MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Builds the widget tree for the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disables the debug banner in the top right corner
      initialRoute: '/', // Sets the initial route for the application
      routes: {
        '/': (context) => Home(), // Maps the root route to the Home screen
      },
    );
  }
}
