import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

import 'confirm_booking.dart';

class WorkerDetailScreen extends StatelessWidget {
  static const String worker_route =
      '/workerroute'; //remember not to give name same as WorkerScreen it will cause trouble

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    final double _mainScreenHeight = (_mediaQuery.size.height) -
        (_mediaQuery.padding.top + _mediaQuery.padding.bottom + 56);

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final workerName = routeArgs['name'];
    final workerRating = routeArgs['rating'];
    final String workerImage = routeArgs['image'];

    return Scaffold(
      body: Stack(
        children: [
          Container(),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: Hero(
              tag: '$workerName',
              child: Image.asset(
                workerImage,
                height: _mainScreenHeight * 0.35,
                width: _mediaQuery.size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: _mediaQuery.padding.top + 10,
            left: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  workerName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: _mainScreenHeight * 0.80,
              width: _mediaQuery.size.width,
              decoration: kloginContainerDecoration.copyWith(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, top: 16, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      WorkerDetailCard(
                        workerName: workerName,
                        rating: workerRating,
                      ),
                      SizedBox(height: 30),
                      RaisedButton.icon(
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: kdarkBlue,
                        onPressed: () async {
                          var val = await Navigator.of(context).pushNamed(
                            BookingScreen.bookingPageRoute,
                            arguments: {
                              'image': workerImage,
                            },
                          );
                          if (val != null) Navigator.of(context).pop(val);
                        },
                        icon: Icon(Icons.book_outlined, color: Colors.white),
                        label: Text(
                          'Book Now',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(height: 20),
                      RaisedButton.icon(
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: kdarkBlue,
                        onPressed: () {},
                        icon: Icon(Icons.phone, color: Colors.white),
                        label: Text(
                          'Call Now',
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkerDetailCard extends StatelessWidget {
  final String workerName;
  final double rating;
  WorkerDetailCard({this.workerName, this.rating});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person, color: kdarkBlue),
              title: Text(
                workerName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: kdarkBlue),
              title: Text(
                'Murli Colony, Ward No. 18, Shiv Hari Sadan , Near Jhulelal Temple , Sector 24 ,Khairthal  ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: kdarkBlue),
              title: Text(
                '8949499892',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.star, color: kdarkBlue),
              title: Text(
                rating.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shop_outlined, color: kdarkBlue),
              title: Text(
                'Gada Electronics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
