// Importa la librería Material Design de Flutter
import 'package:flutter/material.dart';
// Importa el modelo Order para crear nuevas instancias
import '../models/order.dart';

// Define la pantalla como StatefulWidget (con estado mutable)
class NewOrderScreen extends StatefulWidget {
  // Constructor constante de la clase
  const NewOrderScreen({super.key});

  // Indica sobrescritura del método createState
  @override
  // Crea y retorna el estado asociado
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

// Clase privada que maneja el estado del formulario
class _NewOrderScreenState extends State<NewOrderScreen> {
  // Key global para validar todo el formulario
  final _formKey = GlobalKey<FormState>();

  // Controlador para el campo de texto del código
  final _codeCtrl = TextEditingController();
  // Controlador para el campo de texto del técnico
  final _techCtrl = TextEditingController();
  // Controlador para el campo de texto de la descripción
  final _descCtrl = TextEditingController();

  // Variable que almacena el área seleccionada (por defecto 'Motor')
  String _area = 'Motor';
  // Variable que almacena la prioridad seleccionada (por defecto 'Media')
  String _priority = 'Media';

  // Método privado para guardar la orden cuando se presiona el botón
  void _save() {
    // Valida todo el formulario, si falla sale del método
    if (!_formKey.currentState!.validate()) return;

    // Crea una nueva instancia de Order con los datos del formulario
    final order = Order(
      // Código: texto del controlador sin espacios al inicio/final
      code: _codeCtrl.text.trim(),
      // Técnico: texto del controlador limpio
      technician: _techCtrl.text.trim(),
      // Área: valor seleccionado en el dropdown
      area: _area,
      // Prioridad: valor seleccionado en el dropdown de prioridad
      priority: _priority,
      // Descripción: texto limpio del controlador de descripción
      description: _descCtrl.text.trim(),
    );

    // Cierra la pantalla y retorna la orden creada a la pantalla anterior
    Navigator.pop(context, order);
  }

