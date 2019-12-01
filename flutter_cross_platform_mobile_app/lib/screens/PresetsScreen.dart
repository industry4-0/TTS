import 'dart:async';

import 'package:TTS_Device_Manager/screens/ConfigurePresetScreen.dart';
import 'package:TTS_Device_Manager/screens/RunningJobScreen.dart';
import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/DB.dart';
import 'package:TTS_Device_Manager/features/preset/preset.dart';
import 'package:TTS_Device_Manager/features/preset/preset_list_item.dart';

class PresetsScreen extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final String deviceName;

 

  PresetsScreen({this.onPressed, this.tooltip, this.icon, this.deviceName});

  @override
  _PresetsScreenState createState() => _PresetsScreenState();
}
enum ConfirmAction { CANCEL, ACCEPT }
class _PresetsScreenState extends State<PresetsScreen>
    with SingleTickerProviderStateMixin {  
      
  Preset selectedPreset;
  bool isOpened = false;
  AnimationController _animationController;
  

  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  String deviceNameString = "";
  int currentSelectedIndex;
  bool floatingButtonsOpen;
  
  @override
  Widget build(BuildContext context) {
    if(widget.deviceName != null){
      setState(() {
        deviceNameString = widget.deviceName;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Presets $deviceNameString"),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: DB.presets.length,
              itemBuilder: (context, index) {
                return PresetListItem(
                  index: index,
                  isSelected: currentSelectedIndex == index,
                  preset: DB.presets[index],
                  onSelect: () {
                    _handleTap(index);
                  },
                );
              }),
          Positioned(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Transform(
                    transform: Matrix4.translationValues(
                      274.0,
                      _translateButton.value * 3.0,
                      0.0,
                    ),
                    child: start(),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                      247.0,
                      _translateButton.value * 2.0,
                      0.0,
                    ),
                    child: schedule(),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                      280.0,
                      _translateButton.value,
                      0.0,
                    ),
                    child: edit(),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  Widget start() {
    return Row(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Text(
          "Start",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      FloatingActionButton(
        heroTag: "start",
        onPressed: () => _handleActionTap('Start', currentSelectedIndex),
        tooltip: 'Start',
        child: Icon(Icons.airplay),
      ),
    ]);
  }

  Widget schedule() {
    return Row(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Text(
          "Schedule",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      FloatingActionButton(
        heroTag: "schedule",
        onPressed: () => _handleActionTap('Schedule', currentSelectedIndex),
        tooltip: 'Schedule',
        child: Icon(Icons.schedule),
      ),
    ]);
  }

  Widget edit() {
    return Row(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Text(
          "Edit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      FloatingActionButton(
        heroTag: "edit",
        onPressed: () => _handleActionTap('Edit', currentSelectedIndex),
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    ]);
  }

  _handleTap(int index) {
    animate(index);
    print("handleTAP");
    setState(() {
      if (currentSelectedIndex != index) {
        currentSelectedIndex = index;
      } else {
        currentSelectedIndex = null;
      }
    });
  }

  _handleActionTap(String action, int selectedIndex) {
    switch (action) {
      case "Edit":
        {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfigurePresetScreen(
                  preset: DB.presets[currentSelectedIndex],
                  presetIndex: currentSelectedIndex),
            ),
          );
        }
        break;
      case "Start":
      {
        _asyncConfirmDialog(context);
      }
      break;
    }
    print("Action $action called for preset with index: $selectedIndex");
  }


 
Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('CAUTION'),
        content: const Text(
            'The device may explode! Are you sure you want to continue this madness?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text('Start'),
            onPressed: () {
              
              //Navigator.of(context).pop(ConfirmAction.CANCEL);
            // Navigator.popUntil(context, (route) {
            //   return route.settings.name == "/presets";
            // });
            //Navigator.pop(context);
              Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RunningJobsScreen(
                  preset: DB.presets[currentSelectedIndex],
                  presetIndex: currentSelectedIndex),
            ),
          );
            },
          )
        ],
      );
    },
  );
}
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate(int index) {
    if (index == currentSelectedIndex) {
      _animationController.reverse();
      isOpened = false;
    } else {
      _animationController.reverse();
      new Timer(const Duration(milliseconds: 250), () {
        _animationController.forward();
      });
    }
    // if (!isOpened) {
    //   _animationController.forward();
    // } else {
    //   _animationController.reverse();
    // }
    // isOpened = !isOpened;
  }
}
