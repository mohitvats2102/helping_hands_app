import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';
import 'package:helping_hands_app/demo_workers.dart';

import '../widget/worker_item.dart';

class WorkerScreen extends StatelessWidget {
  static const String workerscreen = '/workerscreen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    final double _mainScreenHeight = (_mediaQuery.size.height) -
        (_mediaQuery.padding.top + _mediaQuery.padding.bottom + 56);
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final assetImage = routeArgs['assetImage'];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Container(
            color: kdarkBlue,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: Hero(
              tag: 'animation$title',
              child: Image.asset(
                assetImage,
                height: _mainScreenHeight * 0.40,
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
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
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
              height: _mainScreenHeight * 0.75,
              width: _mediaQuery.size.width,
              decoration: kloginContainerDecoration.copyWith(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, right: 5, top: 15, left: 5),
                child: title == 'Electrician'
                    ? StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('categories/electrician/workers')
                            .snapshots(),
                        builder: (context, asyncSnapshot) {
                          if (!asyncSnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: asyncSnapshot.data.docs.length,
                              itemBuilder: (ctx, index) {
                                final _workerData =
                                    asyncSnapshot.data.docs[index];

                                return WorkerItem(
                                  name: _workerData['name'],
                                  rating: 4.5, //_workerData['rating'],
                                  image: 'assets/images/contactimage.png',
                                );
                              });
                        },
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: Demo_Worker.length,
                        itemBuilder: (ctx, index) => WorkerItem(
                            name: Demo_Worker[index].name,
                            rating: Demo_Worker[index].rating,
                            image: Demo_Worker[index].image),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//print(MediaQuery.of(context).padding.bottom);
//print(MediaQuery.of(context).size.height);
//print(AppBar().preferredSize.height);
