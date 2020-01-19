import 'package:flare/features/authentication/domain/repositories/authenticationService.dart';
import 'package:flare/features/user_search/presentation/widgets/user_search.dart';
import 'package:flutter/material.dart';
// import 'package:flare/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sensors/sensors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final AuthService auth;
  final VoidCallback logoutCallback;
  final String userId;
  BehaviorSubject<AccelerometerEvent> _accelerometerStream;
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class SensorUI extends StatelessWidget {
  final accelStream;
  SensorUI({Key key, this.accelStream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: accelStream,
        builder: (context, AsyncSnapshot<AccelerometerEvent> snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Text("X: " + snapshot.data.x.toString()),
                  Text("Y: " + snapshot.data.y.toString()),
                  Text("Z: " + snapshot.data.z.toString()),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print(
                "Error in weather_panel.dart -> weatherLabel, stream has error");
            return Text("Error");
          } else {
            return Text("--");
          }
        });
  }
}

class _HomePageState extends State<HomePage> {
  //List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    super.widget._accelerometerStream = BehaviorSubject();

    super
        .widget
        ._accelerometerStream
        .addStream(accelerometerEvents.map((AccelerometerEvent ae) => ae));
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flare'),
        actions: <Widget>[UserSearchButton()],
      ),
      body: SensorUI(accelStream: widget._accelerometerStream),
    );
  }
}
