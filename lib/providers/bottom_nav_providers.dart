import 'package:hooks_riverpod/hooks_riverpod.dart';

// currentIndex를 관리하는 StateProvider 정의
final currentIndexProvider = StateProvider<int>((ref) => 0);