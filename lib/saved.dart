import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model.dart';

class Savings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Dogs')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('savedDogs').listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No saved dogs'));
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final dogData = Map<String, dynamic>.from(box.getAt(index));
                final dog = Dog.fromMap(dogData);
                return ListTile(
                  leading: Image.network(
                    dog.imageUrl, 
                    width: 50, 
                    height: 50, 
                    fit: BoxFit.cover,
                  ),
                  title: Text(dog.name),
                  subtitle: Text(dog.breed),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await box.deleteAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${dog.name} removed!')),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
