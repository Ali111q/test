import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/login.dart';
import 'package:test/my_bookmark.dart';
import 'package:test/services/helia_module.dart';
import 'package:test/widgets/recintly_booked.dart';
import 'package:test/widgets/slider_widget.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  String selectedTag = 'Requmended';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Image.asset('assets/images/logo.PNG'),
        title: Text(
          'Hilea',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<myProvider>(context, listen: false).signOut();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return loginScreen();
                }));
              },
              icon: Icon(Icons.notifications_active_outlined)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => myBookmark()));
              },
              icon: Icon(Icons.bookmark_outline))
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Provider.of<myProvider>(context, listen: false).hotels,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            FirebaseAuth.instance.currentUser!.displayName !=
                                    null
                                ? 'Hello, ${FirebaseAuth.instance.currentUser!.displayName} '
                                : 'Hello, Ali',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextField(
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.filter_alt_outlined)),
                            prefixIcon: Icon(Icons.search),
                            hintText: 'search',
                            filled: true,
                            fillColor: Color(0xffFAFAFA),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        tag(name: 'Requmended'),
                        tag(name: 'Popular'),
                        tag(name: 'Trending'),
                        tag(name: '5stars')
                      ]),
                    ),
                    !snapshot.hasData
                        ? Container()
                        : CarouselSlider(
                            items: [
                                ...snapshot.data!.docs.map((e) {
                                  return sliderWidget(
                                    images: e['photos'],
                                    name: e['hotelName'],
                                    place: e['place'],
                                    nightPrice: e['nightPrice'],
                                    hotelId: e['hotelId'],
                                  );
                                })
                              ],
                            options: CarouselOptions(
                              autoPlay: false,
                              aspectRatio: 1.06,
                              padEnds: false,
                            )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recently Booked',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'See All',
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                    ...snapshot.data!.docs.map((e) {
                      return recintlyBooked(
                        hotelId: e['hotelId'],
                        name: e['hotelName'],
                        photos: e['photos'],
                        place: e['place'],
                        price: e['nightPrice'],
                        review: e['review'],
                      );
                    })
                  ],
                );
              }
            }),
      ),
    );
  }

  Padding tag({required name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTag = name;
          });
        },
        child: Material(
          borderRadius: BorderRadius.circular(24),
          elevation: 5,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(24),
              color: selectedTag == name ? Colors.green : Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      color: selectedTag == name ? Colors.white : Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
