import 'package:flutter/material.dart';
import 'package:learn_flut/responsive/responsive.dart';
import './chat/ui.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: ResponsiveLayout(
//         desktopBody: WebAccountListWidget(),
//         mobileBody: TaskWidget(),
//       ),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage.platformSpecificUI(context),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage {
  static Widget platformSpecificUI(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return const TaskWidget(); // Adding 'const' keyword
    } else {
      return const WebAccountListWidget(); // Pass the context to the WebAccountListWidget
    }
  }
}
