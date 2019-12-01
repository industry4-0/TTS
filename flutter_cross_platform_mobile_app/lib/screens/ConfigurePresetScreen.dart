import 'package:TTS_Device_Manager/DB.dart';
import 'package:TTS_Device_Manager/UtilityConstants.dart';
import 'package:TTS_Device_Manager/features/preset/preset.dart';
import 'package:flutter/material.dart';

class ConfigurePresetScreen extends StatefulWidget {
  final Preset preset;
  final int presetIndex;
  // In the constructor, require a Preset.
  ConfigurePresetScreen({Key key, @required this.preset, @required this.presetIndex}) : super(key: key);

  @override
  _ConfigurePresetScreenState createState() => _ConfigurePresetScreenState();
}

class _ConfigurePresetScreenState extends State<ConfigurePresetScreen> {
  final  _titleController = TextEditingController();
  final TextEditingController _bottlesController = new TextEditingController();
  final TextEditingController _fillingTimeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final labelStyle = TextStyle(fontSize: 20);
  int dropdownValue;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _titleController.dispose();
    _bottlesController.dispose();
    _fillingTimeController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _titleController.text = widget.preset.title.toString();
    dropdownValue = widget.preset.quantity;
    _bottlesController.text = widget.preset.bottles.toString();
    _fillingTimeController.text = widget.preset.fillingTime.toString();
  }
  
  //double _sliderValue = 0.0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${_titleController.text}'),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(10, 50, 0, 0),
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 108, 0),
                    child: Text(
                      "Title: ",
                      style: labelStyle,
                    ),
                  ),
                  Expanded(child: TextFormField(controller: _titleController,)),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 111, 0),)
                  
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Text(
                      "Filling Quantity: ",
                      style: labelStyle,
                    ),
                  ),
                  DropdownButton<int>(
                    value: dropdownValue,

                    elevation: 16,
                    //style: TextStyle(color: Colors.deepPurple),
                    // underline: Container(
                    //   height: 2,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    onChanged: (int newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: UtilityConstants.FILLING_QUANTIY
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 108, 0),
                    child: Text(
                      "Bottles: ",
                      style: labelStyle,
                    ),
                  ),
                  Expanded(child: TextFormField(controller: _bottlesController,)),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 110, 0),)
                  //TextFormField(controller: _bottlesController),
                  //   Slider(
                  //   activeColor: Colors.indigoAccent,
                  //   min: 0.0,
                  //   max: 142.0,
                  //   onChanged: (newRating) {
                  //     setState(() => _sliderValue = double.parse(newRating.toStringAsFixed(2)));
                  //   },
                  //   value: _sliderValue,
                  // ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 67, 0),
                    child: Text(
                      "Filling Time: ",
                      style: labelStyle,
                    ),
                  ),
                  Expanded(child: TextFormField(controller: _fillingTimeController,)),
                  Padding(padding: const EdgeInsets.fromLTRB(0, 0, 109, 0),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(138, 20, 0, 0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      _onLoading();
                      // If the form is valid, display a Snackbar.
                      
                    }
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  
  String updatingText = 'Updating preset...';
  void _onLoading() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return MyDialog();
    },
  );
  new Future.delayed(new Duration(seconds: 3), () {
    DB.presets[widget.presetIndex].title = _titleController.text;
    DB.presets[widget.presetIndex].quantity = dropdownValue;
    DB.presets[widget.presetIndex].bottles = int.parse(_bottlesController.text);
    DB.presets[widget.presetIndex].fillingTime = double.parse(_fillingTimeController.text);
    //setState(() => updatingText = "Updated");
    new Future.delayed(new Duration(seconds: 1), () {
    
    Navigator.pop(context);
    });
    Navigator.pop(context);
  });
  
}
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String _text = "Updating Preset";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(children: <Widget>[
        new CircularProgressIndicator(),
        Text(' $_text')
      ],),
      
    );
  }
}