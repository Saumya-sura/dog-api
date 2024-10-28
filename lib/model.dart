class Dog {
  final String name;
  final String breed;
  final String imageUrl;
  final String description;

  Dog(this.name, this.breed, this.imageUrl, this.description);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
     'breed': breed,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  
  static Dog fromMap(Map<String, dynamic> map) {
    return Dog(
     map['name'],
      map['breed'],
      map['imageUrl'],
      map['description'],
    );
  }
}
