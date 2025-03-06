import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:papa/Data/database.dart';
import 'package:papa/component/TODO_List.dart';
import '../component/dialogbox.dart';
class Todopage extends StatefulWidget {
  const Todopage({super.key});
  @override
  State<Todopage> createState() => _TodopageState();
}
class _TodopageState extends State<Todopage> {
  final _myBox =  Hive.box("myBox");
  TextEditingController myconteroler  =  TextEditingController();
 String greetingmassage =  "";
  void greting(){
   print(myconteroler.text);
   setState(() {
     greetingmassage= "hello"+myconteroler.text;
   });
 }
 // text controler
  final _controller  = TextEditingController();
 // list todo
  ToDODatabase db  =  ToDODatabase();
  @override
  void initState() {
    // 1 time set defalt data
    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      // 2 time
      db.loadData();
    }

    super.initState();
  }


  void Checkboxchange(bool? value,int index){
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
      db.updateDataBase();
    });
    
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false,]);
      _controller.clear();
      db.updateDataBase();
    });
    Navigator.of(context).pop();
  }
  void creaternewtask(){
    showDialog(context: context, builder: (context){
      return Dialogbox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel:()=> Navigator.of(context).pop(),
      );
    });
  }
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow[200],
      appBar:AppBar(
        backgroundColor: Colors.yellow,
        title: Text("To DO"),
      centerTitle: true,
      elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: creaternewtask,
        child: Icon(Icons.note_add),
        backgroundColor: Colors.yellow,
      ),
      body:ListView.builder(
        itemCount: db.toDoList.length,
          itemBuilder: (context ,index){
          return
              TodoList(taskname: db.toDoList[index][0], taskcomplited: db.toDoList[index][1], onChanged:(value) =>Checkboxchange(value,index),
                deleteFuntion:(Context)=>deleteTask(index),);
          }

      ),

    );

  }
}
