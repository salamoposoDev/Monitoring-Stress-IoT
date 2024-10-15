import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_stress/screens/dashboard/dashboard.dart';
import 'package:monitoring_stress/firebase_options.dart';
import 'package:monitoring_stress/screens/dashboard/widgets/custom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blue,
        ),
      ),
      home: CustomNavbar(),
    );
  }
}
