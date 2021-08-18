import 'package:flutter/material.dart';

class FormAtom extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? scrollController;
  final bool isAlwaysScrollable;

  FormAtom({
    required final this.children,
    final this.crossAxisAlignment = CrossAxisAlignment.center,
    final this.scrollController,
    final this.isAlwaysScrollable = false,
  });

  @override
  Widget build(final BuildContext _) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: isAlwaysScrollable ? AlwaysScrollableScrollPhysics() : null,
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisSize: MainAxisSize.max,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }
}
