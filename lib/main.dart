import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_flutter_boilerplate/core/routes/app_route.dart';
import 'package:tcc_flutter_boilerplate/core/services/api_service.dart';
import 'package:tcc_flutter_boilerplate/core/settings/theme_provider.dart';
import 'package:tcc_flutter_boilerplate/modules/splash/splash_screen.dart';

void main() {
  ApiService.configure(Flavor.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int screenIndex = 0;
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    await themeChangeProvider.getThemeData();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, _, __) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: _.darkTheme ? ThemeMode.dark : ThemeMode.light,
            theme: _.themeData,
            home: const Splash(),
            onGenerateRoute: AppRoute.generate,
          );
        },
      ),
    );
  }
}
