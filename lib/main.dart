import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RelayControlScreen(),
    );
  }
}

class RelayControlScreen extends StatefulWidget {
  @override
  _RelayControlScreenState createState() => _RelayControlScreenState();
}

class _RelayControlScreenState extends State<RelayControlScreen> {
  bool relay1State = false;
  bool relay2State = false;
  bool relay3State = false;
  bool relay4State = false;

  void _updateRelayState(int relayNumber, bool newState) {
    setState(() {
      // Update the UI
      switch (relayNumber) {
        case 1:
          relay1State = newState;
          break;
        case 2:
          relay2State = newState;
          break;
        case 3:
          relay3State = newState;
          break;
        case 4:
          relay4State = newState;
          break;
      }
    });

    // Send the state to Firebase
    final String firebaseUrl =
        'https://home-automation-2-3d21d-default-rtdb.firebaseio.com/relays.json'; // Replace with your Firebase Realtime Database URL
    http.put(Uri.parse(firebaseUrl),
        body:
            '{"relay1": $relay1State, "relay2": $relay2State, "relay3": $relay3State, "relay4": $relay4State}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relay Control')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text('Relay 1'),
              value: relay1State,
              onChanged: (newValue) => _updateRelayState(1, newValue),
            ),
            SwitchListTile(
              title: Text('Relay 2'),
              value: relay2State,
              onChanged: (newValue) => _updateRelayState(2, newValue),
            ),
            SwitchListTile(
              title: Text('Relay 3'),
              value: relay3State,
              onChanged: (newValue) => _updateRelayState(3, newValue),
            ),
            SwitchListTile(
              title: Text('Relay 4'),
              value: relay4State,
              onChanged: (newValue) => _updateRelayState(4, newValue),
            ),
          ],
        ),
      ),
    );
  }
}
