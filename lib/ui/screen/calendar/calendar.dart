// home.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/todo_scroll_visibility_provider.dart';

class Calendar extends HookConsumerWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext contex, WidgetRef ref) {

    // useEffect(() {
    //   void scrollListener() {
    //       updateScrollVisibility(ref, false); // 스크롤 시 가시성 업데이트
    //   }
    //   Future(() => scrollListener());
    //   return () => updateScrollVisibility(ref,false);
    // }, []);

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final bool isDark = ref.watch(isDarkProvider).getTheme();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Calendar'),
          ),
          body: const Center(
            child: Text('Calendar Page'),
          ),
        );
      },
    );
  }
}
