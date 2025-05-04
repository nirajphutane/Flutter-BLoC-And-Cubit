
import 'package:flutter/material.dart';
import 'core/AppScaffold.dart';
import 'core/Button.dart';
import 'core/Navigation.dart';
import 'blocs/bloc_providers&state_consumers/create/ex_1/CounterScreen.dart' as bloc_1;
import 'blocs/bloc_providers&state_consumers/create/ex_2/CounterScreen.dart' as bloc_2;
import 'blocs/bloc_providers&state_consumers/create/ex_3/CounterScreen.dart' as bloc_3;
import 'blocs/bloc_providers&state_consumers/create/ex_4/CounterScreen.dart' as bloc_4;
import 'blocs/bloc_providers&state_consumers/value/ex_1/CounterScreen.dart' as bloc_5;
import 'blocs/bloc_providers&state_consumers/value/ex_2/CounterScreen.dart' as bloc_6;
import 'blocs/bloc_providers&state_consumers/value/ex_3/CounterScreen.dart' as bloc_7;
import 'blocs/bloc_providers&value_consumers/create/CounterScreen.dart' as bloc_8;
import 'blocs/bloc_providers&value_consumers/value/CounterScreen.dart' as bloc_9;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(final BuildContext context) => AppScaffold(
    title: 'Home',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                text: '1. BlocProvider.create() --> StateConsumer: Children',
                onTab: () => Navigation.push(context, bloc_1.CounterScreen())
              ),
              AppButton(
                  text: '2. BlocProvider.create() --> StateConsumer: Children[BlocProvider.create(child), child: BlocProvider.create()]',
                  onTab: () => Navigation.push(context, bloc_2.CounterScreen())
              ),
              AppButton(
                  text: '3. BlocProvider.create() -Nav-> StateConsumer: Children',
                  onTab: () => Navigation.push(context, const bloc_3.CounterScreen())
              ),
              AppButton(
                  text: '4. BlocProvider.create() -Nav-> StateConsumer: Children[BlocProvider.create(child), child: BlocProvider.create()]',
                  onTab: () => Navigation.push(context, const bloc_4.CounterScreen())
              ),
              AppButton(
                  text: '5. BlocProvider.value() --> StateConsumer: Children',
                  onTab: () => Navigation.push(context, const bloc_5.CounterScreen())
              ),
              AppButton(
                  text: '6. BlocProvider.value() --> StateConsumer: Children[build, didChangeDependencies, constructor]',
                  onTab: () => Navigation.push(context, const bloc_6.CounterScreen())
              ),
              AppButton(
                  text: '7. BlocProvider.value() --> StateConsumer: Children[build, didChangeDependencies, constructor]',
                  onTab: () => Navigation.push(context, const bloc_7.CounterScreen())
              ),
              AppButton(
                  text: '8. BlocProvider.create() -> ValueConsumer',
                  onTab: () => Navigation.push(context, const bloc_8.CounterScreen())
              ),
              AppButton(
                  text: '9. BlocProvider.value() -> ValueConsumer',
                  onTab: () => Navigation.push(context, const bloc_9.CounterScreen())
              )
            ]
          )
        )
      ]
    )
  );
}