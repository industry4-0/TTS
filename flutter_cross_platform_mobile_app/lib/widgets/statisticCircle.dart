import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class StatisticCircle extends StatefulWidget {

final int counter;

const StatisticCircle(
      {Key key,
      @required this.counter,
      });

@override
  _StatisticCircleState createState() => _StatisticCircleState();
}

class _StatisticCircleState extends State<StatisticCircle>{
  int counter;
  @override
  Widget build(BuildContext context) {
    return Icon(circleProgressIcon(widget.counter));
  }


  circleProgressIcon(int counter){
    switch (counter) {
      case 0 :
      {
        return MdiIcons.circleOutline;
      }
      break;
      
      case 1:
      {
        return MdiIcons.circleSlice1;
      }
      break;
      case 2 :
      {
        return MdiIcons.circleSlice2;
      }
      break;

      case 3:
      {
        return MdiIcons.circleSlice3;
      }
      break;
      case 4 :
      {
        return MdiIcons.circleSlice4;
      }
      break;

      case 5:
      {
        return MdiIcons.circleSlice5;
      }
      break;
      case 6 :
      {
        return MdiIcons.circleSlice6;
      }
      break;

      case 7:
      {
        return MdiIcons.circleSlice7;
      }
      break;
      case 8 :
      {
        return MdiIcons.circleSlice8;
      }
      break;
        
        
      default: return MdiIcons.circleOutline;
    }
  }

}