import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:renttech/Flash.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Rent Tech",
      home: Flash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
