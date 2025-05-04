
import 'package:flutter/material.dart';

class Navigation {

  static void push(final BuildContext context, final Widget screen) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => screen)
  );
}