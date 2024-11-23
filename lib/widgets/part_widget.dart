import "package:alphapartzboy/models/part.dart";
import "package:flutter/material.dart";

class PartWidget extends StatelessWidget {
  final Part part;
  final void Function(String) onDelete;
  const PartWidget({super.key, required this.part, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.9,
      margin: EdgeInsets.only(bottom: deviceSize.width * 0.05),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    part.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "${part.price} SR",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onDelete(part.type);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              color: Colors.white,
              child: Text(
                part.type,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
