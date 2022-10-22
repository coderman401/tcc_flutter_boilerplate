import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcc_flutter_boilerplate/core/components/app_bottom_bar.dart';
import 'package:tcc_flutter_boilerplate/core/settings/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _colorSelected = 0;
  int screenIndex = 0;
  late DarkThemeProvider themeProvider;

  List<NavigationDestination> bottomBarList = [
    const NavigationDestination(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
      tooltip: '',
      selectedIcon: Icon(Icons.home),
    ),
    const NavigationDestination(icon: Icon(Icons.menu_outlined), label: 'Menu'),
    const NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      label: 'Settings',
      selectedIcon: Icon(Icons.settings),
    ),
  ];

  void handleColorSelect(int value) {
    setState(() {
      _colorSelected = value;
      themeProvider.colorSelected = value;
    });
  }

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  Widget createScreenFor(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return const FirstScreen();
      case 1:
        return const SecondScreen();
      case 2:
        return const ThirdScreen();
      default:
        return const FirstScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        primary: true,
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.darkTheme = !themeProvider.darkTheme;
            },
            icon: Icon(themeProvider.darkTheme
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) {
              return List.generate(colorOptions.length, (index) {
                return PopupMenuItem(
                    value: index,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            index == _colorSelected
                                ? Icons.color_lens
                                : Icons.color_lens_outlined,
                            color: colorOptions[index],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(colorText[index]))
                      ],
                    ));
              });
            },
            onSelected: handleColorSelect,
          ),
        ],
      ),
      body: createScreenFor(screenIndex),
      bottomNavigationBar: AppBottomBars(
        onSelectItem: handleScreenChanged,
        selectedIndex: screenIndex,
        destinations: bottomBarList,
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FlutterLogo(),
          SizedBox(height: 16),
          Text('Second Screen')
        ],
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FlutterLogo(),
          SizedBox(height: 16),
          Text('Third Screen')
        ],
      ),
    );
  }
}
