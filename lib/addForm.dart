import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _AddFormState();
}

class _AddFormState extends State<addForm> {
  final movieNameController = TextEditingController();
  final categoryController = TextEditingController();
  final minController = TextEditingController();

  CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('Movies');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 41, 41, 1),
        title: Center(
          child: Text(
            'Add Movie',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                Text(
                  'New Movie',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: movieNameController,
                  decoration: InputDecoration(
                    labelText: 'Movie Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: minController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Min',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addMovie,
                  child: Text('Add Movie'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addMovie() {
    if (movieNameController.text.isNotEmpty && categoryController.text.isNotEmpty) {
      CollectionReference movies = FirebaseFirestore.instance.collection('Movies');
      
      movies.add({
        'Moviename': movieNameController.text,
        'Category': categoryController.text,
        'Minute': minController.text,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Movie Added Successfully!')),
        );
        movieNameController.clear();
        categoryController.clear();
        minController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add movie: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }
}
