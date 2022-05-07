import 'package:flutter/material.dart';

class reviewWidget extends StatelessWidget {
  const reviewWidget(
      {Key? key,
      required this.userImage,
      required this.review,
      required this.userName,
      required this.ratinf})
      : super(key: key);
  final userImage;
  final review;
  final userName;
  final ratinf;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(userImage),
                      ),
                      Container(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('December 1 2024')
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.white,
                      ),
                      Text(
                        '$ratinf',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 10,
            ),
            Text(
              review,
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
