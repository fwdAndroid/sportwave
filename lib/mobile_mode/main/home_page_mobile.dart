import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportwave/mobile_mode/generate/genearate_app.dart';
import 'package:sportwave/mobile_mode/widgets/button.dart';

import 'package:sportwave/utils/colors.dart';
import 'package:sportwave/utils/input_text.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({super.key});

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController numberOfResponsesController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool isLoading = false;

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    numberOfResponsesController.dispose();
    super.dispose();
  }

  Future<void> _fetchFixtures() async {
    if (selectedStartDate == null || selectedEndDate == null) {
      print("Please select both start and end dates.");
      return;
    } else if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Date is Required")));
    } else {
      final String url =
          "https://fixturesbetween-7qvbnkwoka-uc.a.run.app/?path=football/fixtures/between/${DateFormat('yyyy-MM-dd').format(selectedStartDate!)}/${DateFormat('yyyy-MM-dd').format(selectedEndDate!)}?include=predictions;participants;league;scores";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("API response: ${response.body}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FixturesScreenMobile(
              fixturesData: jsonDecode(response.body),
            ),
          ),
        );
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 100,
            ),
            SizedBox(
              width: 400,
              height: 530, // Increased height to accommodate new button
              child: Card(
                color: const Color(0xff000080),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Start Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: colorwhite),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InputText(
                          onTap: () => _selectStartDate(context),
                          controller: startDateController,
                          labelText: "23 June 2023",
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          onSaved: (val) {},
                          textInputAction: TextInputAction.done,
                          isPassword: false,
                          enabled: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "End Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: colorwhite),
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InputText(
                          onTap: () => _selectEndDate(context),
                          controller: endDateController,
                          labelText: "30 June 2025",
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          onSaved: (val) {},
                          textInputAction: TextInputAction.done,
                          isPassword: false,
                          enabled: true,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SaveButton(
                          onTap: _fetchFixtures,
                          title: "Submit",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}

class FixturesScreenMobile extends StatefulWidget {
  final dynamic fixturesData;

  const FixturesScreenMobile({
    super.key,
    required this.fixturesData,
  });

  @override
  State<FixturesScreenMobile> createState() => _FixturesScreenMobileState();
}

class _FixturesScreenMobileState extends State<FixturesScreenMobile> {
  @override
  Widget build(BuildContext context) {
    int itemCount = widget.fixturesData['data'].length;
    // Limit the item count to the selected number of responses

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SportWave"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1,
              padding: const EdgeInsets.all(16.0),
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
                              builder: (context) => FixtureDetailsScreen(
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
                                    const Text(
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

class FixtureDetailsScreen extends StatefulWidget {
  final dynamic fixtureData;

  const FixtureDetailsScreen({super.key, required this.fixtureData});

  @override
  _FixtureDetailsScreenState createState() => _FixtureDetailsScreenState();
}

class _FixtureDetailsScreenState extends State<FixtureDetailsScreen> {
  late Map<String, dynamic> homeAwayDrawPredictions;
  late Map<String, dynamic> bothTeamsToScorePrediction;
  late Map<String, dynamic> overgoals;
  late Map<String, dynamic> homeTeam;
  @override
  void initState() {
    super.initState();
    homeAwayDrawPredictions =
        getHomeAwayDrawPredictions(widget.fixtureData['predictions']);
    bothTeamsToScorePrediction = getSpecificPrediction(
        widget.fixtureData['predictions'],
        1684); // Type ID for "Both Teams To Score"
    overgoals = getOverGoals(widget.fixtureData['predictions'], 1685);
    homeTeam = getHomeTeam(widget.fixtureData['predictions'], 1683);
  }

  Map<String, dynamic> getHomeAwayDrawPredictions(List<dynamic> predictions) {
    for (var prediction in predictions) {
      if (prediction['predictions'].containsKey('home') &&
          prediction['predictions'].containsKey('away') &&
          prediction['predictions'].containsKey('draw')) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  Map<String, dynamic> getSpecificPrediction(
      List<dynamic> predictions, int typeId) {
    for (var prediction in predictions) {
      if (prediction['type_id'] == typeId) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  Map<String, dynamic> getOverGoals(List<dynamic> predictions, int typeId) {
    for (var prediction in predictions) {
      if (prediction['type_id'] == typeId) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  Map<String, dynamic> getHomeTeam(List<dynamic> predictions, int typeId) {
    for (var prediction in predictions) {
      if (prediction['type_id'] == typeId) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  String _getPredictionDescription(int typeId) {
    switch (typeId) {
      case 1679:
        return "Over 2.5 Goals";
      case 1683:
        return "Home Team To Win";
      case 1684:
        return "Both Teams To Score";
      case 1685:
        return "Home Team To Win To Nil";
      case 1686:
        return "Home Team To Win In Regular Time";
      case 1687:
        return "Draw No Bet - Home Team";
      case 1688:
        return "Draw No Bet - Away Team";
      case 1689:
        return "Home Team To Win Either Half";
      case 1690:
        return "Home Team To Win By 2+ Goals";
      case 231:
        return "Over 1.5 Goals";
      case 232:
        return "Correct Score";
      case 233:
        return "Match Result";
      case 234:
        return "Home Team To Score First";
      case 235:
        return "Both Teams To Score";
      case 236:
        return "Away Team To Score First";
      case 237:
        return "Match Result - Over/Under 2.5 Goals";
      case 238:
        return "Match Result - Double Chance";
      case 239:
        return "Double Chance - Over/Under 2.5 Goals";
      case 240:
        return "Scores";
      case 326:
        return "Home Team To Win";
      case 327:
        return "Away Team To Win";
      case 328:
        return "Draw";
      case 330:
        return "Away Team To Win";
      case 331:
        return "Home Team To Win";
      case 332:
        return "Away Team To Win";
      case 333:
        return "Home Team To Win";
      case 334:
        return "Over 2.5 Goals";
      default:
        return "Unknown Prediction";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const GenerateApp()));
              },
              child: const Text("Gernate"))
        ],
        title: Text(
          "${widget.fixtureData['participants'][0]['name']} vs ${widget.fixtureData['participants'][1]['name']}",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${widget.fixtureData['participants'][0]['image_path']}",
                      height: 80,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "${widget.fixtureData['participants'][0]['name']}",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.fixtureData['participants'][1]['name']}",
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        "${widget.fixtureData['participants'][1]['image_path']}",
                        height: 80),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Full Time Result",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              homeAwayDrawPredictions.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Home"),
                            Text(
                              "${homeAwayDrawPredictions['home']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Draw"),
                            Text(
                              "${homeAwayDrawPredictions['draw']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Away"),
                            Text(
                              "${homeAwayDrawPredictions['away']}%",
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Text(
                      "No Prediction Found",
                    ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Both Teams To Score",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              bothTeamsToScorePrediction.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Yes"),
                            Text(
                              "${bothTeamsToScorePrediction['yes']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("No"),
                            Text(
                              "${bothTeamsToScorePrediction['no']}%",
                            ),
                          ],
                        ),
                        bothTeamsToScorePrediction.containsKey('equal')
                            ? Column(
                                children: [
                                  const Text("Equal"),
                                  Text(
                                    "${bothTeamsToScorePrediction['equal']}%",
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    )
                  : const Text(
                      "No Prediction Found",
                    ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Over 2.5 Goals",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              overgoals.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Yes"),
                            Text(
                              "${overgoals['yes']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("No"),
                            Text(
                              "${overgoals['no']}%",
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Text(
                      "No Prediction Found",
                    ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Over/Under 1.5",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              homeTeam.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Yes"),
                            Text(
                              "${homeTeam['yes']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("No"),
                            Text(
                              "${homeTeam['no']}%",
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Text(
                      "No Prediction Found",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
