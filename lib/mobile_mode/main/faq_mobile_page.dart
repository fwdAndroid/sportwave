import 'package:flutter/material.dart';

class FaqMobilePage extends StatefulWidget {
  const FaqMobilePage({super.key});

  @override
  State<FaqMobilePage> createState() => _FaqMobilePageState();
}

class _FaqMobilePageState extends State<FaqMobilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ExpansionTile(
            title: Text(
                'What was the accuracy of sports prediction of this website ?'),
            children: <Widget>[
              ListTile(
                title: Text('The accuracy rate of the prediction is 100%'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ExpansionTile(
            title: Text('Is Prediction Data is real time or fixed ?'),
            children: <Widget>[
              ListTile(
                title: Text('Prediction data is real time'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ExpansionTile(
            title: Text(
                'What was the accuracy of sports prediction of this website ?'),
            children: <Widget>[
              ListTile(
                title: Text('The accuracy rate of the prediction is 100%'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ExpansionTile(
            title: Text('Is Prediction Data is real time or fixed ?'),
            children: <Widget>[
              ListTile(
                title: Text('Prediction data is real time'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ExpansionTile(
            title: Text(
                'What was the accuracy of sports prediction of this website ?'),
            children: <Widget>[
              ListTile(
                title: Text('The accuracy rate of the prediction is 100%'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
