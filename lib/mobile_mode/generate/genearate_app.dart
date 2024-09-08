import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportwave/mobile_mode/generate/generate_fixture.dart';
import 'package:sportwave/mobile_mode/widgets/button.dart';
import 'package:sportwave/utils/colors.dart';
import 'package:sportwave/utils/input_text.dart';

class GenerateApp extends StatefulWidget {
  const GenerateApp({super.key});

  @override
  State<GenerateApp> createState() => _GenerateAppState();
}

class _GenerateAppState extends State<GenerateApp> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController numberOfResponsesController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  int numberOfResponses = 20; // Default value
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
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    int currentPage = 1;
    bool hasMore = true;
    List<dynamic> allFixtures = [];

    while (hasMore) {
      final String url =
          "https://fixturesbetween-7qvbnkwoka-uc.a.run.app/?path=football/fixtures/between/${DateFormat('yyyy-MM-dd').format(selectedStartDate!)}/${DateFormat('yyyy-MM-dd').format(selectedEndDate!)}?include=predictions;participants;league;scores&page=$currentPage";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // Debugging: Print the entire response
        // print("API Response: ${response.body}");

        // Check if 'data' key exists and is a list
        if (decodedResponse.containsKey('data') &&
            decodedResponse['data'] is List) {
          // Add fixtures from the current page to the list
          allFixtures.addAll(decodedResponse['data']);
        } else {
          // print("Unexpected data format. 'data' key is not a list or does not exist.");
          break;
        }

        // Check if there's more data to fetch
        hasMore = decodedResponse['pagination']?['has_more'] ?? false;
        currentPage++;
      } else {
        // print("API request failed with status code: ${response.statusCode}");
        break;
      }
    }

    // Filter fixtures based on the required criteria
    final filteredFixtures = allFixtures.where((fixture) {
      final predictions = fixture['predictions'];
      if (predictions is List) {
        return predictions.any((prediction) {
          final typeId = prediction['type_id'];
          final predictionValues = prediction['predictions'];

          // Check if typeId is one of the specified types and if any of the values are >= 80
          if ((typeId == 231 ||
                  typeId == 234 ||
                  typeId == 235 ||
                  typeId == 237) &&
              (predictionValues['yes'] != null &&
                      predictionValues['yes'] >= 80 ||
                  predictionValues['home'] != null &&
                      predictionValues['home'] >= 80 ||
                  predictionValues['away'] != null &&
                      predictionValues['away'] >= 80)) {
            return true;
          }
          return false;
        });
      }
      return false;
    }).toList();

    // Process the filtered fixtures further as needed (e.g., shuffle, select a subset)
    filteredFixtures.shuffle();
    final selectedFixtures = filteredFixtures.take(20).toList();

    // Navigate to the next screen with the selected fixtures
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenerateFixture(
          fixturesData: {'data': selectedFixtures},
          numberOfResponses: int.parse(numberOfResponsesController.text),
        ),
      ),
    );

    setState(() {
      isLoading = false; // Hide loading indicator
    });
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
                color: Color(0xff000080),
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
                            "Event Start Date",
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
                            "Event End Date",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Number of Event",
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Events"),
                                  content: TextField(
                                    controller: numberOfResponsesController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText:
                                            "Enter Number of Events of Selected Date"),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        int? inputNumber = int.tryParse(
                                            numberOfResponsesController.text);
                                        if (inputNumber != null &&
                                            inputNumber > 0 &&
                                            inputNumber <= 20) {
                                          setState(() {
                                            numberOfResponses = inputNumber;
                                          });
                                          Navigator.of(context).pop();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Please enter a valid number (1-20)")),
                                          );
                                        }
                                      },
                                      child: Text("OK"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          controller: numberOfResponsesController,
                          labelText: "20",
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                          onSaved: (val) {},
                          textInputAction: TextInputAction.done,
                          isPassword: false,
                          enabled: true,
                        ),
                      ),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
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
