import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}

class PreludeScaff extends StatelessWidget
{
  String? title;
  Widget child;
  PreludeScaff(this.child, {this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title == null? "" : title!),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('InitDevice'),
              onTap: () {

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => InitDevice()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text('SetDevicePage'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('ControlDevicePage'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ControlDevicePage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              title: Text('SetAutoDevicePage'),
              onTap: () {

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: child,

    );
  }

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Air bleeze',
      initialRoute: "/InitDevice",

      routes:
      {
        '/InitDevice'       : (context) => InitDevice(),
        '/SetDevicePage'    : (context) => InitDevice(),
        '/ControlDevicePage': (context) => ControlDevicePage(),
        '/SetAutoDevicePage': (context) => InitDevice(),
      },
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class InitDevice extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return PreludeScaff(Center( child: Container(child: TextButton(child: Text("InitDevice"), onPressed: (){},),)));
  }
}

class ControlDevicePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return ControlDevicePageState();
  }

}

class ControlDevicePageState extends State<ControlDevicePage> with SingleTickerProviderStateMixin
{
  static var _TabPages = <Widget>
  [
    Container(child: TextButton(child: Text("temp"),        onPressed: (){},)),
    Container(child: TextButton(child: Text("press"),     onPressed: (){},)),
    Container(child: TextButton(child: Text("hum"), onPressed: (){},)),
  ];

  static var _Tabs = <Tab>[
    Tab(icon: Icon(Icons.thermostat), text: "temp",),
    Tab(icon: Icon(Icons.compress), text: "press",),
    Tab(icon: Icon(Icons.filter_drama), text: "hum",)
  ];

  late TabController _tabControl;

  @override
  void dispose() {
    _tabControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabControl = TabController(length: _Tabs.length, vsync: this);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: TabBarView(
      controller: _tabControl, children: _TabPages,),
        bottomNavigationBar: Material(color: Colors.amber, child: TabBar(
          tabs: _Tabs,
          controller: _tabControl,
        ),
      ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('InitDevice'),
                onTap: () {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => InitDevice()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              ListTile(
                title: Text('SetDevicePage'),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('ControlDevicePage'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ControlDevicePage()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              ListTile(
                title: Text('SetAutoDevicePage'),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
    );

  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


   void _incrementCounter()   {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
     return PreludeScaff(Text("qwe"));

  }
}

