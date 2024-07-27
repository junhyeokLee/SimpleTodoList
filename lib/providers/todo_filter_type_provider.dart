import 'package:hooks_riverpod/hooks_riverpod.dart';

enum TodoFilterType {
  all,
  today,
  completed,
  pinned,
}

final todoFilterType = StateProvider((ref) => TodoFilterType.today);
