import 'package:flare/pages/login_page.dart';
import 'package:flare/pages/root_page.dart';
import 'package:flare/services/auth.dart';
import 'package:flutter/material.dart';

import 'features/authentication/data/repositories/authenticationServiceImpl.dart';
import 'features/authentication/domain/repositories/authenticationService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService auth = AuthServiceImpl();

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
