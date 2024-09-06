import 'package:flutter/material.dart';

class FaqMobilePage extends StatefulWidget {
  const FaqMobilePage({super.key});

  @override
  State<FaqMobilePage> createState() => _FaqMobilePageState();
}

class _FaqMobilePageState extends State<FaqMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("THE GAME PREDICTION FAQ"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: Text('What is The Game Before The Game?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'ThThe Game Before The Game is a web platform offering paid football predictions and soccer tips. Our predictions are based on comprehensive football stats and are meticulously prepared by professional tipsters using various analytical systems.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('Who are you behind this website?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'We are a dedicated team of tipsters committed to providing successful predictions. We attend lectures on football philosophy, watch matches live, and stay updated on all aspects of the game to continuously enhance our expertise and insights.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text(
                  'How long have you been in the betting industry and what is your experience?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'Our team has been involved in the betting industry for over a decade. Each member has extensive experience, including participating in forums and social networks to share insights and information on local football championships. Many of us are long-time friends, and our success is built on mutual confidence and loyalty.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('How many predicted matches do you provide per day?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'We carefully select and provide predictions for a specific number of matches each day, ensuring that each service is tailored to offer the most accurate insights for that day’s games.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('How Are Your VIP Predictions Selected?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'Our VIP predictions are derived from a comprehensive analysis of factors including team and player strength, current streaks, and home ground advantage. While we focus exclusively on football, we ensure that our paid subscribers receive predictions with the highest potential for success.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('What are 1.5 Goals Football Predictions?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      '1.5 Goals Football Predictions indicate that it is expected for the match to have at least two goals scored by the end of the 90 minutes. This type of prediction focuses on whether the total number of goals scored in the game will exceed 1.5.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('How Accurate Are Your Football Predictions?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'While no prediction can offer a 100% guarantee in sports betting, our team conducts thorough analyses to enhance accuracy. Our subscription plan is crafted to minimize risks by focusing on the safest football betting markets and providing well-researched selections for our valued subscribers.'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            ExpansionTile(
              title: Text('If I Lose, Do You Offer a Refund?'),
              children: <Widget>[
                ListTile(
                  title: Text(
                      'Please note that we do not offer refunds once payment has been made. By subscribing to any plan on gamebeforegame.com, you acknowledge that our predictions and tips are for informational purposes only, and we are not liable for any losses you may incur. Users under 18 should seek parental consent..'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
