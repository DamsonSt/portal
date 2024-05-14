import 'package:flutter/material.dart';
// import 'package:portal/controllers/local_database.dart';
import 'screens/home_screen.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isWindows || Platform.isLinux) {
  //   // Initialize FFI
  //   sqfliteFfiInit();
  // }
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  
  // databaseFactory = databaseFactoryFfiWeb;
  // await LocalDatabase.createDatabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
