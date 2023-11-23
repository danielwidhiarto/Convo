import 'package:convo/firebase_options.dart';
import 'package:convo/pages/login_page.dart';
import 'package:convo/pages/register_page.dart';
import 'package:convo/services/auth/auth_gate.dart';
import 'package:convo/services/auth/auth_services.dart';
import 'package:convo/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}