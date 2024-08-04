import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final rangeStartProvider = StateProvider<DateTime?>((ref) => null);
final rangeEndProvider = StateProvider<DateTime?>((ref) => null);
final focusedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final calendarFormatProvider = StateProvider<CalendarFormat>((ref) => CalendarFormat.week);
