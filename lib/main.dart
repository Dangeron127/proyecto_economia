import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'ui/home_page.dart';

void main() => runApp(const MyApp());
=======

//A ver si se puede agregar un cambio
//Segundo cambio prueba
void main() {
  runApp(const MyApp());
}
//holaaaa comentario de jess neni
//comentario de prueba 2 by jess
>>>>>>> c09ddd3493c7961f6114e5446d05870939c3f7c1

//hola soy karlita torres
//hola otra vez mundooo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}