import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/widgets/review.dart';

class hotelScreen extends StatefulWidget {
  const hotelScreen({Key? key, required this.hotelId}) : super(key: key);
  final hotelId;
  @override
  State<hotelScreen> createState() => _hotelScreenState();
}

var _mapStyle;

class _hotelScreenState extends State<hotelScreen> {
  late CarouselController carouselController2;
  late GoogleMapController _mapController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carouselController2 = CarouselController();
    rootBundle.loadString('assets/json_assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    List images = [];
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('hotels')
                .doc(widget.hotelId)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                images = snapshot.data!.get('photos');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          items: [
                            ...images.map((e) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.fill,
                                  ));
                            })
                          ],
                          options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            aspectRatio: 16 / 10,
                            viewportFraction: 1,
                          ),
                          carouselController: carouselController2,
                        ),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            children: [
                              ...images.mapIndexed((
                                ind,
                                e,
                              ) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (() =>
                                        carouselController2.jumpToPage(ind)),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      width: currentIndex == ind ? 30 : 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: currentIndex == ind
                                              ? Colors.green
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          top: 20,
                          left: 10,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data!.get('hotelName')}',
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.green,
                            ),
                            Text(
                              '${snapshot.data!.get('place')}',
                              style: TextStyle(color: Colors.black54),
                            )
                          ])
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        color: Colors.black54,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gallery Photos',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: [
                        ...images.map((e) => Container(
                            width: MediaQuery.of(context).size.width * 0.36,
                            height: MediaQuery.of(context).size.width * 0.28,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                e,
                                fit: BoxFit.fill,
                              ),
                            )))
                      ],
                      options: CarouselOptions(
                          viewportFraction: 0.4,
                          aspectRatio: 3.5,
                          padEnds: false),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detail(name: 'hotels'),
                          detail(name: 'bedrooms', optional: 2),
                          detail(name: 'bathrooms', optional: 2),
                          detail(name: 'sqft', optional: 4000)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('${snapshot.data!.get('description')}')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Facilites',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: facilites.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) {
                            return detail(name: facilites[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Container(
                            height: 12,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GoogleMap(
                                  zoomControlsEnabled: false,
                                  onMapCreated: (controller) {
                                    _mapController = controller;
                                    _mapController.setMapStyle(_mapStyle);
                                  },
                                  initialCameraPosition:
                                      CameraPosition(target: LatLng(0, 0))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Review ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber[400],
                                      ),
                                      Text(
                                        '4.2',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.green),
                                      ),
                                      Text(
                                        '(4,220 review)',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {}, child: Text('See All')),
                              ],
                            ),
                          ),
                          ...snapshot.data!.get('review').map((e) {
                            return reviewWidget(
                              review: e['review'],
                              userName: e['userName'],
                              ratinf: e['rating'],
                              userImage: e['userImage'],
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        '\$29',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                      Text(
                        '/night',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ))),
                    onPressed: () {},
                    child: Container(
                      height: 40,
                      width: 150,
                      child: Center(
                        child: Text('Book Now'),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Column detail({@required name, optional}) {
    return Column(
      children: [
        ImageIcon(
          AssetImage(
            'assets/icons/$name.png',
          ),
          size: 30,
          color: Colors.green,
        ),
        Text('${optional ?? ''} $name')
      ],
    );
  }

  int currentIndex = 0;

  List facilites = [
    'swimming pool',
    'wifi',
    'resturant',
    'parking',
    'meeting room',
    'elevator',
    'fitness center',
    '24-hours open'
  ];
  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    _mapController = controller;
  }
}
