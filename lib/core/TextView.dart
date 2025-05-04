
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {

  final String text;

  const TextView(this.text, {super.key});

  @override
  Widget build(final BuildContext context) => Text(
      text,
      style: const TextStyle(
          fontSize: 20,
          shadows: [
            Shadow(
                color: Colors.deepPurpleAccent,
                blurRadius: 2.5,
                offset: Offset(-15.0, -15.0)
            ),
            Shadow(
                color: Colors.purpleAccent,
                blurRadius: 2.5,
                offset: Offset(15.0, 15.0)
            )
          ]
      )
  );
}