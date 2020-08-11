import 'dart:ui';

import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  final int number;
  final String title;
  final IconData icon;
  final MaterialColor color;
  DashboardTile({this.number = 0, this.color, this.icon, this.title}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [color.shade400, color.shade600])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Icon(icon, color: Colors.white, size: 40),
          Text(
            "$number",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
