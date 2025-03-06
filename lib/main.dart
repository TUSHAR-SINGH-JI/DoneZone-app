import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papa/page/ToDoPage.dart';
void main() async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("myBox");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Todopage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      // routes: ,
      // debugShowCheckedModeBanner: ,
    );
  }
}
