import 'dart:convert';
import 'package:dog/model.dart';
import 'package:http/http.dart' as http;


class DogService {
  final String apiUrl = 'https://dog.ceo/api/breeds/image/random/10'; 

  Future<List<Dog>> fetchDogs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Dog> dogs = [];

      for (var imageUrl in data['message'
      ]) {
       
        dogs.add(Dog('Dog ${dogs.length + 1}', 
        
        'Breed ${dogs.length + 1}', 
        imageUrl, 'Description for Dog ${
          dogs.length + 1}'
          ));
      }

      return dogs;
    } else {
      throw Exception('eRORR');
    }
  }
}
