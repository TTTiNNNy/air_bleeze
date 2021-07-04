import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}


class ModelBLE
{
  ModelBLE(){}
  List<ScanResult> DeviceList = [];

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
   List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  List<ScanResult> scanDevices = [];
  ScanResult? activeResult;
  late List<BluetoothService> activeServices;
  String activeServiceName = "";
  List<String> servicesName = [""];
   BluetoothService? activeService;
   List<String> characteristics = [""];
   String activeCharacteristic = "";


  int _counter = 0;
   String dropdownValue = 'A';



   Future<void> _incrementCounter()  async {

    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 1));
    entries = [];
    scanDevices = [];
    Map<String,bool> map = Map();

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        //print('${r.device.name} found! rssi: ${r.rssi}');
        print("in loop : " + '${r.device.name} found! rssi: ${r.rssi}');
        if (map[r.device.name] == null && r.device.name!=""){map[r.device.name] = true; scanDevices.add(r);}

      }
      print("after loop: " + entries.toString());
    });
    flutterBlue.stopScan();
    await Future.delayed(const Duration(seconds: 1));
    map.forEach((key, value) {entries.add(key);});
    dropdownValue = entries[0];
    //dropdownValue = device.name;


    setState(() {
      _counter++;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title!),
      ),
      body: Row
        (
          children:
          [
            Expanded( child:
            DropdownButton<String>(
              isExpanded: false,
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) async {
                activeServiceName = "";
                activeServices = [];
                servicesName = [];
                activeResult?.device.disconnect();
                for(var device in scanDevices)
                {
                  if(device.device.name == newValue)
                  {
                    await device.device.connect();
                    activeResult = device;
                    activeServices = await activeResult!.device.discoverServices();

                    activeServices.forEach((service) {
                      print(service.toString());
                      activeService = service;
                      activeServiceName = service.uuid.toString();
                      servicesName.add(service.uuid.toString());
                    });
                    activeServiceName = servicesName.first;
                    break;
                  }
                }
                setState(() {});

              },
              items: entries.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
            ),
            SizedBox(width: 100, child:
            DropdownButton<String>(
              isExpanded: false,
              value: activeServiceName,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) async{
                activeServiceName = newValue!;
                for(var serv in activeServices )
                {
                  if(serv.uuid.toString() == activeServiceName){ activeService = serv; break;}
                }
                var characteristics = activeService!.characteristics;
                for(BluetoothCharacteristic c in characteristics)
                {
                  List<int> value = await c.read();
                  print(value);
                }
                setState(() {});
              },
              items: servicesName
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
            ),
            DropdownButton<String>(
              value: activeCharacteristic,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {

                  activeResult?.device.disconnect();
                  for(var device in scanDevices)
                  {
                    if(device.device.name == newValue)
                    {
                      device.device.connect();
                      activeResult = device;
                    }
                  }
                });
              },
              items: characteristics
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

