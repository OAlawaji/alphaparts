import 'package:alphapartzboy/pages/add_part_page.dart';
import 'package:flutter/material.dart';

class Adder extends StatelessWidget {
  final Function onAdd;
  final List<String> partTypes;
  const Adder({super.key, required this.onAdd, required this.partTypes});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    print("Part Types 2: $partTypes");

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPartPage(onAdd: onAdd, partTypes: partTypes),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(deviceSize.width * 0.8, deviceSize.height * 0.05),
      ),
      child: Icon(
        Icons.add,
        size: deviceSize.width * 0.1,
        color: Colors.white,
      ),
    );
  }
}
