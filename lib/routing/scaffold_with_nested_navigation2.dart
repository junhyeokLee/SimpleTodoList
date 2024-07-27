import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation2 extends StatelessWidget {
  const ScaffoldWithNestedNavigation2({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithNavigationBar2(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

class ScaffoldWithNavigationBar2 extends StatelessWidget {
  const ScaffoldWithNavigationBar2({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(80.0)), // 상단 모서리 둥글게
        child: CustomBottomNavigationBar2(
          currentIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar2 extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  CustomBottomNavigationBar2({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Add the custom indicator
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width / 2) * (currentIndex / 2),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 4,
              color: Colors.white,
            ),
          ),
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onDestinationSelected,
            backgroundColor: Colors.transparent, // Transparent background
            selectedItemColor: Colors.white, // Hide default indicator
            unselectedItemColor: Colors.grey,
            selectedIconTheme: const IconThemeData(size: 32),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note_outlined),
                label: 'Todo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_calendar_outlined),
                label: 'Calendar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}