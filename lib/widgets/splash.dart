import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  bool loadding = true;

  void navigationPage() async {
    final SharedPreferences prefs = await _prefs;
    bool logado = prefs.getBool("logado");

    if (logado == null) {
      Navigator.pushNamed(context, '/login');
      return;
    }

    !logado
        ? Navigator.pushNamed(context, '/login')
        : Navigator.pushNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "images/bg.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            // color: kTextColor,
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Container(
                    child: Image.asset(
                  "images/logo_splash.png",
                  width: 255,
                  height: 125,
                )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                // Container(
                //     child: Image.asset(
                //   power_by_dry,
                //   width: 255,
                //   height: MediaQuery.of(context).size.height * 0.1,
                // )),
              ],
            ),
          ),
        ));
  }
}
