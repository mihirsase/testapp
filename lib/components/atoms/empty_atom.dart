import 'package:flutter/material.dart';

class EmptyAtom extends StatelessWidget {
  final Widget child;
  final Alignment? alignment;

  EmptyAtom({
    required final this.child,
    final this.alignment,
  });

  @override
  Widget build(final BuildContext _) {
    return LayoutBuilder(
      builder: (final BuildContext _, final BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Align(
              alignment: alignment ?? Alignment.center,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
