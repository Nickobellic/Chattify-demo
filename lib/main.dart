import 'package:flutter/material.dart';
import './chat/ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  if(kIsWeb) { // Mobile View
    runApp(const WebApp());
  } else { // Web View
  runApp(const MyApp());
  }
}

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Hello World, running on Web", textDirection: TextDirection.ltr,),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  TaskWidget(),
    );
  }
}