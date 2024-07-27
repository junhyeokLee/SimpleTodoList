import 'package:flutter/material.dart';

class CircularRevealPage extends Page {
  final Widget child;

  CircularRevealPage({
    required this.child,
    LocalKey? key,
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return CircularRevealPageRoute(
      page: this,
      child: child,
    );
  }
}

class CircularRevealPageRoute extends PageRouteBuilder {
  final CircularRevealPage page;
  final Widget child;

  CircularRevealPageRoute({
    required this.page,
    required this.child,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final size = MediaQuery.of(context).size;
      final tween = Tween<double>(
        begin: (size.width + size.height) / 2,
        end: 0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      ));

      return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final radius = tween.value;
          return ClipPath(
            clipper: CircleRevealClipper(radius: radius),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: child,
      );
    },
    transitionDuration: duration,
  );
}

class CircleRevealClipper extends CustomClipper<Path> {
  final double radius;

  CircleRevealClipper({required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return radius != oldClipper.radius;
  }
}