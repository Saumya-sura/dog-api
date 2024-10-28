import 'package:dog/model.dart';
import 'package:flutter/material.dart';


class Details extends StatelessWidget {
  final Dog dog;

  Details({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dog.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(dog.imageUrl, fit: BoxFit.cover),
            SizedBox(height: 16),
            Text(
              'Breed: ${dog.breed}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              dog.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
