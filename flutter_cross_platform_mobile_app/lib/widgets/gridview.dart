import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyGridView {
  GestureDetector getStructuredGridCell(
      name, iconName, colorName, BuildContext context) {
    // Wrap the child under GestureDetector to setup a on click action
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed("/${name.replaceAll(' ', '-').toLowerCase()}");
      },
      child: Card(
          color: UtilityConstants.CARD_COLOR,
          elevation: 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Icon(
                _getIconForName(iconName),
                color: colorName,
                size: 100.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Center(
                child: Text(name),
              )
            ],
          )),
    );
  }

  Container build(BuildContext context) {
    return new Container(
      color: UtilityConstants.BACKGROUND_COLOR,
      child: GridView.count(
        primary: true,
        padding: const EdgeInsets.all(1.0),
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          getStructuredGridCell(
              UtilityConstants.DEVICES, "devices", UtilityConstants.ICON_DEVICE_COLOR, context),
          getStructuredGridCell(
              UtilityConstants.INBOX, "email", UtilityConstants.ICON_INBOX_COLOR, context),
          getStructuredGridCell(
              UtilityConstants.PRESETES, "presets", UtilityConstants.ICON_PRESET_COLOR, context),
          getStructuredGridCell(
              "Statistical Information", "statistics", UtilityConstants.ICON_DEVICE_COLOR, context),
          getStructuredGridCell(
              "FAQ", "FAQ", UtilityConstants.ICON_DEVICE_COLOR, context),
          getStructuredGridCell(
              "About", "about", UtilityConstants.ICON_DEVICE_COLOR, context),
        ],
      ),
    );
  }

  IconData _getIconForName(String iconName) {
    switch (iconName) {
      case 'devices':
        {
          return Icons.cast_connected;
        }
        break;

      case 'email':
        {
          return Icons.email;
        }
        break;

      case 'about':
        {
          return MdiIcons.informationVariant;
        }
        break;
      
      case 'presets' :
        {
          return Icons.restore;
        }
      case 'statistics' :
        {
          return MdiIcons.mathIntegralBox;
        }
      case 'FAQ' :
        {
          return MdiIcons.frequentlyAskedQuestions;
        }
      default:
        {
          return Icons.email;
        }
    }
  }
}
 
