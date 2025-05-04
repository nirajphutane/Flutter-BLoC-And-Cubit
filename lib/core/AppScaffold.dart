
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {

  final String? title;
  final Widget body;
  final Widget? fab;
  final Widget? bottomNavigationBar;
  final bool showBackAction;
  final Function? onBackClickListener;

  const AppScaffold({super.key, this.title, required this.body, this.fab, this.bottomNavigationBar, this.showBackAction = true, this.onBackClickListener});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: title != null? AppBar(
      title: Text(title!),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      automaticallyImplyLeading: showBackAction,
      centerTitle: true,
      leading: onBackClickListener != null? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => onBackClickListener
      ): null
    ): null,
    body: body,
    floatingActionButton: fab,
    bottomNavigationBar: bottomNavigationBar
  );
}