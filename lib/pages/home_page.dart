import 'package:alphapartzboy/db/sqldb.dart';
import 'package:alphapartzboy/widgets/adder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alphapartzboy/models/part.dart';
import 'package:alphapartzboy/widgets/part_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Part>> _partsFuture;
  late double totalPrice = 0.0;
  final List<String> partTypes = [
    'CPU',
    'GPU',
    'RAM',
    'SSD',
    'Motherboard',
    'PSU',
    'CPU COOLER',
    'Case'
  ];
  List<String> newPartTypes = [];
  
  @override
  void initState() {
    super.initState();
    _partsFuture = _loadParts();
  }

  Future<List<Part>> _loadParts() async {
    SqlDB sqlDb = SqlDB();
    List<Map> partsData = await sqlDb.readData('SELECT * FROM pieces');
    double newTotalPrice = 0.0;

    List<Part> parts = partsData.map((data) {
      Part part = Part.fromMap(data as Map<String, dynamic>);
      newTotalPrice += part.price;
      newPartTypes.add(part.type);
      return part;
    }).toList();

    setState(() {
      totalPrice = newTotalPrice;
    });

    return parts;
  }

  Future<void> _deletePart(String type) async {
    SqlDB sqlDb = SqlDB();
    await sqlDb.deleteData('DELETE FROM pieces WHERE type = ?', [type]);
    setState(() {
      _partsFuture = _loadParts();
    });
  }

  Future<void> _addPart(String type, String name, double price) async {
    SqlDB sqlDb = SqlDB();
    await sqlDb.insertPiece(type, name, price);
    setState(() {
      _partsFuture = _loadParts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Workshop", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<Part>>(
                    future: _partsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No parts found'));
                      } else {
                        final parts = snapshot.data!;
                        return ListView(
                          children: parts.map((part) {
                            return PartWidget(
                                part: part, onDelete: _deletePart);
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: Text(
                              "$totalPrice SR",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: partTypes.where((item) => !newPartTypes.contains(item)).isNotEmpty,
                        child: Adder(
                          onAdd: _addPart,
                          partTypes: partTypes
                              .where((item) => !newPartTypes.contains(item))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
