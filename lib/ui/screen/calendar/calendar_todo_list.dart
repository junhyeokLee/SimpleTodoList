import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_list/data/todo/todo_model.dart';
import 'package:simple_todo_list/utils/styles/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Intl 패키지 임포트
import '../../../providers/current_todo_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/todo_calendar_provider.dart';
import '../../../providers/todo_count_provider.dart';
import '../../../providers/todo_list_provider.dart';
import '../../../providers/todo_scroll_visibility_provider.dart';
import '../../../utils/assets.dart';
import '../../widgets/todo_item.dart';

// 선택된 날짜를 관리하는 StateProvider
class CalendarTodoList extends HookConsumerWidget {

  final today = DateTime.now();
  final firstDay = DateTime(DateTime.now().day, DateTime.now().month - 3, DateTime.now().day);
  final lastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(isDarkProvider).getTheme();
    final todos = ref.watch(todoListProvider);

    // 선택된 날짜와 포커스된 날짜 상태 관리
    final selectedDate = ref.watch(selectedDateProvider);
    final focusedDate = ref.watch(focusedDateProvider);
    final rangeStartDate = ref.watch(rangeStartProvider);
    final rangeEndDate = ref.watch(rangeEndProvider);
    final calendarFormat = ref.watch(calendarFormatProvider);

    ScrollController scrollController = useScrollController();

    useEffect(() {
      void scrollListener() {
        final scrollPosition =
            scrollController.hasClients ? scrollController.offset : 0.0;
        if (scrollPosition > 200) {
          updateScrollVisibility(ref, true); // 스크롤 시 가시성 업데이트
        } else {
          updateScrollVisibility(ref, false); // 스크롤이 맨 위일 때 가시성 업데이트
        }
      }
      scrollController.addListener(scrollListener);
      Future(() => scrollListener());
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController, todos.data.length]);

