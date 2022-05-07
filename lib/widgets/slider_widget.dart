import 'package:flutter/material.dart';
import 'package:test/hotel_screen.dart';

class sliderWidget extends StatefulWidget {
  const sliderWidget({
    Key? key,
    required this.images,
    required this.name,
    required this.place,
    required this.nightPrice,
    required this.hotelId,
  }) : super(key: key);
  final images;
  final name;
  final place;
  final nightPrice;
  final hotelId;
  @override
  State<sliderWidget> createState() => _sliderWidgetState();
}

class _sliderWidgetState extends State<sliderWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return hotelScreen(hotelId: widget.hotelId);
        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.green),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                widget.images[1],
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.95,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.name}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.place}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${widget.nightPrice}\$',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              '/per night',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
