import 'package:flutter/material.dart';

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
        title: Text("SportWave"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1,
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
                  final yes = predictions[index]['predictions']['yes'] ?? 'N/A';
                  final no = predictions[index]['predictions']['no'] ?? 'N/A';
                  return Card(
                    color: Colors.white,
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Yes: $yes%"),
                              Text("No: $no%"),
                            ],
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
