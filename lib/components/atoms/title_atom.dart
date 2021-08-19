import 'package:flutter/material.dart';
import 'package:testapp/components/atoms/margin_atom.dart';
import 'package:testapp/services/pallete.dart';

class TitleAtom extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleAtom({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.secondaryBackground,
      padding: EdgeInsets.symmetric(
        vertical: 32,
      ),
      child: MarginAtom(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  color: Pallete.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Pallete.secondaryText,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
