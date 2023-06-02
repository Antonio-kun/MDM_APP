import 'package:flutter/material.dart';
import 'package:app_mdm/models/preset.dart';

List<TextEditingController> controllers = [];

class AddPresetScreen extends StatefulWidget {
  final String titulo;
  

  const AddPresetScreen({required this.titulo, key}) : super(key: key);
  

  @override
  State<AddPresetScreen> createState() => _AddPresetScreenState();
}

class _AddPresetScreenState extends State<AddPresetScreen> {
 Color selectedColor = Colors.primaries.first;

  String? errorMessage;

 
 late final List<String> ajustes_titulo = ['1', '2', '3'];

  


  void _onSave() {
    
    
    List<String> params = controllers.map((controller) => controller.text.trim()).toList();

  final resultado = Preset(
   param1:  params.isNotEmpty ? params[0] : null,
   param2:  params.length > 1 ? params[1] : null,
   param3:  params.length > 2 ? params[2] : null,
   param4:  params.length > 3 ? params[3] : null,
   param5:  params.length > 4 ? params[4] : null,
   param6:  params.length > 5 ? params[5] : null,
   param7:  params.length > 6 ? params[6] : null,
   param8:  params.length > 7 ? params[7] : null,
  param9:   params.length > 8 ? params[8] : null,
   param10:  params.length > 9 ? params[9] : null,
   nombre:  widget.titulo,
  );
  
      setState(() {
        for (var controller in controllers) {
          controller.clear();
        }
        for (var i = 0; i < ajustes_titulo.length; i++) {
          controllers.add(TextEditingController());
        }
        params.clear();
        params = controllers.map((controller) => controller.text.trim()).toList();
      });
      Navigator.of(context).pop(resultado);
    
  }

  @override
  void initState() {
    super.initState();
  ajustes_titulo.clear();
    //Si se agregan más hardware aqui se deben de agregar tambien
    if(widget.titulo == 'pedalera'){
      ajustes_titulo.clear();
      ajustes_titulo.add('Pickup');
      ajustes_titulo.add('Wah');
      ajustes_titulo.add('Compressor');
      ajustes_titulo.add('Distortion');
      ajustes_titulo.add('Amplifier');
      ajustes_titulo.add('Equalizer');
      ajustes_titulo.add('Noise Gate');
      ajustes_titulo.add('FX');
      ajustes_titulo.add('Delay');
      ajustes_titulo.add('Reverb');  
    } else if(widget.titulo == 'chorus'){
      ajustes_titulo.clear();
        ajustes_titulo.add('Depth');
        ajustes_titulo.add('Speed');
        ajustes_titulo.add('Blend');
    }else if(widget.titulo == 'flanger'){
      ajustes_titulo.clear();
        ajustes_titulo.add('Manual');
        ajustes_titulo.add('Depth');
        ajustes_titulo.add('Rate');
        ajustes_titulo.add('Mode');
    }else if(widget.titulo == 'fuzz'){
      ajustes_titulo.clear();
        ajustes_titulo.add('Volume');
        ajustes_titulo.add('Tone');
        ajustes_titulo.add('Sustain');
    }
    else if(widget.titulo == 'overdrive'){
      ajustes_titulo.clear();
        ajustes_titulo.add('Level');
        ajustes_titulo.add('Tone');
        ajustes_titulo.add('Drive');
        ajustes_titulo.add('Mode');
    }else if(widget.titulo == 'vox'){
      ajustes_titulo.clear();
        ajustes_titulo.add('Category');
        ajustes_titulo.add('Gain');
        ajustes_titulo.add('Level');
    }else if(widget.titulo == 'runbul'){
      ajustes_titulo.clear();
      ajustes_titulo.add('Gain');
      ajustes_titulo.add('Botón');
      ajustes_titulo.add('Drive');
      ajustes_titulo.add('Level');
      ajustes_titulo.add('Bass');
      ajustes_titulo.add('Low Mid');
      ajustes_titulo.add('High Mid');
      ajustes_titulo.add('Treble');
    }else if(widget.titulo == 'pad'){
      ajustes_titulo.clear();
      ajustes_titulo.add('Pad 1');
      ajustes_titulo.add('Pad 2');
      ajustes_titulo.add('Pad 3');
      ajustes_titulo.add('Pad 4');
      ajustes_titulo.add('Trigger 1');
      ajustes_titulo.add('Trigger 2');
      ajustes_titulo.add('Preset');
    }else if(widget.titulo == 'percusion'){
      ajustes_titulo.clear();
      ajustes_titulo.add('Pandero');
      ajustes_titulo.add('Baquetas');
      ajustes_titulo.add('Ahogador');
      ajustes_titulo.add('Otro');
    }


    // Aquí inicializamos los controladores de los TextField
    for (var i = 0; i < ajustes_titulo.length; i++) {
      controllers.add(TextEditingController());
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
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.grey.shade300,
      width: 2,
    ),
  ),
   
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
       Text(
              "CONFIGURAR ${widget.titulo.toUpperCase()}",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            SizedBox(height: 16),
      ///////////////////////////////////// Inputs dinamicos
       Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ajustes_titulo.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: TextField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            hintText: ajustes_titulo[index],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: EdgeInsets.all(12),
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
      const SizedBox(height: 16),
      MaterialButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          child:  Padding(
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