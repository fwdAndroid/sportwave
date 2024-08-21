import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportwave/utils/colors.dart';

class NewsPageMobile extends StatefulWidget {
  const NewsPageMobile({super.key});

  @override
  State<NewsPageMobile> createState() => _NewsPageMobileState();
}

class _NewsPageMobileState extends State<NewsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Blogs",
          style: TextStyle(color: colorwhite),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: Color(0xff000080),
      ),
      body: Column(
        children: [
          Container(
            height: 460,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("blog").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Blog Posted",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        final Map<String, dynamic> data =
                            documents[index].data() as Map<String, dynamic>;

                        // Extract hours and minutes as integers

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(data['title']),
                              subtitle: Text(data['description']),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
