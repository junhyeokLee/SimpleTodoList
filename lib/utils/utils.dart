// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../data/todo/list_of_todo_model.dart';
import '../data/todo/todo_model.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

// ListOfTodoModel로부터 kEvents를 생성하는 함수
Map<DateTime, List<Event>> generateEvents(ListOfTodoModel listOfTodoModel) {
  final Map<DateTime, List<Event>> events = {};

  for (final todo in listOfTodoModel.data) {
    if (!events.containsKey(todo.date)) {
      events[todo.date] = [];
    }
    events[todo.date]!.add(Event(todo.description));
  }
  return events;
}
// 실제 데이터를 사용하는 예제
void initializeEvents(List<TodoModel> todos) {
  final listOfTodoModel = listOfTodoModelFromTodos(todos);
  final kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(generateEvents(listOfTodoModel));
  // 이제 kEvents를 사용하거나, 원하는 곳에 전달
  print(kEvents); // 예제: 콘솔에 출력
}

// 날짜 범위를 반환하는 유틸 함수
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
