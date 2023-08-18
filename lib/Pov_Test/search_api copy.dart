import 'package:flutter/material.dart';

class Property {
  final int id;
  final String type;
  final String commune;
  final int price;
  final String description;
  final int bed;
  final String urgent;
  final String homeType;
  final int bath;
  final int land;

  Property({
    required this.id,
    required this.type,
    required this.commune,
    required this.price,
    required this.description,
    required this.bed,
    required this.urgent,
    required this.homeType,
    required this.bath,
    required this.land,
  });
}

class ListSearchExample extends StatefulWidget {
  @override
  _ListSearchExampleState createState() => _ListSearchExampleState();
}

class _ListSearchExampleState extends State<ListSearchExample> {
  List<Property> propertyList = [
    Property(
      id: 202347475,
      type: 'For Sale',
      commune: 'KampongThom',
      price: 9292,
      description: 'htthht',
      bed: 626,
      urgent: 'Urgent',
      homeType: 'Apartment Building',
      bath: 82,
      land: 9295,
    ),
    Property(
      id: 202347474,
      type: 'For Sale',
      commune: 'KampongThom',
      price: 9596,
      description: 'htht',
      bed: 5992,
      urgent: 'Urgent',
      homeType: 'Borey Development',
      bath: 9529,
      land: 2626,
    ),
    Property(
      id: 202347473,
      type: 'For Rent',
      commune: 'Phnom Penh',
      price: 6526,
      description: 'mhynnyny',
      bed: 6226,
      urgent: 'Urgent',
      homeType: 'Borey Development',
      bath: 6262,
      land: 9282,
    ),
  ];
  List<Property> filteredList = [];

  void filterItems(String query) {
    filteredList = propertyList
        .where((property) =>
            property.type.toLowerCase().contains(query.toLowerCase()) ||
            property.commune.toLowerCase().contains(query.toLowerCase()) ||
            property.description.toLowerCase().contains(query.toLowerCase()) ||
            property.homeType.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Search Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterItems(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final property = filteredList[index];
                return ListTile(
                  title: Text('Type: ${property.type}'),
                  subtitle: Text(
                      'Commune: ${property.commune}\nPrice: \$${property.price}\nDescription: ${property.description}\nBedrooms: ${property.bed}\nUrgent: ${property.urgent}\nHome Type: ${property.homeType}\nBathrooms: ${property.bath}\nLand: ${property.land}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListSearchExample(),
  ));
}
