import 'package:dawurogna_figurative_speaking/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'ዳውሮኛ ምሳሌያዊ አነጋገር', home: Onboarding());
  }
}
