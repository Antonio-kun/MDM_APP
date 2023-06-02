import 'package:app_mdm/models/preset.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Cancion{
  @Id()
  int id = 0;
  String nombre;
  String artista;
  String bpm;
  String? letra;
  bool favorito = false;
  bool setlist = false;

 
  Cancion({
      required this.artista, 
      required this.nombre,
      required this.bpm,
  });

  @Backlink()
  final presets = ToMany<Preset>();
  
  get key => null;
}

