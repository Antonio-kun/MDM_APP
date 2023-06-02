import 'package:flutter/material.dart';
import 'package:app_mdm/models/cancion.dart';

class AddCancionScreen extends StatefulWidget {
  const AddCancionScreen({Key? key}) : super(key: key);

  @override
  State<AddCancionScreen> createState() => _AddCancionScreenState();
}

class _AddCancionScreenState extends State<AddCancionScreen> {
  Color selectedColor = Colors.primaries.first;
  final TextEditingController nombreController = TextEditingController();
final TextEditingController artistaController = TextEditingController();
final TextEditingController bpmController = TextEditingController();
  String? errorMessage;

  void _onSave() {
    
    
    final nombre = nombreController.text.trim();
    final artista = artistaController.text.trim();
    final bpm = bpmController.text.trim();

    if(nombre.isEmpty || artista.isEmpty || bpm.isEmpty){
      setState(() {
        errorMessage = 'Hay campos vacios';
        print('Campos vacios papu');
      });
      return;
    }else{
      setState(() {
        errorMessage = null;
      });
      final resultado = Cancion(nombre: nombre, artista: artista, bpm: bpm);
      Navigator.of(context).pop(resultado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 2.4,
        width: MediaQuery.of(context).size.width / 1.6,
        child: Container(
  alignment: Alignment.center,        
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: Colors.grey.shade300,
      width: 2,
    ),
  ),
   
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Text(
              "AGREGAR CANCION",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 16),
      TextField(
        controller: nombreController,
        decoration: InputDecoration(
          hintText: 'Nombre',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(color: Colors.black)
        ),
        style: TextStyle(color: Colors.black),
      ),
      SizedBox(height: 16),
      TextField(
        controller: artistaController,
        decoration: InputDecoration(
          hintText: 'Artista',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(12),
          hintStyle: TextStyle(color: Colors.black)
        ),
        style: TextStyle(color: Colors.black),
      ),
      SizedBox(height: 16),
      TextField(
        controller: bpmController,
        decoration: InputDecoration(
          hintText: 'bpm',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.all(12),
          hintStyle: const TextStyle(color: Colors.black)
        ),
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(height: 16),
      MaterialButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Guardar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          onPressed: _onSave,
        ),
                       
    ],
  ),
),

      ),
    );
  }
  Widget padding (Widget widget){
    return Padding(padding: const EdgeInsets.all(7.0), child: widget);
  }
}