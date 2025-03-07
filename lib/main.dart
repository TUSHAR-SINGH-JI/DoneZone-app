import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papa/page/ToDoPage.dart';
import 'package:papa/page/intro_page.dart';
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
      initialRoute: "/",
      routes: {
        '/': (context) => const IntroPage(), // Splash or intro screen
        '/home': (context) => const Todopage(), // Main home screen
      },
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      // routes: ,
      // debugShowCheckedModeBanner: ,
    );
  }
}
