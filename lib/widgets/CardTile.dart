import 'package:flutter/material.dart';
import 'package:shoreguard/widgets/ocean_score.dart';
import 'package:shoreguard/oceanmap.dart';

class CardTile extends StatelessWidget {
  final int score = OceanScore.score;

  CardTile({super.key});

  @override
  Widget build(BuildContext context) {
    final String warning = oceanConditionMap[score]!['warnings'];
    final List<String> activities =
    oceanConditionMap[score]!['suitableActivities'];

    return SizedBox(
      width: 300,
      child: Card(
        color: score < 3 ? Colors.red[500] : Colors.blue,
        elevation: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: score < 3
                                    ? Icon(Icons.add_alert)
                                    : Icon(Icons.health_and_safety),
                              ),
                              Text(
                                warning,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
                              child: Text(
                                'Ocean Condition Score:${score.toString()}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0),
                              child: Text(
                                'Suitable Activities:',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: activities
                                      .map<Widget>((activity) => Chip(
                                    color: score < 3
                                        ? WidgetStateProperty.all(Colors.red)
                                        : WidgetStateProperty.all(Colors.blue),
                                    side: score < 3
                                        ? BorderSide(color: Colors.red)
                                        : BorderSide(color: Colors.blue),
                                    elevation: 0,
                                    label: Text(
                                      activity,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ))
                                      .toList(),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
              )),
        ),
    );
  }
}