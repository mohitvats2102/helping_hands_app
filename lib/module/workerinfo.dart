import 'package:flutter/cupertino.dart';

class WorkerInfo
{
   final String name;
   final double rating;
   //final PhoneAuthCredential phonenumber;
   final String image;
  const WorkerInfo({
    @required this.name,
     @required this.rating,
   
     @required this.image
   });

}