import 'package:flutter/material.dart';
import 'package:helping_hands_app/demo_workers.dart';
class Worker extends StatelessWidget {
  final String name;
  final double rating;
  final String image;
  Worker({
this.name,
this.rating,
this.image
  });
  @override
  Widget build(BuildContext context) {
    
            return Card(
            child: ListTile(
            leading: CircleAvatar(child:Image(image:AssetImage(image))),
            title: Text(name),
             trailing: Icon(Icons.star),
      ),
    );
  }
}