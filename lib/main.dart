import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Clase principal y los widgets(constructores)
class MyApp extends StatelessWidget {
  @override
  //Constructor permite ver parte visual(colores, fondos, etc)
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      //Pagina principal
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controladores
  final TextEditingController _controller = TextEditingController();

  //Listas con nombres
  List<String> _items = [];
  int? _editingIndex;

  //Guardando los nombres
  void _saveItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_editingIndex == null) {
        //añadir el nombre
        _items.add(text);
      } else {
        //se pondria con su mismo nombre
        _items[_editingIndex!] = text;
        _editingIndex = null;
      }
      _controller.clear();
    });
  }

  //editar el nombre
  void _editItem(int index) {
    setState(() {
      _controller.text = _items[index];
      _editingIndex = index;
    });
  }

  //eliminar los nombres
  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
      if (_editingIndex == index) {
        _controller.clear();
        _editingIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editingIndex != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Oscuro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: const Color.fromARGB(255, 215, 9, 9)),
              decoration: InputDecoration(
                hintText: 'Escribe algo...',
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveItem,
                icon: Icon(isEditing ? Icons.edit : Icons.add),
                label: Text(isEditing ? 'Actualizar' : 'Agregar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        _items[index],
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _editItem(index),
                            icon: Icon(Icons.edit,
                                color: const Color.fromARGB(255, 143, 0, 245)),
                          ),
                          IconButton(
                            onPressed: () => _deleteItem(index),
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
