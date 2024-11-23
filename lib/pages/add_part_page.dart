import 'package:flutter/material.dart';
import 'package:alphapartzboy/db/sqldb.dart';
import 'package:flutter/services.dart';

class AddPartPage extends StatefulWidget {
  final Function onAdd;
  final List<String> partTypes;
  const AddPartPage({super.key, required this.onAdd, required this.partTypes});

  @override
  _AddPartPageState createState() => _AddPartPageState();
}

class _AddPartPageState extends State<AddPartPage> {
  SqlDB sqlDB = SqlDB();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController partNameController = TextEditingController();
  final TextEditingController partPriceController = TextEditingController();
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    final List<String> partTypes = widget.partTypes;
    final Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Add a Part", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        padding: EdgeInsets.all(deviceSize.width * 0.1),
        color: Colors.black,
        width: deviceSize.width,
        height: deviceSize.height,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: partNameController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Part Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter part name';
                  }
                  return null;
                },
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: partPriceController,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Price',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter part price';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Type',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.black,
                        filled: true,
                      ),
                      dropdownColor: Colors.black,
                      style: const TextStyle(color: Colors.white),
                      items: partTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    widget.onAdd(selectedType!, partNameController.text,
                        double.parse(partPriceController.text));
                    partTypes.remove(selectedType);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Part added successfully!'),
                      ),
                    );
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Add to Your PC",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.build_sharp, size: 16, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
