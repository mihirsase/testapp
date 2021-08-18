import 'package:flutter/material.dart';

class MarginAtom extends StatelessWidget {
  final Widget child;
  final double top;
  final double bottom;

  MarginAtom({
    required final this.child,
    final this.top = 0,
    final this.bottom = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _padding(context),
        right: _padding(context),
        top: top,
        bottom: bottom,
      ),
      child: child,
    );
  }

  double _padding(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.055;
  }
}
