import 'package:TTS_Device_Manager/widgets/statisticCircle.dart';
import 'package:flutter/material.dart';


class Statistics extends StatefulWidget {


@override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistical Information"),
      ),
      body: StatisticCircle(counter: 1,),
    );
  }

}