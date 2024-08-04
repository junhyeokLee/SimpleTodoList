// home.dart
import 'package:backdrop/backdrop.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_todo_list/utils/assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';
import '../../../providers/export_providers.dart';
import '../../../utils/unique_keys.dart';
import '../../widgets/app_title_with_transition.dart';
import '../../widgets/todo_item.dart';
import '../../widgets/toolbar.dart';
import 'back_layer_page.dart';


class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    AnimationController mainTitleAnimController = useAnimationController(duration: kThemeAnimationDuration, initialValue: 1);
    AnimationController appbarTitleAnimController = useAnimationController(duration: kThemeAnimationDuration, initialValue: 0);

    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = ref.watch(isDarkProvider).getTheme();

    ScrollController scrollController = useScrollController();

    // 초기 로딩을 useEffect로 대체
    useEffect(() {
      Future(() {
        ref.read(todoListProvider.notifier).loadData();
        updateScrollVisibility(ref, true); // 스크롤 시 가시성 업데이트
      });
      return;
    }, []); // 빈 배열을 두 번째 인자로 전달하여 처음 한 번만 실행되도록 함

    useEffect(() {
      void scrollListener() {
        final scrollPosition = scrollController.hasClients ? scrollController.offset : 0.0;
        if (scrollPosition > 200) {
          updateScrollVisibility(ref, true); // 스크롤 시 가시성 업데이트
        } else {
          updateScrollVisibility(ref, false); // 스크롤이 맨 위일 때 가시성 업데이트
        }
      }
      scrollController.addListener(scrollListener);
      Future(() => scrollListener());
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController,todos.data.length]);


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).colorScheme.primary,
        backLayerBackgroundColor: Theme.of(context).colorScheme.primary,
        headerHeight: 0,
        frontLayerBorderRadius: BorderRadius.circular(0),
        stickyFrontLayer: true,
        frontLayerScrim: isDark ? Colors.black54 : Colors.white60,
        backLayerScrim: isDark ? Colors.white54 : Colors.black54,
        appBar: BackdropAppBar(
          leading: Padding(padding: const EdgeInsets.symmetric(horizontal: 0.0)),
          title: const Text('메모'),
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
        frontLayer: ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          children: [
            const SizedBox(
              height: 16,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: Text(
            //     '${ref.watch(uncompletedTodoCount).toString()} of ${ref.watch(totalTodoCount).toString()} items left',
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context).textTheme.bodyMedium,
            //   ),
            // ),
            ToolBar(filter: ref.watch(todoFilterType.state)),
            if (todos.data.isEmpty) ...[
              const SizedBox(
                height: 120,
              ),
              Center( // Center widget 추가
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Assets.note2,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Nothing to do !\n Try to add a new one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Container(
              // height: MediaQuery.of(context).size.height,
              // decoration: BoxDecoration(
              //   color: AppColors.noteColor2,
              //   borderRadius: BorderRadius.vertical(top: Radius.circular(60), bottom: Radius.circular(radius)), // 상단 모서리 둥글게 처리
              // ),
              child: ReorderableListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  header: null,
                  shrinkWrap: true,
                  itemCount: todos.data.length,
                  itemBuilder: (context, i) {
                    return Container(
                      key: ValueKey(todos.data[i].id),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Dismissible(
                        key: ValueKey(todos.data[i].id),
                        onDismissed: (_) {
                          ref.read(todoListProvider.notifier)
                              .remove(todos.data[i]);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text("Task Deleted!"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                        },
                        child: ProviderScope(
                          overrides: [
                            if (ref.watch(totalTodoCount) != 0)
                              currentTodo.overrideWithValue(todos.data[i])
                          ],
                          child: SizedBox(
                              child: Container(
                                  color: Colors.white,
                                  child: const TodoItem())),
                        ),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) => ref
                      .read(todoListProvider.notifier)
                      .reorder(oldIndex, newIndex)),
            ),
          ],
        ),
      ),
    );
  }
}