import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:shoreguard/oceanmap.dart';
import 'package:shoreguard/widgets/ocean_score.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var conditionDetails = oceanConditionMap[OceanScore.score];
  List suitableActivity =
      oceanConditionMap[OceanScore.score]!['suitableActivities'];
  late GifController controller;

  @override
  void initState() {
    print(OceanScore.score);
    print("Homepage scrore $OceanScore.score");
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
            image: AssetImage(conditionDetails!['backgroundGifPath'] as String),
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
                      'Ocean Condition Score:',
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: OceanScore.score * 0.2,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                OceanScore.score > 3
                                    ? Colors.green
                                    : OceanScore.score > 1
                                        ? Colors.yellow
                                        : Colors.red),
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('${OceanScore.score}/5',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      icon: Icons.waves,
                    ),
                    SizedBox(height: 16),
                    _buildCard(
                      'Activity-specific Suitability:',
                      child: SizedBox(
                        height: suitableActivity.length.toDouble() * 30,
                        child: ListView.builder(
                          itemCount: suitableActivity.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                "- ${suitableActivity[index]}",
                                style: TextStyle(fontSize: 17),
                              ),
                            );
                          },
                        ),
                      ),
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
