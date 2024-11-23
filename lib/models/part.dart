class Part {
  final String name;
  final String type;
  final double price;

  Part({required this.name, required this.type, required this.price});

    factory Part.fromMap(Map<String, dynamic> data) {
    return Part(
      name: data['name'],
      type: data['type'],
      price: data['price'],
    );
  }
}
