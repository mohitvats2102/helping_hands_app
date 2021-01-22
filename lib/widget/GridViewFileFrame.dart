import 'package:flutter/material.dart';

class GridViewFileFrame extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final String assetImage;

  GridViewFileFrame(this.id, this.title, this.color, this.assetImage);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
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
              child: Image.asset(
                assetImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.fill,
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

//
// Card(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20),
// ),
// elevation: 20,
// margin: EdgeInsets.all(10),
// child:
// Stack(
// children: <Widget>[
// ClipRRect(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20),
// ),
// child: Image.asset(
// '',
// width: double.infinity,
// height: 250,
// fit: BoxFit.cover,
// ),
// ),
// Positioned(
// //this positioned widget only works in stack...
// bottom: 20,
// right: 10,
// child: Container(
// width: 300,
// color: Colors.black54,
// child: Text(
// title,
// style: TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.bold,
// color: Colors.white,
// ),
// overflow: TextOverflow.fade,
// softWrap: true,
// ),
// ),
// )
// ],
// ),),

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
