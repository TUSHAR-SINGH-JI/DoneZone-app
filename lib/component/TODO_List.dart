import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class TodoList extends StatelessWidget {
  final String taskname ;
  final bool taskcomplited;
  Function(bool?)?onChanged;
  Function(BuildContext)?deleteFuntion;
   TodoList({super.key, required this.taskname, required this.taskcomplited ,required this.onChanged,required this.deleteFuntion});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right:25,top:25),
      child: Slidable(
        endActionPane: ActionPane(
          motion:StretchMotion() ,
          children: [
            SlidableAction(onPressed: deleteFuntion,
            icon: Icons.delete,
           borderRadius: BorderRadius.circular(13),
           backgroundColor: Colors.red, )
          ],
        ),
        child: Expanded(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                // task name
                Checkbox(value: taskcomplited,
                    onChanged: onChanged
                ,activeColor: Colors.black,),

                Expanded(
                  child: Text(taskname,
                  style: TextStyle(decoration: taskcomplited? TextDecoration.lineThrough: TextDecoration.none),),
                ),

              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.yellow
            ),
          ),
        ),
      ),
    );
  }
}
