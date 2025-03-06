import 'package:hive_flutter/hive_flutter.dart';

class ToDODatabase{
  List toDoList = [];
  // refrance box
  final _myBox  = Hive.box("myBox");

  void createInitialData(){
    toDoList=[
      ["make Tutorial",false],
      ["Do Exercise",false],
    ];}
    // data load
    void loadData(){
    toDoList= _myBox.get("TODOLIST", defaultValue: []);
    }
    void updateDataBase(){
      _myBox.put("TODOLIST", toDoList);
    }
  }
