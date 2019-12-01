import 'package:TTS_Device_Manager/UtilityConstants.dart';
//import 'package:TTS_Device_Manager/features/preset/preset.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert';

import 'package:flutter/material.dart';
class MyGetHttpData extends StatefulWidget {
  @override
  MyGetHttpDataState createState() => MyGetHttpDataState();
}

// Create the state for our stateful widget
class SendPresetData extends State<MyGetHttpData> {
  final String url = UtilityConstants.URI;
  List data;
  //int s = pr.quant
  // Function to get the JSON data
  
  Future<String> getJSONData() async {
    var response = await http.get(

      
        // Encode the url
        Uri.encodeFull(url + '/teeee'),
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    // Logs the response body to the console
    print(response.body);

    // To modify the state of the app, use this method
    // setState(() {
    //   // Get the JSON data
    //   var dataConvertedToJSON = json.decode(response.body);
    //   // Extract the required part and assign it to the global variable named data
    //   data = dataConvertedToJSON['results'];
    // });

    return "Successfull";
  }

   @override
  Widget build(BuildContext context) {
    return Text("test");
  }

}


// Create the state for our stateful widget
class MyGetHttpDataState extends State<MyGetHttpData> {
  final String url = UtilityConstants.URI;
  List data;

  // final String _jsonn = '{' +
  //     '"quantity": 30,' +
  //     '"bottles": 104,' +
  //     '"fillingTime": 1,' +
  //     '"startIndex": 1' +
  //   '}';

  // Function to get the JSON data
  Future<String> getJSONData() async {
    Map<String, String> headersMap = new Map<String, String>();
    headersMap["Content-Type"] = 'application/json';
    //var response = await http.post(url, body: _jsonn, headers: headersMap);
    // var response = await http.get(
    //     // Encode the url
    //     Uri.encodeFull(url + '/$_jsonn'),

    //     // Only accept JSON response
    //     headers: {"Accept": "application/json"});

    // Logs the response body to the console
    // print(response.body);
    // print(_jsonn);

    // To modify the state of the app, use this method
    // setState(() {
    //   // Get the JSON data
    //   var dataConvertedToJSON = json.decode(response.body);
    //   // Extract the required part and assign it to the global variable named data
    //   data = dataConvertedToJSON['results'];
    // });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve JSON Data via HTTP GET"),
      ),
      // Create a Listview and load the data when available
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                  child: Column(
                // Stretch the cards in horizontal axis
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Text(
                        // Read the name field value and set it in the Text widget
                        data[index]['name'],
                        // set some style to text
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.lightBlueAccent),
                      ),
                      // added padding
                      padding: const EdgeInsets.all(15.0),
                    ),
                  )
                ],
              )),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}