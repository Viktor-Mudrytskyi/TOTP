import 'package:flutter/material.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/codes/screens/codes_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDI();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      home: const CodesScreen(),
    );
  }
}
