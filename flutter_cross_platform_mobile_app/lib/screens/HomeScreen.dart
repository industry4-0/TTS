import 'package:TTS_Device_Manager/SizeConfig.dart';
import 'package:TTS_Device_Manager/widgets/gridview.dart';
import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';

class HomeScreen extends StatelessWidget {
  final MyGridView myGridView = MyGridView();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TTS Device Manager'),
        centerTitle: true,
        backgroundColor: UtilityConstants.APP_BAR_COLOR,
      ),
      body: myGridView.build(context),
    );
  }
}