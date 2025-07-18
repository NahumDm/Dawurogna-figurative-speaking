import 'package:dawurogna_figurative_speaking/Core/Route/route_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routeProvider,
      title: 'ዳውሮኛ ምሳሌያዊ አነጋገር',
    );
  }
}
