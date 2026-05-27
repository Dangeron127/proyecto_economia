import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'services/finance_service.dart';

//Main Limpio
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FinanceService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Finance App Concept',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
