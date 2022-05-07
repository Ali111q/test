import 'package:flutter/material.dart';
import 'package:test/hotel_screen.dart';

class bookmarkWidget extends StatefulWidget {
  const bookmarkWidget(
      {Key? key,
      required this.hotelName,
      required this.review,
      required this.image,
      required this.nightPrice,
      required this.place,
      required this.hotelId})
      : super(key: key);
  final hotelName;
  final review;
  final image;
  final nightPrice;
  final hotelId;
  final place;

  @override
  State<bookmarkWidget> createState() => _bookmarkWidgetState();
}

class _bookmarkWidgetState extends State<bookmarkWidget> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (contexy) => hotelScreen(
                    hotelId: widget.hotelId,
                  )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.width * 0.70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          height: MediaQuery.of(context).size.width * 0.36,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              widget.image[0],
                              fit: BoxFit.fill,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          widget.hotelName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[300],
                          ),
                          Text(
                            '${(sum / widget.review.length).toStringAsFixed(1)}',
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            '  ${widget.place}',
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${widget.nightPrice}\$',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                              ),
                              Text(
                                '/night',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.10,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50)),
                                    ),
                                    elevation: 10,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.40,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Text(
                                                'Remove From Bookmark?',
                                                style: TextStyle(fontSize: 22),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Material(
                                                elevation: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.asset(
                                                          'assets/images/test.png',
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'palazo versaca',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text('italia'),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amber[300],
                                                            ),
                                                            Text(
                                                              '4.7',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              ' 3,220 reviews',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          '\$36',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          ' /night',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                OutlinedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ))),
                                                    onPressed: () {},
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                        child: Center(
                                                            child: Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.green),
                                                        )))),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28.0),
                                                    ))),
                                                    onPressed: () {},
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                        child: Center(
                                                            child: Text(
                                                          'yes , remove ',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ))))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.bookmark_outline,
                                color: Colors.green,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
