import 'package:flare/pages/login_page.dart';
import 'package:flare/pages/root_page.dart';
import 'package:flare/services/auth.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'features/authentication/data/repositories/authenticationServiceImpl.dart';
import 'features/authentication/domain/repositories/authenticationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService auth = AuthServiceImpl();
  await di.init();

  runApp(new MyApp(auth));
}

class MyApp extends StatelessWidget {
  final _auth;
  MyApp(this._auth);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(auth: _auth));
  }
}
