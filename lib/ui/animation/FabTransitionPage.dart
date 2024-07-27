
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabTransitionPage extends PageRouteBuilder {
  final Widget child;
  final Alignment centerAlignment;
  final Duration transitionDuration;

  FabTransitionPage({
    required Key key,
    required this.child,
    this.centerAlignment = Alignment.center,
    this.transitionDuration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: transitionDuration,
  );

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipPath(
            clipper: FabRevealClipper(
              revealPercent: animation.value,
              centerAlignment: centerAlignment,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class FabRevealClipper extends CustomClipper<Path> {
  final double revealPercent;
  final Alignment centerAlignment;

  FabRevealClipper({
    required this.revealPercent,
    required this.centerAlignment,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = centerAlignment.alongSize(size);
    final radius = size.shortestSide * revealPercent;
    path.addOval(Rect.fromCircle(center: center, radius: radius));
    return path;
  }

  @override
  bool shouldReclip(FabRevealClipper oldClipper) {
    return oldClipper.revealPercent != revealPercent;
  }
}