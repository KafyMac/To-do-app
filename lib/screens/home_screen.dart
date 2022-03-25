import 'package:cloud_firestore/cloud_firestore.dart';
import './services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './login_screen.dart';
import './services/google_auth.dart';
import 'text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(user.displayName!),
        actions: [
          IconButton(
            onPressed: () async {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('todo')
              .where('userid',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return Card(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index];
                      var docid = data.id;
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color.fromARGB(255, 205, 211, 214),
                        elevation: 20,
                        child: ListTile(
                          leading: Checkbox(
                            onChanged: (value) {
                              FirebaseFirestore.instance
                                  .collection('todo')
                                  .doc(docid)
                                  .update({
                                'completed': value,
                              });
                            },
                            value: data['completed'],
                          ),
                          title: Text(
                            data["title"],
                            style: TextStyle(
                              decoration: data['completed']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: data['completed']
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('todo')
                                    .doc(docid)
                                    .delete();
                              },
                              icon: Icon(Icons.delete)),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text('No to-do`s available'),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TextFieldScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
