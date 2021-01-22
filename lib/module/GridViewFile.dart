import 'package:flutter/material.dart';
class GridViewFile{
  final String id;
  final String title;
  final Color color;

  const GridViewFile({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}