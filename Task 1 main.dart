import 'package:flutter/material.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerHome(),
    );
  }
}

class TimerHome extends StatefulWidget {
  @override
  _TimerHomeState createState() => _TimerHomeState();
}

class _TimerHomeState extends State<TimerHome> {
  int _timeLeft = 10;
  bool _isRunning = false;

  void _startTimer() async {
    setState(() {
      _isRunning = true;
    });
    for (int i = _timeLeft; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _timeLeft = i;
        });
      }
    }
    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer App'),
      centerTitle: true,
      backgroundColor: Colors.green[200],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Left: $_timeLeft seconds',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRunning ? null : _startTimer,
              child: Text('Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
