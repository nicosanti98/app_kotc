import 'dart:io';

import 'package:app_kotc/Contatti.dart';
import 'package:app_kotc/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Partnershipv1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'King of the Cage',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        textTheme: TextTheme(caption: TextStyle(fontFamily: 'roboto')),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.black87, fontFamily: 'roboto'))
      ),
      home: MyHomePage(title: 'King of the Cage'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedBottomNavIndex = 0;

  static  List<Widget> Views = <Widget>[
    HomePage().getHomePage(),
    Contacts().getContacts(),
    ProvaPartnership().getPartnership(),

  ];

  void _setSelectedBottomNavIndex(int index){
    _selectedBottomNavIndex = index;

    setState(() {
    });
  }

  BottomBarSpecific()
  {
    if(Platform.isAndroid)
      {
        return BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Colors.orange),
          unselectedIconTheme: IconThemeData(color: Colors.black54),
          fixedColor: Colors.black54,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball,),
              title: Text('Home Page'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_call,),
                title: Text('Contatti')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up,),
              title: Text('Partnership'),
            ),

          ],
          currentIndex: _selectedBottomNavIndex,
          onTap: _setSelectedBottomNavIndex,
        );
      }
    else
      {
        return CupertinoTabBar(
          activeColor: Colors.orange,
          inactiveColor: Colors.black54,

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball,),
              title: Text('Home Page'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_call,),
                title: Text('Contatti')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up,),
              title: Text('Partnership'),
            ),

          ],
          currentIndex: _selectedBottomNavIndex,
          onTap: _setSelectedBottomNavIndex,
        );
      }

  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        child: Views.elementAt(_selectedBottomNavIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.orange),
        unselectedIconTheme: IconThemeData(color: Colors.black54),
        fixedColor: Colors.black54,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball,),
            title: Text('Home Page'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_call,),
            title: Text('Contatti')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up,),
            title: Text('Partnership'),
          ),

        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: _setSelectedBottomNavIndex,
      ),
    );



  }
}
