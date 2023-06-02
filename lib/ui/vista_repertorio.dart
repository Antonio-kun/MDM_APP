
import 'package:app_mdm/ui/vista_cancion.dart';
import 'package:flutter/material.dart';
import 'package:app_mdm/models/cancion.dart';
import 'package:app_mdm/ui/agregar_cancion.dart';
import 'package:objectbox/objectbox.dart';


import '../main.dart';
import '../models/preset.dart';
import '../objectbox.g.dart'; 

//-------------------------------------------------------
bool _isIconVisible = false;
bool banderaFav = false;
bool banderaList = false;
bool banderaRep = true;

class VistaRepertorio extends StatefulWidget {
  const VistaRepertorio({super.key});

  @override
  State<VistaRepertorio> createState() => _VistaRepertorioState();
}

class _VistaRepertorioState extends State<VistaRepertorio> {
 
  final _canciones = <Cancion>[];

  
  
  void _toggleIconVisibility() {
    setState(() {
      _isIconVisible = !_isIconVisible;
    });
  }

  //////////////////METODOS DE BASE DE DATOS/////////////////////////7
  
 final cancionBox = objectbox.store.box<Cancion>();
 final presetBox = objectbox.store.box<Preset>();
 
  Future<void> _addCancion() async{
    
      final resultado = await showDialog(
      context: context, 
      builder: (_) => const AddCancionScreen()
      );
      if(resultado != null){
        cancionBox.put(resultado);
      }
      loadCanciones();
      print (resultado);
  } 

  void eliminarCancion(Cancion cancion) {
  //  print('Siiiiii por fin borra esta wea') ;
    cancion.presets.forEach((preset) => presetBox.remove(preset.id));
    cancionBox.remove(cancion.id); 
    loadCanciones(); //actualiza la pantalla
  }

  void loadCanciones() {

       _canciones.clear();
    if(banderaRep == true){
        banderaFav = false;
        banderaList = false;
        setState(() {
          _canciones.addAll(cancionBox.getAll());
        });

    }else if(banderaFav = true){
        banderaRep = false;
        banderaList = false;

        for (final cancion in cancionBox.getAll()) {
        if (cancion.favorito == true) {
            setState(() {
            _canciones.add(cancion);
            });
          }
        }

    }else if(banderaList == true){
        banderaFav = false;
        banderaRep = false;

        for (final cancion in cancionBox.getAll()) {
          if (cancion.setlist == true) {
              setState(() {
              _canciones.add(cancion);
              });
            }
          }
    }
   
        setState(() {
        
        });
  }



    @override
  void initState() {
    loadCanciones();
    super.initState();
    
  }

  @override
  void dispose() {
    objectbox.store.close();
    super.dispose();
  }




   


  

  @override
  Widget build(BuildContext context) {
    final GlobalKey popupMenuKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Buscar rolita...',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            prefixStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.my_library_music),
            onPressed: () {
               banderaFav = false;
               banderaList = false;
               banderaRep = true;
              loadCanciones();
              print('Repertorioooooo');
            },
          ),
          IconButton(
            icon:const Icon(Icons.favorite),
            onPressed: () {
                banderaFav = true;
               banderaList = false;
               banderaRep = false;
               loadCanciones();
               print('Faaaaaaaaaaavs');
            },
          ),
          IconButton(
            icon:const Icon(Icons.check_box),
            onPressed: () {
               banderaFav = false;
               banderaList = true;
               banderaRep = false;
               loadCanciones();
               print('Listaaaaaaa');
            },
          ),
        ],
      ),
      body: _canciones.isEmpty
          ? const Center(child: Text('No hay canciones'))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 90,
              ),
              itemCount: _canciones.length,
              itemBuilder: (BuildContext context, int index) {
                final cancion = _canciones[index];
                return _CancionItem(
                  cancion: cancion,
                  onDelete: () => eliminarCancion(cancion), 
                 
                );
              },
            ),
      floatingActionButton: PopupMenuButton(
        key: popupMenuKey,
        offset: const Offset(-45, 0),
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                // Lógica para el primer botón flotante
                popupMenuKey.currentState?.activate();
                _addCancion();
              },
              label:const Text('Agregar Canción'),
              icon:const Icon(Icons.add),
            ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                // Lógica para el segundo botón flotante
                _toggleIconVisibility();
              },
              label: const Text('Eliminar Canción'),
              icon: const Icon(Icons.delete),
            ),
          ),
          
        ],
        child: const FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: null ,
          child: Icon(Icons.settings),
        ),
      ),
    );
  }
}

class _CancionItem extends StatelessWidget {
  


   _CancionItem({
    required this.cancion,
    required this.onDelete,
   
    Key? key,
  }) : super (key: key);

  final Cancion cancion;
  final VoidCallback onDelete;


  @override
  Widget build(BuildContext context) {
     return InkWell(
      onTap: (){
     //   aqui redirecciona
    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VistaCancion(cancion: cancion,),
          ),
        ); 
      }, 
      child: Builder(
        builder: (BuildContext context) {
          return Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Icon(Icons.queue_music),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cancion.nombre,
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 6.0),
              Text(
                cancion.artista.toUpperCase(),
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "BPM",
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 6.0),
            Text(
              cancion.bpm,
              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Visibility(
          visible: _isIconVisible,
          child: IconButton(
            onPressed: () {
              // Aquí puedes agregar la lógica para mostrar el icono
              onDelete();
            },
            icon: const Icon(Icons.delete),
          ),
        )
      ],
    ),
  ),
);
        },
      ),
    );
 
  }
}