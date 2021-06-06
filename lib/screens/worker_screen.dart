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
  List workersList;
  String title;
  String _imageUrl;
  String _docId;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    title = routeArgs['title'];
    _imageUrl = routeArgs['imageUrl'];
    _docId = routeArgs['docId'];
    // print('DOC ID HERE $_docId');
    final DocumentSnapshot _docSnap =
        await _firestore.doc('categories/$_docId').get();
    workersList = _docSnap.data()['workersList'];
    print('WORKER LIST HERE :- $workersList');
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
              tag: 'animation$title',
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
                child: workersList != []
                    ? RefreshIndicator(
                        color: kdarkBlue,
                        onRefresh: () async {
                          setState(() {});
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
                              //  if (workersList != null) {
                              categoryWorker =
                                  asyncSnapshot.data.docs.where((docSnap) {
                                return workersList.contains(docSnap.id);
                              }).toList();
                              //}
                              //print('FINAL OUTPUT OF WORKERS $categoryWorker');
                              // for (int i = 0; i < categoryWorker.length; i++) {
                              //   print(
                              //       'FINAL OUTPUT OF WORKERS ${categoryWorker[i].data()}');
                              // }
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
                                  );
                                },
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kdarkBlue,
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text('Coming soon.....',
                            style: TextStyle(
                              color: Colors.black,
                            )),
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
