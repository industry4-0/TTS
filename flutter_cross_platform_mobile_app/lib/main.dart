import 'package:TTS_Device_Manager/screens/DevicesScreen.dart';
import 'package:TTS_Device_Manager/screens/HomeScreen.dart';
import 'package:TTS_Device_Manager/screens/InboxScreen.dart';
import 'package:TTS_Device_Manager/screens/StatisticsPage.dart';
import 'package:TTS_Device_Manager/widgets/gridview.dart';
import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/screens/PresetsScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static bool testRun = false;
  final MyGridView myGridView = MyGridView();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'TTS Device Manager',
      initialRoute: '/',
      routes: {
        '/' : (context) => HomeScreen(),
        '/devices' : (context) => Devices(),
        '/inbox' : (context) => Inbox(),
        '/presets'  : (context) => PresetsScreen(),
        '/statistical-information'  : (context) => Statistics(),
        //'/faq' : (context) => FaqScreen(),
        //'/about' : (context) => AboutScreen(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
