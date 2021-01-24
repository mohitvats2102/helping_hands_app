import 'package:flutter/material.dart';

import '../screens/worker_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String assetImage;

  CategoryItem(this.id, this.title, this.assetImage);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        WorkerScreen.workerscreen,
        arguments: {
          'id': id,
          'title': title,
          'assetImage': assetImage,
        },
      ),
      splashColor: Theme.of(context).primaryColor,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Hero(
                tag: 'animation$title',
                child: Image.asset(
                  assetImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.all(5),
                width: 125,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Previous Code for Safty

// Container(
// padding: const EdgeInsets.fromLTRB(35.0, 30.0, 35.0, 80.0),
// child: Text(
// title,
// style: Theme.of(context).textTheme.title,
// ),
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// color.withOpacity(0.7),
// color,
// ],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// borderRadius: BorderRadius.circular(15),
// ),
// ),
