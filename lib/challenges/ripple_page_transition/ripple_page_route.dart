import 'package:flutter/material.dart';

class RipplePageRoute extends PageRouteBuilder {
  final Widget page;
  final GlobalKey anchor;

  RipplePageRoute({required this.page, required this.anchor})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration: const Duration(milliseconds: 300),
        );

  Offset _getAnchorCenter(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final RenderBox? renderBox =
        anchor.currentContext?.findRenderObject() as RenderBox;

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
      clipper: AnimatedRippleClip(
        animation: animation,
        maxRadius: screenSize.longestSide * 1.5,
        begin: _getAnchorCenter(context),
        end: screenSize.center(Offset.zero),
      ),
      child: child,
    );
  }
}

class AnimatedRippleClip extends CustomClipper<Rect> {
  final Animation<double> animation;
  final Offset begin;
  final Offset end;
  final double maxRadius;
  late Tween<Offset> center;

  AnimatedRippleClip({
    required this.animation,
    required this.begin,
    required this.end,
    required this.maxRadius,
  }) {
    center = Tween<Offset>(
      begin: begin,
      end: end,
    );
  }

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: center.evaluate(animation),
        width: maxRadius * animation.value,
        height: maxRadius * animation.value);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
