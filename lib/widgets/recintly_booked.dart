import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:test/hotel_screen.dart';

class recintlyBooked extends StatefulWidget {
  const recintlyBooked(
      {Key? key,
      required this.name,
      required this.photos,
      required this.place,
      required this.review,
      required this.price,
      required this.hotelId})
      : super(key: key);
  final name;
  final photos;
  final place;
  final review;
  final price;
  final hotelId;
  @override
  State<recintlyBooked> createState() => _recintlyBookedState();
}

class _recintlyBookedState extends State<recintlyBooked> {
  var review;
  double sum = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.review.forEach((item) {
      sum += item['rating'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return hotelScreen(
                hotelId: widget.hotelId,
              );
            }));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(179, 245, 241, 241)),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: MediaQuery.of(context).size.width * 0.28,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.photos[0],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${widget.place}',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[300],
                          ),
                          Text(
                            '${(sum / widget.review.length).toStringAsFixed(1)}',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '  (${widget.review.length} reviews)',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.070,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      12.0,
                      3,
                      12,
                      3,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              '\$${widget.price}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '/night',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_outline,
                              color: Colors.green,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
