import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class updateForm extends StatefulWidget {
  @override
  State<updateForm> createState() => _updateFormState();
}

class _updateFormState extends State<updateForm> {
  

  CollectionReference postCollection = 
    FirebaseFirestore.instance.collection('Movies');

  @override
  Widget build(BuildContext context) {
    final postData = ModalRoute.of(context)!.settings.arguments as dynamic;

    final movieNameController = TextEditingController(text: postData['Moviename']);
    final categoryController = TextEditingController(text: postData['Category']);
    final minController = TextEditingController(text: postData['Minute']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 41, 41, 1),
        title: Center(
          child: Text(
            'Edit Information',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Text(
                  'Information',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: movieNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Add a title',
                    icon: Icon(Icons.movie),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: categoryController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Start a new Post',
                    icon: Icon(Icons.category),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: minController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Start a new Post',
                    icon: Icon(Icons.timelapse),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    postCollection.doc(postData.id).update({
                      'Moviename':movieNameController.text,
                      'Category':categoryController.text,
                      'Minute':minController.text

                    });
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
