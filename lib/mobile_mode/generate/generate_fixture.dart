import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportwave/mobile_mode/generate/generate_detail_screen..dart';

class GenerateFixture extends StatefulWidget {
  final dynamic fixturesData;
  final int numberOfResponses;

  GenerateFixture(
      {required this.fixturesData, required this.numberOfResponses});

  @override
  State<GenerateFixture> createState() => _GenerateFixtureState();
}

class _GenerateFixtureState extends State<GenerateFixture> {
  @override
  Widget build(BuildContext context) {
    int itemCount = widget.fixturesData['data'].length;
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
                  final fixture = widget.fixturesData['data'][index];
                  // Extract scores dynamically
                  int homeScore = 0;
                  int awayScore = 0;
                  if (fixture['scores'] != null) {
                    for (var score in fixture['scores']) {
                      if (score['score']['participant'] == 'home') {
                        homeScore = score['score']['goals'];
                      } else if (score['score']['participant'] == 'away') {
                        awayScore = score['score']['goals'];
                      }
                    }
                  }

                  return Card(
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GenernateDetailsScreen(
                                fixtureData: fixture,
                              ),
                            ),
                          );
                        },
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
                                      height: 80),
                                ),
                              ],
                            ),
                            Text(
                              " $homeScore - $awayScore",
                            ),
                            if (fixture['date'] != null)
                              Text(
                                "- ${DateFormat('yyyy-MM-dd').format(DateTime.parse(fixture['date']))}",
                              ),
                            if (fixture['result_info'] != null)
                              Text(
                                "Result: ${fixture['result_info']}",
                              ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
