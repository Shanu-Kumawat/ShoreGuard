import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Expanded(
        child: ListView.builder(
          itemCount: 10, // Replace with the actual number of items
          itemBuilder: (context, index) {
            return Container(
              color: Colors.grey,
              child: ListTile(
                title: Text(
                  'Enjoy Your Day!',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Suitable activities: Swimming, Rafting,BEach Volleyball',
                  style: TextStyle(color: Colors.white70),
                ),
                leading:
                    Icon(Icons.notification_important, color: Colors.white),
                // onTap: () {
                //   // Handle tap on alert item
                //   print('Tapped on Alert ${index + 1}');
                // },
              ),
            );
          },
        ),
      ),
    );
  }
}

