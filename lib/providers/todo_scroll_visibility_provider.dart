// todo_scroll_visibility_provider.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoScrollVisibilityProvider = StateProvider<bool>((ref) => false);

void updateScrollVisibility(WidgetRef ref, bool isVisible) {
  ref.read(todoScrollVisibilityProvider.notifier).state = isVisible;
}