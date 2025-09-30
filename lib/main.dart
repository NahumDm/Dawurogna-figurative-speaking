import 'package:dawurogna_figurative_speaking/Core/Route/route_config.dart';
import 'package:dawurogna_figurative_speaking/Provider/proverbs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProverbsProvider()..loadProverbs(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routeProvider,
        title: 'ዳውሮኛ ምሳሌያዊ አነጋገር',
        builder: (context, child) {
          return UpgradeAlert(
            navigatorKey: routeProvider.routerDelegate.navigatorKey,
            child: child ?? Text(''),
          );
        },
      ),
    );
  }
}
