import 'package:animations/animations.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/providers/export_providers.dart';
import 'package:simple_todo_list/ui/screen/add_todo.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';
import '../providers/bottom_nav_providers.dart';
import '../providers/todo_calendar_provider.dart';
import '../providers/todo_scroll_visibility_provider.dart';
import '../utils/assets.dart'; // Import the provider

class ScaffoldWithNestedNavigation extends HookConsumerWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index, WidgetRef ref) {
    ref.read(currentIndexProvider.notifier).state = index;
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(todoScrollVisibilityProvider);
    final bool isDark = ref.watch(isDarkProvider).getTheme();

    final currentPath = GoRouterState
        .of(context)
        .uri
        .toString();
    final isFabVisible = currentPath == '/home' || currentPath == '/calendar';

    return ScaffoldWithNavigationBar(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => _goBranch(index, ref),
      isVisible: isVisible,
      isDark: isDark,
      isFabVisible: isFabVisible,
    );
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.isVisible,
    required this.isDark,
    required this.isFabVisible,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isVisible;
  final bool isDark;
  final bool isFabVisible;

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    const double _fabDimension = 56.0;

    return Scaffold(
      backgroundColor: !isDark ? Colors.white : Colors.grey[900],
      floatingActionButton: isFabVisible ? AnimatedSlide(
        offset: (!isVisible) ? Offset(0, 0) : Offset(0, 2),
        duration: Duration(milliseconds: 300),
        child: AnimatedOpacity(
          opacity: (!isVisible) ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddTodo();
                  }
                );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ) : null,
      body: body,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: ClipRRect(
          // borderRadius: const BorderRadius.vertical(top: Radius.circular(80.0)),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(0.0), bottom: Radius.circular(40.0)),
          // 상단 모서리 둥글게
          child: NavigationBar(
            selectedIndex: currentIndex,
            destinations: [
              NavigationDestination(
                // icon: const Icon(Icons.edit_note_outlined),
                // selectedIcon: const Icon(Icons.edit_note),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey, // 비선택 상태 색상
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(Assets.writing, width: 24, height: 24),
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    !isDark ? Colors.black : Colors.white, // 선택 상태 색상
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(Assets.writing, width: 26, height: 26),
                ),
                label: '메모',
              ),
              NavigationDestination(
                // icon: const Icon(Icons.edit_calendar_outlined),
                // selectedIcon: const Icon(Icons.edit_calendar),
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey, // 비선택 상태 색상
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(Assets.calendar, width: 24, height: 24),
                ),
                selectedIcon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    !isDark ? Colors.black : Colors.white, // 선택 상태 색상
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(Assets.calendar, width: 26, height: 26),
                ),
                label: '캘린더',
              ),
            ],
            onDestinationSelected: onDestinationSelected,
          ),
        ),
      ),
    );
  }
}


