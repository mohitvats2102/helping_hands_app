import 'package:flutter/material.dart';

class GridViewFileFrame extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  GridViewFileFrame(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.fromLTRB(35.0, 30.0, 35.0, 80.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
