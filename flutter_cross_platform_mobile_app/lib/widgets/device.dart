import 'package:TTS_Device_Manager/screens/PresetsScreen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Device extends StatefulWidget {
  final String fullName;
  final String subTitle;
  final String state;

  const Device(
      {Key key,
      @required this.fullName,
      @required this.subTitle,
      @required this.state,})
      : assert(fullName != null),
        assert(subTitle != null),
        assert(state != null);

  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device>{
  String fullName;
  String subTitle;
  String state;

  @override
  void initState() {
    super.initState();
    //isConnected = false;
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
                stateIcon(widget.state),
                color: widget.state == "Connected" ? Colors.green : Colors.grey,
                size: 50,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
        title: Text(
          widget.fullName,
          style: _biggerFont,
        ),
        subtitle: Text(widget.subTitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PresetsScreen(deviceName: "- ${widget.fullName}",),
            ),
          );
        });
  }

  IconData stateIcon(String state){
    switch (state) {
      case "Loading":
      {
          return MdiIcons.wifiStrengthOutline;
      } 
      case "Connected":
      {
          return MdiIcons.wifi;
      } 
      case "Disconnected":
      {
          return MdiIcons.wifiOff;
      } 
        break;
      default:
          return MdiIcons.wifiOff;
    }
  }
}
