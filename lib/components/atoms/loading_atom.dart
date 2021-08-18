import 'package:flutter/material.dart';
import 'package:testapp/components/atoms/empty_atom.dart';
import 'package:testapp/components/atoms/refresh_atom.dart';
import 'package:testapp/services/pallete.dart';

class LoadingAtom extends StatelessWidget {
  final Future<void> Function()? onRefresh;

  LoadingAtom({
    final this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (onRefresh != null) {
      return RefreshAtom(
        onRefresh: onRefresh!,
        child: EmptyAtom(
          child: CircularProgressIndicator(
          ),
        ),
      );
    } else {
      return CircularProgressIndicator(
        color: Pallete.green,
      );
    }
  }
}
