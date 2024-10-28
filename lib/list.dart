import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dog/model.dart';
import 'package:dog/service.dart';
import 'package:dog/detail.dart';
import 'package:dog/saved.dart';

class Listing extends StatelessWidget {
  final DogService dogService = DogService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Explorer'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Savings()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Dog>>(
        future: dogService.fetchDogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('empty'));
          }

          final dogs = snapshot.data!;
          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return ListTile(
                leading: Image.network(dog.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(dog.name),
                subtitle: Text(dog.breed),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(dog: dog),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.bookmark),
                  onPressed: () async {
                    var box = Hive.box('savedDogs');
                    await box.add(dog.toMap());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${dog.name} saved!')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}