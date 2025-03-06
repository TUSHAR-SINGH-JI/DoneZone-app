import 'package:flutter/material.dart';
import 'My_Button.dart';
class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  Dialogbox({super.key, required this.controller,required this.onCancel,required this.onSave});
  @override

  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: Container(

        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller:controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new task"
              ),
            ),
            // button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                MyButton(text: 'SAVE',onPressed: onSave,),
               const SizedBox(width: 4,),
                MyButton(text: 'Cancel',onPressed: onCancel,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
