import 'package:flutter/material.dart';
import 'package:helping_hands_app/constant.dart';

class WorkerItem extends StatelessWidget {
  final String name;
  final double rating;
  final String image;
  WorkerItem({this.name, this.rating, this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        subtitle: Text('8949499892'),
        leading: CircleAvatar(
          child: Image(
            image: AssetImage(image),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold, wordSpacing: 2, letterSpacing: 1),
        ),
        trailing: SizedBox(
          width: 55,
          child: Row(
            children: [
              Icon(Icons.star, color: kdarkBlue),
              SizedBox(width: 5),
              Text('4.5')
            ],
          ),
        ),
      ),
    );
  }
}
