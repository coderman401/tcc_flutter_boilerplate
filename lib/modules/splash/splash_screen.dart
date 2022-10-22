import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcc_flutter_boilerplate/core/routes/app_route_name.dart';
import 'package:tcc_flutter_boilerplate/core/services/shared_preferences_service.dart';

class Splash extends StatefulWidget {
  const Splash({key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  bool _isVisible = false;
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService();
  late String token;

  @override
  void initState() {
    super.initState();
    // * NOTE: Get the token from the shared preferences...
    _preferencesService.getData('_token').then((value) => {
          setState(() {
            token = value;
          })
        });
  }

  SplashState() {
    Timer(const Duration(milliseconds: 1600), () {
      setState(() {
        //* NOTE : check for the token and redirect to the path based on the token
        String path = AppRouteName.home;
        Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true; // Now it is showing fade effect
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.16),
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0,
          duration: const Duration(milliseconds: 800),
          child: Center(
            child: Container(
              height: 180.0,
              width: 180.0,
              padding: const EdgeInsets.all(16.0),
              child: const Center(
                child: FlutterLogo(
                  duration: Duration(milliseconds: 0),
                  size: 80,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
