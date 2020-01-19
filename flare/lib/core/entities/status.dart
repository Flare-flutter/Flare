import 'package:flutter/material.dart';

class Status {
  String _printVal = "No Status";
  Color _printColor = Colors.grey;

  Status();

  String getStatus() {
    return _printVal;
  }

  Text getStatusUI() {
    return new Text(_printVal, style: TextStyle(color: _printColor, fontSize: 50, fontWeight: FontWeight.bold));
  }
}

class IdleStatus extends Status {
  @override
  Color _printColor = Colors.grey;

  @override
  String _printVal = "Idle";
}

class AllGoodStatus extends Status {
  @override
  Color _printColor = Colors.green[500];

  @override
  String _printVal = "On Ride";
}

class EmergencyStatus extends Status {
  @override
  Color _printColor = Colors.red[500];

  @override
  String _printVal = "Emergency";
}
