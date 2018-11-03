import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import '../models/colors.dart';

class Main extends StatefulWidget {

  @override 
  MainState createState() => new MainState();
}

class MainState extends State<Main> {

  int index = 0;

  List<Widget> pages = [
    new Home(),
    new Home(),
  ];

  List<BottomNavigationBarItem> navItems = [
    new BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: new Text("Home"),
    ),
    new BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: new Text("Home"),
    )
  ];

  void onTabTapped(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        fixedColor: Colors.white,
        currentIndex: index,
        onTap: onTabTapped,
        items: navItems,
      ),
      body: pages[index],
    );
  }
}