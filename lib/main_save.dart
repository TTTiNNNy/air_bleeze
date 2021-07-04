// import 'dart:html';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
//
// class ModelBLE
// {
//   ModelBLE(){}
//   List<ScanResult> DeviceList = [];
//
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//    List<String> entries = <String>['A', 'B', 'C'];
//   final List<int> colorCodes = <int>[600, 500, 100];
//   List<ScanResult> scanDevices = [];
//   int _counter = 0;
//
//   void _incrementCounter() {
//
//     FlutterBlue flutterBlue = FlutterBlue.instance;
//     flutterBlue.startScan(timeout: Duration(seconds: 1));
//     entries = [];
//     scanDevices = [];
//
//      flutterBlue.scanResults.listen((results) {
//       // do something with scan results
//       for (ScanResult r in results) {
//         //print('${r.device.name} found! rssi: ${r.rssi}');
//         entries.add(r.device.name + " " + r.rssi.toString());
//         print("in loop : " + entries.toString());
//         scanDevices.add(r);
//       }
//       print("after loop: " + entries.toString());
//     });
//     sleep(Duration(seconds:1));// Listen to scan results
//     flutterBlue.stopScan();
//     setState(() {
//       _counter++;
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text(widget.title!),
//       ),
//       body: ListViewBLEController(),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
//
// class DeviceBLE extends StatefulWidget {
//   bool is_active = false;
//   String text;
//   DeviceBLE(this.text);
//
//   @override
//   State<StatefulWidget> createState()
//   {
//     return StateDeviceBLE();
//   }
// }
//
// class StateDeviceBLE extends State<DeviceBLE>
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return TextButton
//       (
//         onPressed: ()  { widget.is_active = true; },
//       child: Center(child: Text(widget.text)),
//     );
//
//   }
//
// }
//
//
// class ListViewBLE extends StatelessWidget
// {
//   String text;
//   int size;
//
//   ListViewBLE(this.text,this.size);
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return ListView.builder
//       (
//         itemCount: size,
//         itemBuilder: (BuildContext context, int index)
//         {
//           return Container
//             (
//             height: 50,
//             child: TextButton(onPressed: () { cb(); },
//             child: Text(text)),
//           );
//         }
//     );
//   }
// }
//
// class ListViewBLEController extends StatefulWidget
// {
//   ModelBLE model;
//   ListViewBLEController(this.model, {required Key key,}) : super(key: key);
//   @override
//   State<StatefulWidget> createState()
//   {
//     return ListViewBLEControllerState();
//   }
// }
//
// class ListViewBLEControllerState extends State<ListViewBLEController>{
//
//   @override
//   Widget build(BuildContext context) {
//     return Row( children: <Widget>
//     [
//       SizedBox( width: 100, child: ListView.builder
//         (
//           itemCount: widget.model.DeviceList.length,
//           itemBuilder: (BuildContext context, int index)
//           {
//             return DeviceBLE(widget.model.DeviceList[index].device.name);
//           }
//       ),
//
//     ),
//       SizedBox( width: 100, child: ListView.builder(itemCount: entries.length,
//         itemBuilder: (BuildContext context, int index)
//         {return Container(height: 50, child: Center(child: Text('Entry ${entries[index]}')),);}),),
//       SizedBox( width: 100, child: ListView.builder(itemCount: entries.length, itemBuilder:
//         (BuildContext context, int index) {return Container(height: 50, child: Center(child: Text('Entry ${entries[index]}')),);}),)
//     ]);
//   }
// }
