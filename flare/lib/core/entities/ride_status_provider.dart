import 'package:flare/core/entities/status.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sensors/sensors.dart';
import 'package:geolocator/geolocator.dart';

class RideStatusProvider {
  BehaviorSubject<LatLng> currentLocation = BehaviorSubject<LatLng>();
  BehaviorSubject<Status> currentStatus = BehaviorSubject<Status>();
  BehaviorSubject<AccelerometerEvent> accelerometerStream = BehaviorSubject<AccelerometerEvent>();

  static final RideStatusProvider _singleton = RideStatusProvider._internal();

  factory RideStatusProvider() {
    return _singleton;
  }

  RideStatusProvider._internal() {
    accelerometerEvents.forEach((event) => accelerometerStream.add(event));

    currentLocation.addStream(getLatLng());
    currentStatus.add(new IdleStatus());
  }

  void printProvider() async {
    if (accelerometerStream.hasValue) {
      AccelerometerEvent ae = await accelerometerStream.first;
      print("Accel: " + ae.x.toString() + " " + ae.y.toString());
    }
    if (currentLocation.hasValue) {
      LatLng ll = await currentLocation.first;
      print("ll: " + ll.toString());
    }

    if (currentStatus.hasValue) {
      Status s = await currentStatus.first;
      print("status: " + s.getStatus());
    }
  }
}

Stream<LatLng> getLatLng() async* {
  //currentTime.difference(start).inSeconds
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng currentLatLng = new LatLng(position.latitude, position.longitude);
    print(currentLatLng);
    yield currentLatLng;
  }
}
