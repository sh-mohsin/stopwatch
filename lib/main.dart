import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light, // Set initial theme to light
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Define dark theme
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatefulWidget {
  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  int _seconds = 0;
  bool _isRunning = false;
  bool _isDarkMode = false; // Track dark mode status

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int secs = seconds % 60;

    String hoursStr = (hours < 10) ? '0$hours' : '$hours';
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr = (secs < 10) ? '0$secs' : '$secs';

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _formatTime(_seconds);

    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
        actions: [
          // Switch button to toggle dark mode
          Switch(activeColor: Colors.grey,
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: _isDarkMode ? Colors.grey[900] : Colors.grey[200], // Change background based on dark mode
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$formattedTime',
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: _isDarkMode ? Colors.white : Colors.black), // Adjust text color based on dark mode
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDarkMode ? Colors.white54 : Colors.blue,
                      foregroundColor: _isDarkMode ? Colors.white : Colors.white,// Adjust button color based on dark mode
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: _isRunning ? Text('Pause') : Text('Start'),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: _resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDarkMode ? Colors.redAccent : Colors.red,
                      foregroundColor: _isDarkMode ? Colors.white : Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
