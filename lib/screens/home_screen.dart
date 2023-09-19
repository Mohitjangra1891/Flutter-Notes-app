import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/api_three.dart';

import '../app_bar.dart';
import '../tabs/basic_tab.dart';
import 'api_one.dart';
import 'api_two.dart';
import 'favorites_screen.dart';

class home_screen extends StatefulWidget {
  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // Box<DataModel> basic_Box = Hive.box('basic');
  // Box<DataModel> advance_Box = Hive.box('advance');
  // Box<DataModel> example_Box = Hive.box('example');

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Basic'),
    Tab(text: 'Advanced'),
    Tab(text: 'Examples'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(),
      body: basic_tab(),
      drawer: nav_drawer(context),
    );
  }

  Drawer nav_drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text(
              'Flutter Notes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Favorites'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => favorites_screen()),
              );
            },
          ),
          ListTile(
            title: Text('Api 1'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => api_one()),
              );
            },
          ),
          ListTile(
            title: Text('Api 2'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => api_two()),
              );
            },
          ),
          ListTile(
            title: Text('Api 3'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => api_three()),
              );
            },
          ),

          // Add more list items or routes as needed
        ],
      ),
    );
  }
}