    // 필터링된 Todos 가져오기
    final filteredTodos = todos.data.where((todo) {
      if(selectedDate == null) {
        return DateTime.utc(todo.date.year, todo.date.month, todo.date.day)
            .isAtSameMomentAs(DateTime.now());
      } else {
      return DateTime.utc(todo.date.year, todo.date.month, todo.date.day)
              .isAtSameMomentAs(selectedDate);
      }
    }).toList();


    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          TableCalendar<TodoModel>(
            firstDay: firstDay,
            lastDay: lastDay,
            focusedDay: focusedDate ?? today, // 초기 포커스 날짜를 오늘 날짜로 설정
            selectedDayPredicate: (day) => isSameDay(selectedDate, day),
            rangeStartDay: rangeStartDate,
            rangeEndDay: rangeEndDate,
            calendarFormat: calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              ref.read(selectedDateProvider.notifier).state = selectedDay;
              ref.read(focusedDateProvider.notifier).state = focusedDay;
              ref.read(rangeStartProvider.notifier).state = null;
              ref.read(rangeEndProvider.notifier).state = null;
              RangeSelectionMode.toggledOff;
            },
            onRangeSelected: (start, end, focusedDay) {
              // 범위가 선택되면 상태를 업데이트
              ref.read(selectedDateProvider.notifier).state = null;
              ref.read(focusedDateProvider.notifier).state = focusedDay;
              ref.read(rangeStartProvider.notifier).state = start;
              ref.read(rangeEndProvider.notifier).state = end;
              RangeSelectionMode.toggledOn;
            },
            onFormatChanged: (format) {
              if (calendarFormat != format) {
                ref.read(calendarFormatProvider.notifier).state = format;
              }
            },
            onPageChanged: (focusedDay) {
              ref.read(focusedDateProvider.notifier).state = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, day,  _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.noteColor2,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: isDark ? Colors.black : Colors.white),
                  ),
                );
              },
              defaultBuilder: (context, day, _) {
                bool isWeekend = day.weekday == DateTime.saturday ||
                    day.weekday == DateTime.sunday;
                Color textColor;
                if (day.weekday == DateTime.saturday) {
                  textColor = Colors.blue; // 토요일은 파란색
                } else if (isWeekend) {
                  textColor = Colors.red; // 일요일은 빨간색
                } else {
                  textColor = isDark ? Colors.white : Colors.black; // 평일 색상
                }
                return Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                );
              },

              rangeStartBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.noteColor2,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: isDark ? Colors.black : Colors.white),
                  ),
                );
              },
              rangeEndBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.noteColor2,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: isDark ? Colors.black : Colors.white),
                  ),
                );
              },
              withinRangeBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.noteColor2.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: isDark ? Colors.black : Colors.white),
                  ),
                );
              },
              markerBuilder: (context, day, events) {
                final dateTodos = todos.data
                    .where((todo) =>
                    DateTime.utc(todo.date.year, todo.date.month, todo.date.day)
                        .isAtSameMomentAs(day))
                    .toList();

                if (dateTodos.isNotEmpty) {
                  return Container(
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.white : Colors.black, // Dark 모드에 따른 색상 설정
                    ),
                    child: Text(
                      '${dateTodos.length}', // 날짜별 TODO 수 표시
                      style: TextStyle(
                        color: isDark ? Colors.black : Colors.white,
                        fontSize: 11.0,
                      ),
                    ),
                  );
                }
                return null;
              },

              // markerBuilder: (context, day, events) => events.isNotEmpty
              //     ? Container(
              //         width: 16,
              //         height: 16,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: isDark
              //               ? Colors.white
              //               : Colors.black, // isDark에 따른 색상 설정
              //         ),
              //         child: Text(
              //           '${events.length}',
              //           style: TextStyle(
              //             color: isDark ? Colors.black : Colors.white,
              //             // isDark에 따른 텍스트 색상 설정
              //             fontSize: 11.0,
              //           ),
              //         ),
              //       )
              //     : null,
              dowBuilder: (context, day) {
                final englishText = DateFormat.E().format(day);
                String koreanText;
                // 영어 요일을 한글로 변환
                switch (englishText) {
                  case 'Mon':
                    koreanText = '월';
                    break;
                  case 'Tue':
                    koreanText = '화';
                    break;
                  case 'Wed':
                    koreanText = '수';
                    break;
                  case 'Thu':
                    koreanText = '목';
                    break;
                  case 'Fri':
                    koreanText = '금';
                    break;
                  case 'Sat':
                    koreanText = '토';
                    break;
                  case 'Sun':
                    koreanText = '일';
                    break;
                  default:
                    koreanText = '';
                }
                // 주말인 토요일과 일요일은 빨간색으로 표시
                if (day.weekday == DateTime.sunday) {
                  return Center(
                    child: Text(
                      '$koreanText',
                      style: TextStyle(color: Colors.red, height: 1),
                    ),
                  );
                } else if (day.weekday == DateTime.saturday) {
                  return Center(
                    child: Text(
                      '$koreanText',
                      style: TextStyle(color: Colors.blue, height: 1),
                    ),
                  );
                } else {
                  // 평일은 다크 모드 여부에 따라 색상 설정
                  final color = isDark ? Colors.white70 : Colors.black38;
                  return Center(
                    child: Text(
                      '$koreanText',
                      style: TextStyle(color: color, height: 1),
                    ),
                  );
                }
              },
            ),

            daysOfWeekHeight: 32.0,
            availableCalendarFormats: const {
              CalendarFormat.month: '주',
              CalendarFormat.week: '월',
            },
            headerStyle: HeaderStyle(
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat('y년 M월', locale).format(date),
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              formatButtonTextStyle: TextStyle(
                color: isDark ? Colors.black : Colors.white,
              ),
              formatButtonDecoration: BoxDecoration(
                color: isDark ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              defaultTextStyle: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
              todayTextStyle: TextStyle(
                color: isDark ? Colors.black : Colors.white,
              ),
              todayDecoration: BoxDecoration(
                color: isDark ? Colors.white70 : Colors.black38,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              selectedTextStyle: TextStyle(
                color: isDark ? Colors.black : Colors.black,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.noteColor2,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              markersAlignment: Alignment.bottomRight,
              outsideDaysVisible: false,
            ),
            // focusedDay: DateTime.now(),
          ),

          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Material(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              color: isDark ? Colors.white : Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        Text(
                          selectedDate == null
                              ? '날짜를 선택하세요.'
                              : '${DateFormat('y년 M월 d일').format(selectedDate!)}',
                          style: TextStyle(
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // `Expanded`로 `ReorderableListView`가 가능한 공간을 모두 차지하도록 함
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: filteredTodos.isEmpty
                  ? Center(
                      // Center widget 추가
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //     Image.asset(
                          //     Assets.note2,
                          // ),
                          AspectRatio(
                            aspectRatio: 3, // 이미지의 비율을 유지하기 위한 값 (1:1 비율로 설정)
                            child: Image.asset(
                              Assets.note2,
                              fit: BoxFit.contain, // 이미지의 비율을 유지하면서 화면에 맞게 조정
                            ),
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
                    )
                  : ReorderableListView.builder(
                      physics: const BouncingScrollPhysics(), // 스크롤 문제 해결
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, i) {
                        return Container(
                          key: ValueKey(filteredTodos[i].id),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Dismissible(
                            key: ValueKey(filteredTodos[i].id),
                            onDismissed: (_) {
                              ref.read(todoListProvider.notifier).remove(filteredTodos[i]);
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
                                  currentTodo.overrideWithValue(filteredTodos[i])
                              ],
                              child: TodoItem(),
                            ),
                          ),
                        );
                      },
                      onReorder: (oldIndex, newIndex) {
                        ref.read(todoListProvider.notifier).reorder(oldIndex, newIndex);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
