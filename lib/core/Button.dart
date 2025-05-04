
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text;
  final Function onTab;

  const AppButton({super.key, required this.text, required this.onTab});

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8),
    child: MaterialButton(
        color: Colors.deepPurpleAccent,
        onPressed: () => onTab.call(),
        child: Text(text)),
  );
}
