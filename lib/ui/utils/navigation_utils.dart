import 'package:flutter/material.dart';

class NavigationUtils {
  /// Maneja la lógica de navegación del BottomNavigationBar.
  /// [index] es el botón presionado.
  /// [onChanged] es el callback que actualiza el estado en el widget principal.
  /// [context] se usa para disparar el menú de configuración.
  static void handleNavigation(int index, BuildContext context, Function(int) onChanged) {
    if (index == 3) {
      // Si es el índice de "Más", mostramos el menú en lugar de cambiar de vista
      showSettingsMenu(context);
    } else {
      // Si es cualquier otro, actualizamos el índice actual
      onChanged(index);
    }
  }

  /// Despliega el menú de configuración desde la parte inferior.
  static void showSettingsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Wrap(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Opciones", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar Sesión'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}