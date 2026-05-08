import 'package:flutter/material.dart';
//A ver si se puede agregar un cambio
void main() {
  runApp(const MyApp());
}
//holaaaa comentario de jess neni

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget es la raíz de tu aplicación.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Este es el tema de tu aplicación.
        //
        // PRUEBA ESTO: Ejecuta tu aplicación con "flutter run". Verás
        // que la aplicación tiene una barra de herramientas morada. Luego, sin
        // cerrar la app, intenta cambiar el seedColor en el colorScheme de abajo
        // a Colors.green y luego invoca "hot reload" (guarda tus cambios o presiona
        // el botón "hot reload" en un IDE compatible con Flutter, o presiona "r"
        // si usaste la línea de comandos para iniciar la app).
        //
        // Observa que el contador no se reinició a cero; el estado de la aplicación
        // no se pierde durante la recarga. Para reiniciar el estado, usa hot
        // restart en su lugar.
        //
        // Esto funciona para el código también, no solo para valores: La mayoría de los cambios de código
        // pueden probarse con solo un hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // Este widget es la página principal de tu aplicación. Es stateful, lo que significa
  // que tiene un objeto State (definido abajo) que contiene campos que afectan
  // cómo se ve.

  // Esta clase es la configuración para el estado. Contiene los valores (en este
  // caso el título) proporcionados por el padre (en este caso el widget App) y
  // usados por el método build del State. Los campos en una subclase de Widget son
  // siempre marcados como "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
