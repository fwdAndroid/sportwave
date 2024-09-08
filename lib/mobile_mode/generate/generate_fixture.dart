import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/generate/gesture_result_eight.dart';

class GenerateFixture extends StatefulWidget {
  final dynamic fixturesData;
  final int numberOfResponses;

  GenerateFixture({
    required this.fixturesData,
    required this.numberOfResponses,
  });

  @override
  State<GenerateFixture> createState() => _GenerateFixtureState();
}

class _GenerateFixtureState extends State<GenerateFixture> {
  @override
  Widget build(BuildContext context) {
    // Ensure the data field is a list
    final List<dynamic> fixturesList = widget.fixturesData['data'] ?? [];

    // Limit the item count to the selected number of responses
    int itemCount = fixturesList.length;
    if (itemCount > widget.numberOfResponses) {
      itemCount = widget.numberOfResponses;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("The Game Before The Game"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final fixture = fixturesList[index];

                  // Check if the fixture matches the type_id filter
                  final predictions = fixture['predictions'];
                  if (predictions == null || predictions.isEmpty) {
                    return SizedBox
                        .shrink(); // Skip this item if no predictions
                  }

                  // Extract prediction widgets for type IDs 231, 234, 235, 237
                  final List<Widget> predictionWidgets = [];
                  for (var prediction in predictions) {
                    final typeId = prediction['type_id'];
                    final predData = prediction['predictions'];

                    if ([231, 234, 235, 237].contains(typeId) &&
                        predData is Map) {
                      final yesValue = predData['yes'];
                      final homeValue = predData['home'];
                      final awayValue = predData['away'];

                      if (yesValue != null && yesValue >= 80) {
                        predictionWidgets
                            .add(Text('Yes: ${yesValue.toStringAsFixed(2)}%'));
                      }
                      if (homeValue != null && homeValue >= 80) {
                        predictionWidgets.add(
                            Text('Home: ${homeValue.toStringAsFixed(2)}%'));
                      }
                      if (awayValue != null && awayValue >= 80) {
                        predictionWidgets.add(
                            Text('Away: ${awayValue.toStringAsFixed(2)}%'));
                      }
                    }
                  }

                  // Only display the card if there are prediction widgets to show
                  if (predictionWidgets.isEmpty) {
                    return SizedBox.shrink();
                  }

                  return Card(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        // Handle tap event if needed
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => GestureResultEight(
                                      fixtureData: fixture,
                                    )));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (fixture['league'] != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        fixture['league']['image_path']),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(fixture['league']['name']),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  fixture['participants'][0]['image_path'],
                                  height: 80,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(fixture['participants'][0]['name']),
                                  SizedBox(height: 5),
                                  Text("VS"),
                                  SizedBox(height: 5),
                                  Text(fixture['participants'][1]['name']),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  fixture['participants'][1]['image_path'],
                                  height: 80,
                                ),
                              )
                            ],
                          ),
                          if (fixture['starting_at'] != null)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    "Starting At: ${fixture['starting_at']}"),
                              ),
                            ),
                          // Display the extracted prediction widgets
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: predictionWidgets,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
