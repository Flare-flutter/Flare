import 'package:flare/features/authentication/domain/repositories/authenticationService.dart';
import 'package:flare/features/status_detail/presentation/status_detail_page.dart';
import 'package:flutter/material.dart';
// import 'package:flare/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sensors/sensors.dart';
import 'package:flare/theme.dart';

class InfoPanel extends StatefulWidget {
  InfoPanel({Key key, this.auth, this.userId, this.logoutCallback}) : super(key: key);

  final AuthService auth;
  final VoidCallback logoutCallback;
  final String userId;
  BehaviorSubject<DateTime> time_stream;
  BehaviorSubject<String> status_stream;

  @override
  State<StatefulWidget> createState() => new _InfoPanel();
}

class TimeWidget extends StatelessWidget {
  final time_stream;
  const TimeWidget({Key key, this.time_stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: time_stream,
        builder: (context, AsyncSnapshot<DateTime> snapshot) {
          // print("getting time " + snapshot.data.toIso8601String());
          print("getting status " + snapshot.data.toIso8601String());
          DateTime currentTime = snapshot.data;
          if (snapshot.hasData) {
            return Container(
                alignment: Alignment.center,
                child: Column(children: <Widget>[
                  Text("Time", style: TextSmall()),
                  Text(
                    currentTime.minute.toString() + ":" + (currentTime.second.toInt()).toString(),
                    style: TextLarge(),
                  )
                ]));
          } else if (snapshot.hasError) {
            print("Error in time widget");
            return Text("Error");
          } else {
            return Text("--");
          }
        });
  }
}

class StatusWidget extends StatelessWidget {
  final status_stream;
  const StatusWidget({Key key, this.status_stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: status_stream,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            // print("getting status " + snapshot.data);
            return Container(
                alignment: Alignment.center,
                child: Column(children: <Widget>[Text("Status", style: TextSmall()), Text(snapshot.data, style: TextLarge())]));
          } else if (snapshot.hasError) {
            print("Error in STATUS widget");
            return Text("Error");
          } else {
            return Text("");
          }
        });
  }
}

class _InfoPanel extends State<InfoPanel> {
  //List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    super.widget.time_stream = BehaviorSubject();

    super.widget.time_stream.addStream(getTime());
    super.widget.status_stream = BehaviorSubject();

    super.widget.status_stream.addStream(accelerometerEvents.map((AccelerometerEvent ae) => ae.x.toStringAsPrecision(1)));
    // super.widget.time_stream.listen((onData) => print("getting time " + onData));
  }

  Stream<DateTime> getTime() async* {
    //currentTime.difference(start).inSeconds
    while (true) {
      DateTime currentTime = DateTime.now();
      await Future.delayed(Duration(seconds: 1));
      yield currentTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: getBGColor(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: TimeWidget(time_stream: widget.time_stream)),
            Expanded(flex: 4, child: StatusWidget(status_stream: widget.status_stream)),
          ],
        ));
  }
}
