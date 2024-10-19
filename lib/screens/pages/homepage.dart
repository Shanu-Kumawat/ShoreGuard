import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late GifController controller;

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    controller.repeat(
        min: 0, max: 1, period: const Duration(milliseconds: 3000));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background GIF
        Positioned.fill(
          child: Gif(
            controller: controller,
            image: const AssetImage("assets/Gif/level7.gif"),
            fit: BoxFit.cover,
          ),
        ),
        // Overlay with semi-transparent background for readability
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Digha/Kolkata',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _buildCard(
                      'Suitability Score:',
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: Colors.grey[300],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('4/5',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      icon: Icons.waves,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Categorical Suitability:',
                      child: Text('Moderately Suitable',
                          style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Activity-specific Suitability:',
                      child: Text('Swimming', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String title, {Widget? child, IconData? icon}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) Icon(icon, color: Colors.blue),
                if (icon != null) SizedBox(width: 8),
                Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }
}
