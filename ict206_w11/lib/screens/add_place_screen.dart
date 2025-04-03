import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  String image = '';
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Place')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter description' : null,
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
                onSaved: (value) => image = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location URL'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter location URL' : null,
                onSaved: (value) => location = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Place newPlace = Place(
                      id: 0, // Will be set by auto_increment
                      name: name,
                      description: description,
                      image: image,
                      location: location,
                      createdAt: DateTime.now().toString(),
                    );
                    await ApiService().addPlace(newPlace);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}