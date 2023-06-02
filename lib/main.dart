import 'package:app_mdm/ui/vista_repertorio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'object_box.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override

  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MDM',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ),
      home: const VistaRepertorio(),
    );
  }
}
