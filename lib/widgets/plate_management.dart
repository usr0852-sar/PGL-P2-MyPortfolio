import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Plate {
  final String nombre;
  final String descripcion;
  final String categoria;

  Plate(this.nombre, this.descripcion, this.categoria);

  String get imagen => switch (categoria) {
        'Entrante' => 'assets/images/entrantes.jpg',
        'Principal' => 'assets/images/principales.jpg',
        'Postre' => 'assets/images/postres.jpg',
        _ => '',
      };
}

const categorias = ['Entrante', 'Principal', 'Postre'];

class PlateManagement extends StatefulWidget {
  const PlateManagement({super.key});

  @override
  State<PlateManagement> createState() => _PlateManagementState();
}

class _PlateManagementState extends State<PlateManagement> {
  final List<Plate> elementos = [];

  Future<void> _anadir() async {
    final nombre = TextEditingController();
    final descripcion = TextEditingController();
    String categoria = categorias.first;
    bool nombreVacio = false;

    final elemento = await showDialog<Plate>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          backgroundColor: const Color(0xFFFFF8F1),
          title: const Text(
            'Añadir plato',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF463521),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombre,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    errorText: nombreVacio ? 'Campo obligatorio' : null,
                  ),
                ),
                TextField(
                  controller: descripcion,
                  maxLength: 60,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                DropdownButton<String>(
                  value: categoria,
                  isExpanded: true,
                  items: [
                    for (final cat in categorias)
                      DropdownMenuItem(value: cat, child: Text(cat)),
                  ],
                  onChanged: (nuevaCategoria) =>
                      setStateDialog(() => categoria = nuevaCategoria!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Color(0xFFBAB6B1)),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC92A2A),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
              onPressed: () {
                if (nombre.text.trim().isEmpty) {
                  setStateDialog(() => nombreVacio = true);
                  return;
                }
                Navigator.pop(
                  context,
                  Plate(
                    nombre.text.trim(),
                    descripcion.text.trim(),
                    categoria,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    if (elemento != null) setState(() => elementos.add(elemento));
  }

  void _borrar(int indice) {
    setState(() => elementos.removeAt(indice));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Plato eliminado correctamente'),
        backgroundColor: Color(0xB300BF63),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          'Gestión de platos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7ED957),
        foregroundColor: const Color(0xFF463521),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'Total: ${elementos.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: elementos.isEmpty
          ? const Center(
              child: Text('No hay platos. Pulsa el botón + para añadir uno.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: elementos.length,
              itemBuilder: (context, indice) {
                final plato = elementos[indice];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF751F),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    leading: plato.imagen.isEmpty
                        ? const Icon(Icons.restaurant, size: 44)
                        : Image.asset(
                            plato.imagen,
                            width: 44,
                            height: 44,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.restaurant, size: 44),
                          ),
                    title: Text(
                      plato.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF463521),
                      ),
                    ),
                    subtitle: Text(
                      '${plato.categoria} · ${plato.descripcion}',
                      style: const TextStyle(color: Color(0xFF463521)),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Color(0xFFC92A2A)),
                      onPressed: () => _borrar(indice),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _anadir,
        backgroundColor: const Color(0xFFC92A2A),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}