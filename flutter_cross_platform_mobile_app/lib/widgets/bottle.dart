import 'dart:async';

import 'package:TTS_Device_Manager/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Bottle {
  bool filled;
  int index;
  int totalSocketsUser;
  int step;

  Bottle({this.filled, this.index});
}

class BottleWidget extends StatefulWidget {
  final bool isFilled;
  final int index;
  final int totalSocketsUser;
  final int step;

  const BottleWidget(
      {Key key,
      @required this.step,
      @required this.isFilled,
      @required this.index,
      @required this.totalSocketsUser})
      : assert(index != null),
        assert(step != null),
        assert(isFilled != null),
        assert(totalSocketsUser != null);

  @override
  _BottleWidgetState createState() => _BottleWidgetState();
}

class _BottleWidgetState extends State<BottleWidget> {
  Color color;
  bool isFilled;
  int index;
  int step;
  Timer timer;
  @override
  void initState() {
    super.initState();
    isFilled = false;
    step = 0;
  }

  @override
void dispose() {
  timer?.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconDatas(widget.step),
      color: returnTheValidColor(widget.index, widget.totalSocketsUser, widget.isFilled),
      size: SizeConfig.blockSizeHorizontal * 12,
    );
    
  }

  Color returnTheValidColor(int index, int totalSocketsUsed, bool isFilled) {
    if (index > totalSocketsUsed - 1) {
      return Color(0xffF0F0F0);
    } else if (isFilled) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  

  IconData iconDatas(int step){
    switch (step) {
      case 0:
        {
          return MdiIcons.batteryOutline;
        } 
      case 1:
        {
          return MdiIcons.battery10;
        }
        break;

      case 2:
        {
          return MdiIcons.battery20;
        }
        break;

      case 3:
        {
          return MdiIcons.battery30;
        }
        break;

      case 4:
        {
          return MdiIcons.battery40;
        }
        break;

      case 5:
        {
          return MdiIcons.battery50;
        }
        break;
      case 6:
        {
          return MdiIcons.battery60;
        }
        break;

      case 7:
        {
          return MdiIcons.battery70;
        }
        break;
      case 8:
        {
          return MdiIcons.battery80;
        }
        break;

      case 9:
        {
          return MdiIcons.battery90;
        }
        break;

      case 10:
        {
          return MdiIcons.battery;
        }
        break;
      default:
        {
          return MdiIcons.battery;
        }

    }      
      
  }
}
