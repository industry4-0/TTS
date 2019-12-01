import 'package:flutter/material.dart';
import 'package:TTS_Device_Manager/features/preset/preset.dart';

class PresetListItem extends StatefulWidget {

  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final Preset preset;

  const PresetListItem({
    Key key,
    this.preset,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);
  @override


  PresetListItemState createState() => PresetListItemState();


}



class PresetListItemState extends State<PresetListItem> {
  Color color;
  Color defaultColor;
  bool isSelected;
  @override
  void initState() {
    super.initState();
    isSelected = false;
    defaultColor = color;
  }

 

  @override
  Widget build(BuildContext context) {
    return Container(
        //color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Card(
                      color: widget.isSelected ? Colors.lightBlueAccent : defaultColor,
                      //key: key,
                      child: ListTile(
                        title: Text(widget.preset.title),
                        subtitle: Text(
                            'Quantity: ${widget.preset.quantity}  | Bottles: ${widget.preset.bottles}  |  Filling Time: ${widget.preset.fillingTime} sec',
                            //style: const TextStyle(fontSize: 15.0),
                            ),
                        isThreeLine: true,
                         onTap: widget.onSelect,
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

}


