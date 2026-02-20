// Importa la librería Material Design de Flutter
import 'package:flutter/material.dart';
// Importa el modelo Order desde la carpeta models (usa ../ para subir un nivel)
import '../models/order.dart';
// Importa la pantalla para crear nuevas órdenes
import 'new_order_screen.dart';

// Define HomeScreen como StatefulWidget (widget con estado que puede cambiar)
class HomeScreen extends StatefulWidget {
  // Constructor constante de HomeScreen
  const HomeScreen({super.key});

  // Indica sobrescritura del método createState
  @override
  // Crea y retorna el estado asociado a este widget
  State<HomeScreen> createState() => _HomeScreenState();
}

// Clase privada que maneja el estado de HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  // Lista privada que almacena todas las órdenes creadas (inicialmente vacía)
  final List<Order> _orders = [];

  // Método asíncrono privado para navegar a la pantalla de nueva orden
  Future<void> _goToNewOrder() async {
    // Navega a NewOrderScreen y espera que retorne una Order (nullable)
    final Order? newOrder = await Navigator.push<Order>(
      // Pasa el contexto actual para la navegación
      context,
      // Crea la ruta hacia NewOrderScreen
      MaterialPageRoute(builder: (_) => const NewOrderScreen()),
    );

    // Verifica si se retornó una orden válida (no cancelada)
    if (newOrder != null) {
      // Agrega la nueva orden a la lista y actualiza la UI
      setState(() => _orders.add(newOrder));
      // Muestra un mensaje en la parte inferior de la pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        // El contenido del mensaje de confirmación
        const SnackBar(content: Text('Orden agregada')),
      );
    }
  }

  // Indica sobrescritura del método build
  @override
  // Método que construye la interfaz de la pantalla
  Widget build(BuildContext context) {
    // Retorna un Scaffold (estructura básica de pantalla Material)
    return Scaffold(
      // Barra superior con el título de la pantalla
      appBar: AppBar(title: const Text('Órdenes de Mantenimiento')),
      // Botón flotante circular en la esquina inferior derecha
      floatingActionButton: FloatingActionButton(
        // Al presionar ejecuta el método para crear nueva orden
        onPressed: _goToNewOrder,
        // Icono "+" dentro del botón flotante
        child: const Icon(Icons.add),
      ),
      // Cuerpo de la pantalla: condicional basado en si hay órdenes
      body: _orders.isEmpty
          // Si no hay órdenes, muestra texto centrado
          ? const Center(child: Text('No hay órdenes registradas'))
          // Si hay órdenes, muestra una lista scrolleable
          : ListView.builder(
              // Padding de 12 pixels en todos los lados de la lista
              padding: const EdgeInsets.all(12),
              // Número de elementos en la lista (cantidad de órdenes)
              itemCount: _orders.length,
              // Constructor de cada elemento de la lista con su índice
              itemBuilder: (context, index) {
                // Obtiene la orden en la posición actual del índice
                final o = _orders[index];
                // Retorna un Card (tarjeta con sombra) para cada orden
                return Card(
                  // Dentro del Card va un ListTile (elemento estándar de lista)
                  child: ListTile(
                    // Título del ListTile: código de la orden
                    title: Text(o.code),
                    // Subtítulo: área y prioridad separados por un punto
                    subtitle: Text('${o.area} • ${o.priority}'),
                  ),
                );
              },
            ),
    );
  }
}
