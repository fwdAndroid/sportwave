import 'package:flutter/material.dart';

class GenernateDetailsScreen extends StatefulWidget {
  final dynamic fixtureData;

  const GenernateDetailsScreen({super.key, required this.fixtureData});

  @override
  _GenernateDetailsScreenState createState() => _GenernateDetailsScreenState();
}

class _GenernateDetailsScreenState extends State<GenernateDetailsScreen> {
  late Map<String, dynamic> homeTeam;
  late Map<String, dynamic> bothTeamToScore;
  late Map<String, dynamic> overgoal;
  @override
  @override
  void initState() {
    super.initState();

    homeTeam = getHomeTeam(widget.fixtureData['predictions'], 234);
    bothTeamToScore =
        getbothTeamToScore(widget.fixtureData['predictions'], 231);
    overgoal = getOverGoal(widget.fixtureData['predictions'], 235);
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

  Map<String, dynamic> getHomeTeam(List<dynamic> predictions, int typeId) {
    for (var prediction in predictions) {
      if (prediction['type_id'] == typeId) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  Map<String, dynamic> getbothTeamToScore(
      List<dynamic> predictions, int typeId) {
    for (var prediction in predictions) {
      if (prediction['type_id'] == typeId) {
        return prediction['predictions'];
      }
    }
    return {};
  }

  Map<String, dynamic> getOverGoal(List<dynamic> predictions, int typeId) {
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
                    "Both Team To Score",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              bothTeamToScore.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Yes"),
                            Text(
                              "${bothTeamToScore['yes']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("No"),
                            Text(
                              "${bothTeamToScore['no']}%",
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Over/Under 2.5",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              overgoal.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Yes"),
                            Text(
                              "${overgoal['yes']}%",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("No"),
                            Text(
                              "${overgoal['no']}%",
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
