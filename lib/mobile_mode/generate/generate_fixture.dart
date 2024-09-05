import 'package:flutter/material.dart';
import 'package:sportwave/mobile_mode/generate/gesture_result_eight.dart';

class GenerateFixture extends StatefulWidget {
  final dynamic fixturesData; // Assuming fixturesData is a dynamic type.
  final int numberOfResponses;

  GenerateFixture(
      {required this.fixturesData, required this.numberOfResponses});

  @override
  State<GenerateFixture> createState() => _GenerateFixtureState();
}

class _GenerateFixtureState extends State<GenerateFixture> {
  @override
  Widget build(BuildContext context) {
    // Ensure the data field is a list
    final List<dynamic> fixturesList = widget.fixturesData['data'] ?? [];

    int itemCount = fixturesList.length;
    // Limit the item count to the selected number of responses
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
              height: MediaQuery.of(context).size.height /
                  1, // Adjust height as needed
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final fixture = fixturesList[index]; // Access list by index

                  // Extract scores dynamically
                  int homeScore = 0;
                  int awayScore = 0;
                  if (fixture['scores'] != null && fixture['scores'] is List) {
                    for (var score in fixture['scores']) {
                      if (score['participant'] == 'home') {
                        homeScore = score['goals'] ?? 0;
                      } else if (score['participant'] == 'away') {
                        awayScore = score['goals'] ?? 0;
                      }
                    }
                  }

                  final List<dynamic> predictions =
                      fixture['predictions'] ?? [];

                  // Initialize counts
                  double yesPercentage = 0.0;
                  double noPercentage = 0.0;

                  // Calculate yes and no percentages
                  if (predictions.isNotEmpty) {
                    // Sum up percentages from all predictions
                    double totalYes = 0.0;
                    double totalNo = 0.0;

                    for (var prediction in predictions) {
                      final predictionMap = prediction['predictions'] ?? {};
                      totalYes += (predictionMap['yes'] ?? 0.0);
                      totalNo += (predictionMap['no'] ?? 0.0);
                    }

                    // Calculate the average percentages
                    yesPercentage = totalYes / predictions.length;
                    noPercentage = totalNo / predictions.length;
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => GestureResultEight(
                                    fixtureData: fixture,
                                  )));
                    },
                    child: yesPercentage >= 80
                        ? Card(
                            color: Colors.white,
                            child: GestureDetector(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              fixture['league']['image_path']),
                                        ),
                                        Text(" ${fixture['league']['name']}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (fixture['league'] != null)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            "${fixture['participants'][0]['image_path']}",
                                            height: 80,
                                          ),
                                        ),
                                      Column(
                                        children: [
                                          Text(
                                            "${fixture['participants'][0]['name']}",
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "VS",
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${fixture['participants'][1]['name']}",
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          "${fixture['participants'][1]['image_path']}",
                                          height: 80,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Show Yes percentage only if it's >= 80
                                        if (yesPercentage >= 80)
                                          Text(
                                              "Yes: ${yesPercentage.toStringAsFixed(1)}%"),
                                        Text(
                                            "No: ${noPercentage.toStringAsFixed(1)}%"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
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
