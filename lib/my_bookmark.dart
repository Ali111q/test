import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/widgets/bookmark_widget.dart';

class myBookmark extends StatefulWidget {
  const myBookmark({Key? key}) : super(key: key);

  @override
  State<myBookmark> createState() => _myBookmarkState();
}

class _myBookmarkState extends State<myBookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'My Bookmark',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.assignment_outlined)),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.grid_view_rounded,
                color: Colors.green,
              )),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                children: [
                  ...snapshot.data!.docs.map((e) {
                    return bookmarkWidget(
                      hotelName: e['hotelName'],
                      nightPrice: e['nightPrice'],
                      image: e['photos'],
                      review: e['review'],
                      hotelId: e['hotelId'],
                      place: e['place'],
                    );
                  })
                ],
              );
            }
          }),
    );
  }
}
