import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(ReactionTimerApp());
}

class ReactionTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reaction Timer',
      home: ReactionTimerPage(),
    );
  }
}

class ReactionTimerPage extends StatefulWidget {
  @override
  _ReactionTimerPageState createState() => _ReactionTimerPageState();
}

class _ReactionTimerPageState extends State<ReactionTimerPage> {
  String _message = "Press Start to Begin";
  Color _backgroundColor = Colors.blue;
  bool _canClick = false;
  Timer? _timer;
  DateTime? _startTime;
  int _reactionTime = 0;

  void _startTimer() {
    setState(() {
      _message = "Wait for it...";
      _backgroundColor = Colors.blue;
      _canClick = false;
      _reactionTime = 0;
    });

    
    final int delay = Random().nextInt(3000) + 2000;
  
    _timer = Timer(Duration(milliseconds: delay), () {
      setState(() {
        _message = "Click Now!";
        _backgroundColor = Colors.green;
        _canClick = true;
        _startTime = DateTime.now();
      });
     });
  }

  void _handleClick() {
    if (_canClick) {
      setState(() {
        _reactionTime = DateTime.now().difference(_startTime!).inMilliseconds;
        _message = "Your reaction time: $_reactionTime ms";
        _backgroundColor = Colors.blue;
        _canClick = false;
      });
    } else if (_timer?.isActive ?? false) {
      _timer?.cancel();
      setState(() {
        _message = "Too Soon! Try Again.";
        _backgroundColor = Colors.red; 
        _canClick = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, 
        onTap: _handleClick, 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _startTimer,
                child: Text("Start"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
              if (_reactionTime > 0) ...[
                SizedBox(height: 20),
                Text(
                  "Reaction Time: $_reactionTime ms",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
