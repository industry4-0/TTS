import 'dart:async';

import 'package:TTS_Device_Manager/SizeConfig.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';
import 'package:TTS_Device_Manager/widgets/bottle.dart';
import 'package:TTS_Device_Manager/features/preset/preset.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class RunningJobsScreen extends StatefulWidget {
  //final Preset preset;
  final int presetIndex;
  final Preset preset;
  // In the constructor, require a Preset.
  RunningJobsScreen(
      {Key key, @required this.preset, @required this.presetIndex})
      : super(key: key);

  @override
  _RunningJobsScreenState createState() => _RunningJobsScreenState();
}

double _firstRowSize = SizeConfig.blockSizeVertical * 2;

class _RunningJobsScreenState extends State<RunningJobsScreen> {
  Map<int, int> matrix = new Map<int, int>();

  int step = 0;
  int currentBottle = 0;
  Timer timer;
  double percentageDouble = 0.0;
  double addEveryTime = 0;
  
  @override
  initState() {
    int length = widget.preset.quantity == 30
        ? UtilityConstants.TOTAL_SOCKETS_30_ML
        : UtilityConstants.TOTAL_SOCKETS_60_ML;
    addEveryTime = 100 / (widget.preset.bottles * 10);
    setState(() {
      for (int i = 0; i < length; i++) {
        matrix[i] = 0;
        //print("matrix[$i]: " + matrix[i].toString() );
      }
    }); 
    this.getJSONData();

    Timer(Duration(seconds: 2), () {
      print(widget.preset.fillingTime * 1000);
      Timer.periodic(Duration(milliseconds: (widget.preset.fillingTime * 100).round()), (timer) {
        setState(() {
          step++;
          matrix[currentBottle]++;
          percentageDouble += addEveryTime;
        });
        if (step == 10) {
          setState(() {
            currentBottle++;
            step = 0;
          });
        }
        if (currentBottle == widget.preset.bottles) {
          timer.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  final String url = UtilityConstants.URI;
  List data;
  final String _jsonn = '{' +
      '"quantity": 30,' +
      '"bottles": 104,' +
      '"fillingTime": 1,' +
      '"startIndex": 1' +
    '}';
  Future<String> getJSONData() async {
    Map<String, String> headersMap = new Map<String, String>();
    headersMap["Content-Type"] = 'application/json';
    var response = await http.post(url, body: _jsonn, headers: headersMap);
    

    // Future implementation of integrating with arduino devise on real life;


    return "Successfull";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job in progress')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
                child: Card(
                    child:
                        topProgressBar(currentBottle, widget.preset.bottles))),
          ),
          Expanded(
            flex: 7,
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: widget.preset.quantity == 30
                  ? UtilityConstants.BOTTLES_PER_ROW_30_ML
                  : UtilityConstants.BOTTLES_PER_ROW_60_ML,
              childAspectRatio: widget.preset.quantity == 30 ? 1.1 : 1.1,

              // Generate 100 widgets that display their index in the List.
              children: List.generate(
                  widget.preset.quantity == 30
                      ? UtilityConstants.TOTAL_SOCKETS_30_ML
                      : UtilityConstants.TOTAL_SOCKETS_60_ML, (index) {
                return Center(
                    child: BottleWidget(
                  step: matrix[index],
                  isFilled: true,
                  index: index,
                  totalSocketsUser: widget.preset.bottles,
                ));
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
            height: 50.0,
            child: Card(
              child: bottomActionBar,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        backgroundColor: Colors.red,
        tooltip: 'Increment Counter',
        child: Icon(
          Icons.stop,
          color: Colors.yellow,
          semanticLabel: "test",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget topProgressBar(int currentBottle, int totalBottles) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$currentBottle/$totalBottles",
            style: TextStyle(fontSize: _firstRowSize),
          ),
          Icon(
            Icons.battery_full,
            //size: 40,
          )
        ],
      ),
      Text(
        '${percentageDouble.round()}%',
        style: TextStyle(
          color: Colors.black,
          //fontWeight: FontWeight.w800,
          //fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: _firstRowSize,
        ),
      ),
    ]);
  }

  var bottomActionBar = Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      //Expanded(
      //flex: 1,
      //child:
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.linked_camera,
            //size: 40,
          ),
          Text(
            "Live Cam",
            style: TextStyle(fontSize: _firstRowSize),
          ),
        ],
      ),

      Text(
        'Pause',
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 0.5,
          fontSize: _firstRowSize,
        ),
      ),
    ],
  );
}
