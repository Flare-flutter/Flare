import 'package:flare/core/entities/ride_status_provider.dart';
import 'package:flare/features/authentication/domain/repositories/authenticationService.dart';
import 'package:flare/features/status_detail/presentation/status_detail_page.dart';
import 'package:flutter/material.dart';
// import 'package:flare/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sensors/sensors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback}) : super(key: key);

  final AuthService auth;
  final VoidCallback logoutCallback;
  final String userId;
  // BehaviorSubject<AccelerometerEvent> _accelerometerStream;
  RideStatusProvider rsp;
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class sensorUI extends StatelessWidget {
  final accelStream;
  const sensorUI({Key key, this.accelStream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: accelStream,
        builder: (context, AsyncSnapshot<AccelerometerEvent> snapshot) {
          if (snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text("X: " + snapshot.data.x.toString()),
                  Text("Y: " + snapshot.data.y.toString()),
                  Text("Z: " + snapshot.data.z.toString()),
                  RaisedButton(onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatusDetailPage()),
                    );
                  })
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print("Error in weather_panel.dart -> weatherLabel, stream has error");
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
    // super.widget._accelerometerStream = BehaviorSubject();

    //super.widget._accelerometerStream.addStream(accelerometerEvents.map((AccelerometerEvent ae) => ae));
    super.widget.rsp = RideStatusProvider();
    asyncPring();
  }

  asyncPring() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      super.widget.rsp.printProvider();
    }
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
        actions: <Widget>[new FlatButton(child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white)), onPressed: signOut)],
      ),
      body: Container(color: Colors.red), //sensorUI(accelStream: widget._accelerometerStream),
    );
  }
}
