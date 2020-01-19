import 'dart:async';

import 'package:flare/features/status_detail/presentation/info_panel_widget.dart';
import 'package:flare/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StatusDetailPage extends StatefulWidget {
  @override
  _StatusDetailPage createState() => _StatusDetailPage();
}

class _StatusDetailPage extends State<StatusDetailPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    print("map created");
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('<fiends name>'),
        backgroundColor: getBGColor(),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 6,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            compassEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
        Expanded(flex: 2, child: InfoPanel()),
      ]),
    );
  }
}
