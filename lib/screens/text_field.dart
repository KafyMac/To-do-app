import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextFieldScreen extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('todo');
  final userid = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController addNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tasks here'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: addNoteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Task',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (addNoteController.text != '') {
                        await users.add({
                          'title': addNoteController.text,
                          'completed': false,
                          'userid': userid,
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'))),
          ],
        ),
      ),
    );
  }
}
