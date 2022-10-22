import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcc_flutter_boilerplate/core/routes/app_route_name.dart';
import 'package:tcc_flutter_boilerplate/modules/auth/login/login_view.dart';
import 'package:tcc_flutter_boilerplate/modules/home/home_view.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    var screen = const Text('Some Text');
    switch (settings.name) {
      case AppRouteName.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              const MyHomePage(title: 'TCC Flutter Boilerplate'),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, animation, __, child) {
            // slide in transition,
            // from bottom (y = 1) to center (y = 0) screen
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
        ;

      case AppRouteName.login:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const Login(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, animation, __, child) {
            // slide in transition,
            // from bottom (y = 1) to center (y = 0) screen
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRouteName.forgotPassword:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const Login(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, animation, __, child) {
            // slide in transition,
            // from bottom (y = 1) to center (y = 0) screen
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRouteName.register:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const Login(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (_, animation, __, child) {
            // slide in transition,
            // from bottom (y = 1) to center (y = 0) screen
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
    }

    return _errorRoute();
  }

  static _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error - 404'),
          ),
          body: const Center(child: Text('Error Not Found - 404')),
        );
      },
    );
  }
}
