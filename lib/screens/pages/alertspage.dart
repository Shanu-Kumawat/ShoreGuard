import 'package:flutter/material.dart';
import 'package:shoreguard/widgets/CardTile.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Expanded(
        child: ListView.builder(
          itemCount: 1, // Replace with the actual number of items
          itemBuilder: (context, index) {
            return Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardTile(),
                ));
          },
        ),
      ),
    );
  }
}
