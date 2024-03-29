import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

import '../widget/worker_item.dart';

bool counter = false;

class WorkerScreen extends StatefulWidget {
  static const String workerscreen = '/workerscreen';

  @override
  _WorkerScreenState createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List _workersList = [];
  String _title = '';
  String _imageUrl = '';
  String _docId = '';
  bool isNull = false;

  @override
  void didChangeDependencies() async {
    isNull = false;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _title = routeArgs['title'];
    _imageUrl = routeArgs['imageUrl'];
    _docId = routeArgs['docId'];
    // print('DOC ID HERE $_docId');
    try {
      final DocumentSnapshot _docSnap =
          await _firestore.doc('categories/$_docId').get();
      _workersList = _docSnap.data()['workersList'];
      if (_workersList.length == 0) isNull = true;

      setState(() {});
    } catch (e) {
      print(e.toString());
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final title = routeArgs['title'];
    // final _imageUrl = routeArgs['imageUrl'];
    // final _docId = routeArgs['docId'];

    MediaQueryData _mediaQuery = MediaQuery.of(context);
    final double _mainScreenHeight = (_mediaQuery.size.height) -
        (_mediaQuery.padding.top + _mediaQuery.padding.bottom + 56);

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
              tag: 'animation$_title',
              child: Image.network(
                _imageUrl,
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
                  _title,
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
                child: !isNull
                    ? RefreshIndicator(
                        color: kdarkBlue,
                        onRefresh: () async {
                          didChangeDependencies();
                          //setState(() {});
                        },
                        child: FutureBuilder<QuerySnapshot>(
                          future: _firestore.collection('workers').get(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.hasError) {
                              return Center(
                                child: Text(
                                    'Something went wrong!!\nPlease Try again later'),
                              );
                            }
                            if (asyncSnapshot.connectionState ==
                                ConnectionState.done) {
                              List<QueryDocumentSnapshot> categoryWorker;

                              categoryWorker =
                                  asyncSnapshot.data.docs.where((docSnap) {
                                return _workersList.contains(docSnap.id);
                              }).toList();

                              return ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: categoryWorker.length,
                                itemBuilder: (ctx, index) {
                                  // QueryDocumentSnapshot document=workersList[index];
                                  final _workerDoc = categoryWorker[index];
                                  // print(_workerDoc.id);
                                  final _workerData = _workerDoc.data();
                                  return WorkerItem(
                                    name: _workerData['name'],
                                    rating: double.parse(_workerData['rating']),
                                    imageUrl: _workerData['image'],
                                    charges: _workerData['charges'],
                                    shopName: _workerData['shopname'],
                                    contact: _workerData['contact'],
                                    address: _workerData['address'],
                                    workerDocID: _workerDoc.id,
                                  );
                                },
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: kdarkBlue,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Coming soon.....',
                          style: TextStyle(
                            color: Colors.black,
                          ),
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

//print(MediaQuery.of(context).padding.bottom);
//print(MediaQuery.of(context).size.height);
//print(AppBar().preferredSize.height);

// ListView.builder(
// physics: BouncingScrollPhysics(
// parent: AlwaysScrollableScrollPhysics()),
// itemCount: Demo_Worker.length,
// itemBuilder: (ctx, index) => WorkerItem(
// name: Demo_Worker[index].name,
// rating: Demo_Worker[index].rating,
// image: Demo_Worker[index].image,
// charges: Demo_Worker[index].charges,
// address: Demo_Worker[index].address,
// contact: Demo_Worker[index].contact,
// shopName: Demo_Worker[index].shopName,
// ),
// ),