  // Indica sobrescritura del método build
  @override
  // Método que construye la interfaz del formulario
  Widget build(BuildContext context) {
    // Estructura básica de la pantalla
    return Scaffold(
      // Barra superior con título y botón de regreso automático
      appBar: AppBar(title: const Text('Nueva Orden')),
      // Cuerpo de la pantalla con padding
      body: Padding(
        // 16 pixels de margen en todos los lados
        padding: const EdgeInsets.all(16),
        // Widget Form que agrupa y valida todos los campos
        child: Form(
          // Asigna la key para poder validar el formulario
          key: _formKey,
          // Columna que organiza los widgets verticalmente
          child: Column(
            // Lista de widgets hijos de la columna
            children: [
              // Primer campo de texto del formulario (CÓDIGO)
              TextFormField(
                // Asigna el controlador del código
                controller: _codeCtrl,
                // Decoración visual del campo
                decoration: const InputDecoration(
                  // Etiqueta que muestra ejemplo del formato esperado
                  labelText: 'Código (OT-0001)',
                  // Borde rectangular alrededor del campo
                  border: OutlineInputBorder(),
                ),
                // Función de validación que recibe el valor del campo
                validator: (v) {
                  // Si está vacío, retorna mensaje de error
                  if (v == null || v.isEmpty) return 'Ingrese código';
                  // Si no inicia con "OT-", retorna mensaje de error
                  if (!v.startsWith('OT-')) return 'Debe iniciar con OT-';
                  // Si pasa las validaciones, retorna null (válido)
                  return null;
                },
              ),
              // Espacio vertical de 12 pixels entre campos
              const SizedBox(height: 12),

              // Segundo campo de texto para el técnico (TÉCNICO)
              TextFormField(
                // Asigna el controlador del técnico
                controller: _techCtrl,
                // Decoración del campo técnico
                decoration: const InputDecoration(
                  // Etiqueta del campo
                  labelText: 'Técnico',
                  // Borde rectangular
                  border: OutlineInputBorder(),
                ),
                // Función de validación concisa (arrow function)
                validator: (v) =>
                    // Si tiene 3+ caracteres es válido, sino muestra error
                    v != null && v.length >= 3 ? null : 'Mínimo 3 caracteres',
              ),
              // Espacio vertical entre campos
              const SizedBox(height: 12),

              // Campo dropdown (lista desplegable) para seleccionar área (ÁREA)
              DropdownButtonFormField<String>(
                // Valor actual seleccionado
                value: _area,
                // Decoración del dropdown
                decoration: const InputDecoration(
                  // Etiqueta del campo
                  labelText: 'Área',
                  // Borde rectangular
                  border: OutlineInputBorder(),
                ),
                // Lista de opciones disponibles para área
                items: const [
                  // Primera opción: Motor
                  DropdownMenuItem(value: 'Motor', child: Text('Motor')),
                  // Segunda opción: Banda
                  DropdownMenuItem(value: 'Banda', child: Text('Banda')),
                  // Tercera opción: Compresor
                  DropdownMenuItem(value: 'Compresor', child: Text('Compresor')),
                  // Cuarta opción: Tablero
                  DropdownMenuItem(value: 'Tablero', child: Text('Tablero')),
                ],
                // Al cambiar selección, actualiza la variable _area (con valor por defecto)
                onChanged: (v) => setState(() => _area = v ?? 'Motor'),
              ),
              // Espacio vertical entre campos
              const SizedBox(height: 12),

              // Campo dropdown para seleccionar prioridad (PRIORIDAD)
              DropdownButtonFormField<String>(
                // Valor actual seleccionado para prioridad
                value: _priority,
                // Decoración del dropdown de prioridad
                decoration: const InputDecoration(
                  // Etiqueta del campo prioridad
                  labelText: 'Prioridad',
                  // Borde rectangular
                  border: OutlineInputBorder(),
                ),
                // Lista de opciones disponibles para prioridad
                items: const [
                  // Primera opción: Baja
                  DropdownMenuItem(value: 'Baja', child: Text('Baja')),
                  // Segunda opción: Media (por defecto)
                  DropdownMenuItem(value: 'Media', child: Text('Media')),
                  // Tercera opción: Alta
                  DropdownMenuItem(value: 'Alta', child: Text('Alta')),
                  // Cuarta opción: Crítica
                  DropdownMenuItem(value: 'Crítica', child: Text('Crítica')),
                ],
                // Al cambiar selección, actualiza la variable _priority
                onChanged: (v) => setState(() => _priority = v ?? 'Media'),
              ),
              // Espacio vertical entre campos
              const SizedBox(height: 12),

              // Campo de texto para la descripción (DESCRIPCIÓN)
              TextFormField(
                // Asigna el controlador de la descripción
                controller: _descCtrl,
                // Campo de múltiples líneas
                maxLines: 3,
                // Decoración del campo descripción
                decoration: const InputDecoration(
                  // Etiqueta del campo
                  labelText: 'Descripción del trabajo',
                  // Texto de ayuda
                  hintText: 'Describa brevemente el trabajo a realizar...',
                  // Borde rectangular
                  border: OutlineInputBorder(),
                ),
                // Validación para la descripción
                validator: (v) {
                  // Si está vacío, retorna mensaje de error
                  if (v == null || v.isEmpty) return 'Ingrese descripción';
                  // Si tiene menos de 10 caracteres, pide más detalle
                  if (v.length < 10) return 'Descripción muy corta (mínimo 10 caracteres)';
                  // Si pasa las validaciones, retorna null (válido)
                  return null;
                },
              ),
              // Espacio vertical antes del botón
              const SizedBox(height: 20),

              // Botón elevado para guardar la orden
              ElevatedButton(
                // Al presionar ejecuta el método _save
                onPressed: _save,
                // Texto del botón
                child: const Text('Guardar Orden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
