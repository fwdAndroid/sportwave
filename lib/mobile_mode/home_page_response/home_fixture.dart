import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportwave/mobile_mode/generate/generate_detail_screen..dart';

class HomeFixture extends StatefulWidget {
  final dynamic fixturesData;

  HomeFixture({
    required this.fixturesData,
  });

  @override
  State<HomeFixture> createState() => _HomeFixtureState();
}

class _HomeFixtureState extends State<HomeFixture> {
  @override
  Widget build(BuildContext context) {
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
                itemCount: widget.fixturesData['data'].length,
                itemBuilder: (context, index) {
                  final fixture = widget.fixturesData['data'][index];
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
                          if (fixture['league'] != null)
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  "${fixture['participants'][0]['image_path']}",
                                  height: 80,
                                ),
                              ),
                              Column(
                                children: [
                                  Text("${fixture['participants'][0]['name']}"),
                                  const SizedBox(height: 5),
                                  Text("VS"),
                                  const SizedBox(height: 5),
                                  Text("${fixture['participants'][1]['name']}"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                    "${fixture['participants'][1]['image_path']}",
                                    height: 80),
                              )
                            ],
                          ),
                          Text(" $homeScore - $awayScore"),
                          if (fixture['date'] != null)
                            Text(
                              "- ${DateFormat('yyyy-MM-dd').format(DateTime.parse(fixture['date']))}",
                            ),
                          if (fixture['result_info'] != null)
                            Text("Result: ${fixture['result_info']}"),
                          if (fixture['starting_at'] != null)
                            Text("Starting At: ${fixture['starting_at']}"),
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
