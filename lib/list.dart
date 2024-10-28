import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:dog/model.dart';
import 'package:dog/service.dart';
import 'package:dog/detail.dart';
import 'package:dog/saved.dart';

class Listing extends StatefulWidget {
  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  final DogService dogService = DogService();
  List<Dog> allDogs = [];
  List<Dog> filteredDogs = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadDogs();
  }

  void loadDogs() async {
    final dogs = await dogService.fetchDogs();
    setState(() {
      allDogs = dogs;
      filteredDogs = dogs; 
    });
  }

  void filterDogs(String query) {
    final results = allDogs.where((dog) {
      final nameMatch = dog.name.toLowerCase().contains(query.toLowerCase());
      final breedMatch = dog.breed.toLowerCase().contains(query.toLowerCase());
      return nameMatch || breedMatch;
    }).toList();
    setState(() => filteredDogs = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: InputDecoration(hintText: 'Search Dogs...'),
                onChanged: filterDogs,
              )
            : Text('Dog Explorer'),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() => isSearching = !isSearching);
              if (!isSearching) filteredDogs = allDogs; 
            },
          ),
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
      body: filteredDogs.isEmpty
          ? Center(child: Text('No dogs found'))
          : ListView.builder(
              itemCount: filteredDogs.length,
              itemBuilder: (context, index) {
                final dog = filteredDogs[index];
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
            ),
    );
  }
}
