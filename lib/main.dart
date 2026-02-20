// Importa la librería Material Design de Flutter que contiene todos los widgets básicos
import 'package:flutter/material.dart';
// Importa el archivo que contiene la pantalla principal (HomeScreen)
import 'screens/home_screen.dart';

// Función principal de la aplicación, punto de entrada de toda app Flutter
void main() {
  // Ejecuta la aplicación Flutter, pasando MyApp como widget raíz
  runApp(const MyApp());
}

// Define la clase MyApp que hereda de StatelessWidget (widget sin estado)
class MyApp extends StatelessWidget {
  // Constructor constante que recibe la key opcional del widget padre
  const MyApp({super.key});

  // Anotación que indica que se está sobrescribiendo un método del padre
  @override
  // Método que construye y retorna la interfaz del widget
  Widget build(BuildContext context) {
    // Retorna un MaterialApp (la raíz de apps Material Design)
    return MaterialApp(
      // Oculta el banner "DEBUG" en la esquina superior derecha
      debugShowCheckedModeBanner: false,
      // Título de la aplicación (aparece en el task manager)
      title: 'Órdenes',
      // Define el tema visual de la aplicación
      theme: ThemeData(
        // Activa Material Design 3 (la versión más reciente)
        useMaterial3: true,
        // Define indigo como color semilla para generar la paleta de colores
        colorSchemeSeed: Colors.indigo,
      ),
      // Establece HomeScreen como la pantalla inicial
      home: const HomeScreen(),
    );
  }
}
