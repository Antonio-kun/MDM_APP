//import 'package:app_mdm/models/preset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app_mdm/models/cancion.dart';
import 'package:app_mdm/ui/agregar_preset.dart';
import '../main.dart';
import 'package:flutter/scheduler.dart';
import '../models/preset.dart';
import '../objectbox.g.dart';
//import 'package:app_mdm/ui/agregar_cancion.dart';



class VistaCancion extends StatefulWidget {
//  const VistaCancion({super.key});
  final Cancion cancion;
  //final Store store;

   VistaCancion({required this.cancion, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<VistaCancion> createState() => _VistaCancionState(cancion: cancion,);
}

class _VistaCancionState extends State<VistaCancion> {
// Preset? chorus, pedalera, flanger, fuzz, overdrive, vox, runble, pad, percusion;
final Cancion cancion;
String? _selectedItem ;
List<Widget> _images = [];
List<String> _dropdownItems = [  'Guitarra (I)',  'Guitarra (H)',  'Bajo',  'Bateria'];
List<String> _titulos = [];
List<Preset> _presets = <Preset>[];
late Preset chorus, pedalera, flanger, fuzz, overdrive, vox, runble, pad, percusion;

ScrollController _controller = ScrollController();
double _posicion_scroll = 0.0;


  _VistaCancionState( {required this.cancion,});

  void _scrollListener() {
  setState(() {
    _posicion_scroll = _controller.offset;
  });
}
final cancionBox = objectbox.store.box<Cancion>();

void _setLista(bool bandera) async{
    
      Cancion? rolilla = cancionBox.get(cancion.id) ;

      if(rolilla != null){
        
        if (bandera = true){
        rolilla.favorito = !rolilla.favorito;
          cancionBox.put(rolilla);

        }else if (bandera = false){
          rolilla.setlist = !rolilla.setlist;
          cancionBox.put(rolilla);
        }

      }
   
  } 

Future<void> _addPreset(String titulo) async{
    
      final resultado = await showDialog(
      context: context, 
      builder: (_) =>  AddPresetScreen(titulo: titulo)
      );
      if(resultado != null){
        // Agregar el objeto Preset al conjunto de presets en la Cancion
        cancion.presets.add(resultado);
        cancionBox.put(cancion);

        setState(() {
          loadPresets();
        });
      }
   
  } 

  
  

  void _updateImages() {
  // Limpia la lista de imágenes
    _images.clear();

    // Agrega las imágenes correspondientes a la opción seleccionada
    //Se debe agregar hardware nuevo aqui
     if (_selectedItem == 'Guitarra (I)') {
      _titulos = ['pedalera'];
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          //color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/pedalera.png'),
      ));
    } else if (_selectedItem == 'Guitarra (H)') {
      _titulos = ['chorus', 'flanger', 'fuzz', 'overdrive'];
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
       //   color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/chorus.png'),
      ));
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        //  color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/flanger.png'),
      ));
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
       //   color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/fuzz.png'),
      ));
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
       //   color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/overdrive.png'),
      ));
    } else if (_selectedItem == 'Bajo') {
      _titulos = ['vox', 'runbul'];
      _images.add(Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
       //   color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/vox.png'),
      ));
      _images.add(Container(
        width: 350,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
 //         color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/rumble.png'),
      ));
    } else if (_selectedItem == 'Bateria') {
      _titulos = ['pad', 'percusion'];
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
       //   color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/pad.png'),
      ));
      _images.add(Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
      //    color: Colors.grey[200],
        ),
        child: Image.asset('assets/img/pandero.png'),
      ));
    }
    // Actualiza el estado para reflejar los cambios en la UI
    setState(() {});
  }




  @override
  void initState() {
    _images = [];
    _titulos = [];
   _presets = [];
   loadPresets();

   

    super.initState();
    _controller.addListener(_scrollListener);
  }

  void loadPresets() {
    _presets.clear();
    for (var preset in cancion.presets) {
        _presets.add(preset);
    }
    if(_presets.isNotEmpty){
      //llenar aqui las variables de presets
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      title: null,
      actions: [
        Container(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: DropdownButton<String>(
              value: _selectedItem,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 25,
              elevation: 25,
              style: TextStyle(color: Colors.white),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedItem = newValue!;
                  // Actualiza la lista de imágenes según la opción seleccionada
                  _updateImages();
                });
              },
              isExpanded: true, 
              items: _dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        IconButton( //Icono de agregar a favoritos
           icon: Icon(
            cancion.favorito 
              ? Icons.favorite  
              : Icons.favorite_border_outlined, // Si cancion.favorito es true, el ícono es Icons.favorite, si es false, el ícono es Icons.favorite_border_outlined
            color: Colors.white,
          ),
          onPressed: () {
            _setLista(true);
            loadPresets();
          },
        ),
        IconButton( //Icono de agregar a setlist
          icon: Icon(
            cancion.setlist 
              ? Icons.check_box  
              : Icons.check_box_outline_blank, // Si cancion.favorito es true, el ícono es Icons.favorite, si es false, el ícono es Icons.favorite_border_outlined
            color: Colors.white,
          ),
          onPressed: () {
          _setLista(false);
          loadPresets();
          },
        ),
      ],
          ),
          body: SingleChildScrollView(
          child:
          Center(
            child: Column(
              children: [
                  SizedBox(height: 20), // Espacio vacío para separar del borde superior
                  Text(
                    cancion.nombre,
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold,),
                    
                  ),
                  SizedBox(height: 10),
                  Text(
                    cancion.artista.toUpperCase(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    cancion.bpm + ' bpm',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const  SizedBox(height: 20), // Espacio vacío para separar del borde inferior
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: _controller, 
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _images
                      ),
                    ),
                    SizedBox(height: 20), 
                    
                    
                    // Espacio vacío para separar del borde superior

                    Column(
                      children: [
                          _selectedItem == null
                      ? const Text('')
                      : _selectedItem == 'Guitarra (I)'
                          ? _posicion_scroll <= 225
                              ? buscarPreset('pedalera')
                              : nada()
                          : _selectedItem == 'Guitarra (H)'
                              ? _posicion_scroll <= 225
                                  ? buscarPreset('chorus')
                                  : _posicion_scroll > 225 && _posicion_scroll < 600  
                                      ? buscarPreset('flanger')
                                      : _posicion_scroll > 600 && _posicion_scroll < 1050  
                                          ? buscarPreset('fuzz')
                                          : _posicion_scroll > 1050 && _posicion_scroll < 1400  
                                              ? buscarPreset('overdrive')
                                              : nada()
                              : _selectedItem == "Bajo"
                                  ? _posicion_scroll <= 225
                                      ? buscarPreset('vox')
                                      : _posicion_scroll > 225 && _posicion_scroll < 600  
                                          ? buscarPreset('runbul')
                                          : nada()
                                  : _selectedItem == 'Bateria'
                                      ? _posicion_scroll <= 225
                                          ? buscarPreset('pad')
                                          : _posicion_scroll > 225 && _posicion_scroll < 600  
                                              ? buscarPreset('percusion')
                                              : nada()
                                      : nada()
                      ],
                    ),
                    SizedBox(height: 40), 
              ],
            ),
          ),
          )
          
    );

  }

  Widget buscarPreset(String nombre) {
  
  List<Preset> sihay = [];
  List<String> miListaDeTextos = ['holis', 'holis'];

  for (var preset in _presets) {
    if (preset.nombre == nombre) {
      sihay.clear();
      sihay.add(preset);
      miListaDeTextos.clear();
      if(nombre == 'pedalera'){
          miListaDeTextos.clear();
          miListaDeTextos = ['Pickup: ${sihay[0].param1}', 'Wah: ${sihay[0].param2}', 'Compressor: ${sihay[0].param3}','Distortion: ${sihay[0].param4}', 'Amplifier: ${sihay[0].param5}', 'Equalizer: ${sihay[0].param6}','Noise Gate: ${sihay[0].param7}', 'FX: ${sihay[0].param8}', 'Delay: ${sihay[0].param9}', 'Reverb: ${sihay[0].param10}'];
      }else if(nombre == 'chorus' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Depth: ${sihay[0].param1}', 'Speed: ${sihay[0].param2}', 'Blend: ${sihay[0].param3}'];
      }else if(nombre == 'flanger' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Manual: ${sihay[0].param1}', 'Depth: ${sihay[0].param2}', 'Rate: ${sihay[0].param3}', 'Mode: ${sihay[0].param3}'];
      }else if(nombre == 'fuzz' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Volume: ${sihay[0].param1}', 'Tone: ${sihay[0].param2}', 'Sustain: ${sihay[0].param3}'];
      }else if(nombre == 'overdrive' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Level: ${sihay[0].param1}', 'Tone: ${sihay[0].param2}', 'Drive: ${sihay[0].param3}', 'Mode: ${sihay[0].param3}'];
      }else if(nombre == 'vox' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Category: ${sihay[0].param1}', 'Gain: ${sihay[0].param2}', 'Level: ${sihay[0].param3}'];
      }else if(nombre == 'runbul' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Gain: ${sihay[0].param1}', 'Botón: ${sihay[0].param2}', 'Drive: ${sihay[0].param3}','Level: ${sihay[0].param4}', 'Bass: ${sihay[0].param5}', 'Low Mid: ${sihay[0].param6}','High Mid: ${sihay[0].param7}', 'Treble: ${sihay[0].param8}'];
      }else if(nombre == 'pad' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Pad 1: ${sihay[0].param1}', 'Pad 2: ${sihay[0].param2}', 'Pad 3: ${sihay[0].param3}','Pad 4: ${sihay[0].param4}', 'Trigger 1: ${sihay[0].param5}', 'Trigger 2: ${sihay[0].param6}','Preset: ${sihay[0].param7}'];
      }else if(nombre == 'percusion' ){
          miListaDeTextos.clear();
          miListaDeTextos = ['Pandero: ${sihay[0].param1}', 'Baquetas: ${sihay[0].param2}', 'Ahogador: ${sihay[0].param3}', 'Otro: ${sihay[0].param3}'];
      }
    }
  }


  

  if (sihay.isEmpty){
    return ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al presionar el botón
                    _posicion_scroll <= 225
                     ? _addPreset(_titulos[0])
                      : _posicion_scroll > 225 && _posicion_scroll < 600  
                        ? _titulos.length > 1
                          ? _addPreset(_titulos[1])
                          : 'Ya no hay más papu'
                        : _posicion_scroll > 600 && _posicion_scroll < 1050  
                          ? _titulos.length > 2
                            ? _addPreset(_titulos[2])
                            : 'Ya no hay más papu'
                          : _posicion_scroll > 1050 && _posicion_scroll < 1400  
                            ? _titulos.length > 3
                              ? _addPreset(_titulos[3])
                              : 'Ya no hay más papu'
                            : print('Error');
                  },
                  
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  
                  child: Text(
                 // 'Offset: ${_posicion_scroll.toString()}'
                 _titulos.isEmpty
                  ? ''
                  :_posicion_scroll <= 225
                     ? 'Configurar ' + _titulos[0]
                      : _posicion_scroll > 225 && _posicion_scroll < 600  
                        ? _titulos.length > 1
                          ? 'Configurar ' +_titulos[1]
                          : 'Ya no hay más papu'
                        : _posicion_scroll > 600 && _posicion_scroll < 1050  
                          ? _titulos.length > 2
                            ? 'Configurar ' +_titulos[2]
                            : 'Ya no hay más papu'
                          : _posicion_scroll > 1050 && _posicion_scroll < 1400  
                            ? _titulos.length > 3
                              ? 'Configurar ' +_titulos[3]
                              : 'Ya no hay más papu'
                            :'Ya no hay más papu'  
                ),
                );
  }else{
    loadPresets();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: miListaDeTextos.map((text) => Center(child: 
      Text(
         style: TextStyle(
            fontSize: 20.0, // tamaño de fuente deseado
          ),
        text)
      )).toList(),
    );  
  }

  }

  nada() {}
}

  
  

