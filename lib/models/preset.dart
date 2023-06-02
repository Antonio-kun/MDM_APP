import 'package:objectbox/objectbox.dart';
import 'cancion.dart';

@Entity()
class Preset {

  @Id()
  int id = 0 ;

  String nombre;
  String? param1;
  String? param2;
  String? param3;
  String? param4;
  String? param5;
  String? param6;
  String? param7;
  String? param8;
  String? param9;
  String? param10;

  Preset({
  
    required this.nombre,
    this.param1,
    this.param2,
    this.param3,
    this.param4,
    this.param5,
    this.param6,
    this.param7,
    this.param8,
    this.param9,
    this.param10,
  });

  @override
  String toString() {
    return 'Preset{nombre: $nombre, param1: $param1, param2: $param2, param3: $param3, param4: $param4, param5: $param5, param6: $param6, param7: $param7, param8: $param8, param9: $param9, param10: $param10}';
  }
  
  final cancion = ToOne<Cancion>();
}