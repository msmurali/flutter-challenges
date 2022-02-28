import 'package:flutter/material.dart';

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

class RipplePageRoute extends PageRouteBuilder {
  /// [GlobalKey] of widget where the ripple animation starts.
  /// if [null], animation starts from the center of the screen.
  final GlobalKey? anchor;

  RipplePageRoute({
    RouteSettings? settings,
    required RoutePageBuilder pageBuilder,
    RouteTransitionsBuilder? transitionsBuilder,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
    bool opaque = true,
    bool barrierDismissible = false,
    Color? barrierColor,
    String? barrierLabel,
    bool maintainState = true,
    bool fullscreenDialog = false,
    this.anchor,
  }) : super(
          pageBuilder: pageBuilder,
          barrierColor: barrierColor,
          barrierDismissible: barrierDismissible,
          barrierLabel: barrierLabel,
          fullscreenDialog: fullscreenDialog,
          maintainState: maintainState,
          opaque: opaque,
          reverseTransitionDuration: reverseTransitionDuration,
          settings: settings,
          transitionDuration: transitionDuration,
          transitionsBuilder: transitionsBuilder ?? _defaultTransitionsBuilder,
        );

  Offset _getAnchorCenter(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final RenderBox? renderBox =
        anchor?.currentContext?.findRenderObject() as RenderBox;

    final Offset? anchorPosition = renderBox?.localToGlobal(Offset.zero);

    final Size? anchorSize = renderBox?.size;

    if (anchorPosition != null && anchorSize != null) {
      final Offset anchorCenter = Offset(anchorPosition.dx, anchorPosition.dy);

      return anchorSize.center(anchorCenter);
    } else {
      return screenSize.center(Offset.zero);
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final Size screenSize = MediaQuery.of(context).size;

    return ClipOval(
      clipper: _AnimatedRippleClip(
        animation: animation,
        maxRadius: screenSize.longestSide * 1.5,
        begin: _getAnchorCenter(context),
        end: screenSize.center(Offset.zero),
      ),
      child: child,
    );
  }
}

class _AnimatedRippleClip extends CustomClipper<Rect> {
  /// Animates the circular clip path when route is pushed in and popped out
  /// from the [Navigator] stack.
  ///
  /// [animation] runs from 0.0 to 1.0 when the route is pushed into the
  ///  [Navigator] stack. When the route pop out from the [Navigator] stack
  /// [animation] runs from 1.0 to 0.0.
  final Animation<double> animation;

  /// [Offset] at the start of the [animation].
  final Offset begin;

  /// [Offset] at the end of the [animation].
  final Offset end;

  /// Maximum radius of clip path at end of the [animation].
  final double maxRadius;

  /// Center of the [Rect] where the actual clipping occurs.
  late Animation<Offset> center;

  _AnimatedRippleClip({
    required this.animation,
    required this.begin,
    required this.end,
    required this.maxRadius,
  }) {
    center = Tween<Offset>(begin: begin, end: end)
        .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn))
        .animate(animation);
  }

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: center.value,
        width: maxRadius * animation.value,
        height: maxRadius * animation.value);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
