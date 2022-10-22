import 'package:flutter/material.dart';

class AppBottomBars extends StatefulWidget {
  final void Function(int)? onSelectItem;
  final int selectedIndex;
  final List<NavigationDestination> destinations;

  const AppBottomBars(
      {super.key,
      this.onSelectItem,
      required this.selectedIndex,
      required this.destinations});

  @override
  State<AppBottomBars> createState() => _AppBottomBarsState();
}

class _AppBottomBarsState extends State<AppBottomBars> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      animationDuration: const Duration(milliseconds: 400),
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
        widget.onSelectItem!(index);
      },
      destinations: widget.destinations,
    );
  }
}
