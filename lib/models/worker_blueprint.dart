import 'package:flutter/cupertino.dart';

class WorkerBlueprint {
  final String name;
  final double rating;
  //final PhoneAuthCredential phonenumber;
  final String image;
  const WorkerBlueprint({
    @required this.name,
    @required this.rating,
    @required this.image,
  });
}
