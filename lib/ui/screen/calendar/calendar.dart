// home.dart
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/theme_provider.dart';
import '../home/back_layer_page.dart';
import 'calendar_todo_list.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool isDark = ref.watch(isDarkProvider).getTheme();

    return BackdropScaffold(
      frontLayerBackgroundColor: Theme.of(context).colorScheme.primary,
      backLayerBackgroundColor: Theme.of(context).colorScheme.primary,
      headerHeight: 0,
      frontLayerBorderRadius: BorderRadius.circular(0),
      stickyFrontLayer: true,
      frontLayerScrim: isDark ? Colors.black54 : Colors.white60,
      backLayerScrim: isDark ? Colors.white54 : Colors.black54,
      appBar: BackdropAppBar(
        leading: Padding(padding: const EdgeInsets.symmetric(horizontal: 0.0)),
        title: const Text('캘린더'),
        actions: [
          BackdropToggleButton(
            color: isDark ? Colors.white : Colors.black,
            icon: AnimatedIcons.close_menu,
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      backLayer: const BackLayerPage(),
      frontLayer: CalendarTodoList(),
    );
  }
}
