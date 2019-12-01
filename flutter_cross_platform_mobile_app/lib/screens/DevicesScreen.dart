import 'dart:async';

import 'package:TTS_Device_Manager/main.dart';
import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';
import 'package:TTS_Device_Manager/widgets/device.dart';

class Devices extends StatefulWidget {
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  Map<int, String> devicesMatrix = new Map<int, String>();
  Timer timer;
  @override
  void initState() {
    if (!MyApp.testRun) {
      devicesMatrix[0] = "Loading";
      devicesMatrix[1] = "Loading";
      Timer(Duration(milliseconds: 1500), () {
        print("timer");
        setState(() {
          MyApp.testRun = true;
          devicesMatrix[0] = "Connected";
          devicesMatrix[1] = "Disconnected";
        });
      });
      //timer.cancel();
    } else {
      setState(() {
        devicesMatrix[0] = "Connected";
        devicesMatrix[1] = "Disconnected";
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UtilityConstants.DEVICES),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: <Widget>[
          Device(
              fullName: 'FS 10477',
              subTitle: 'Finished Jobs: 2 Queued Jobs: 0',
              state: devicesMatrix[0]),
          Device(
              fullName: 'SM 0415',
              subTitle: 'Finished Jobs: 0 Queued Jobs: 2',
              state: devicesMatrix[1]),
        ],
      ),
    );
  }
}
