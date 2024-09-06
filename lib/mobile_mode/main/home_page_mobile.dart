import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportwave/mobile_mode/home_page_response/home_fixture.dart';
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

        // Pretty print the JSON in chunks to avoid truncation
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        String prettyPrintedJson = encoder.convert(decodedResponse);

        // Print the response in chunks of 800 characters
        final pattern =
            RegExp('.{1,800}'); // 800 is a safe limit for Flutter's print()
        pattern
            .allMatches(prettyPrintedJson)
            .forEach((match) => print(match.group(0)));

        // Add fixtures from the current page to the list
        allFixtures.addAll(decodedResponse['data']);

        // Check if there's more data to fetch
        hasMore = decodedResponse['pagination']['has_more'];
        currentPage++;
      } else {
        print("API request failed with status code: ${response.statusCode}");
        break;
      }
    }

    setState(() {
      isLoading = false; // Hide loading indicator
    });

    if (allFixtures.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeFixture(
            fixturesData: {'data': allFixtures},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                        isLoading
                            ? CircularProgressIndicator() // Show loading indicator while fetching data
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
