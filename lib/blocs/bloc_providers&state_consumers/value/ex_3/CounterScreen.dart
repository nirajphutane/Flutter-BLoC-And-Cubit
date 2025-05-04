
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/TextView.dart';
import '../../../../core/Button.dart';
import '../../../../core/DataGenerator.dart';
import '../../../../core/Navigation.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';
import 'CounterScreen_1.dart';
import 'CounterScreen_2.dart';
import 'CounterScreen_3.dart';

class CounterScreen extends StatefulWidget {

  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreen();
}

class _CounterScreen extends State<CounterScreen> {

  final CounterBloc bloc = CounterBloc();

  @override
  Widget build(final BuildContext context) => BlocProvider<CounterBloc>.value(
      value: bloc,
      child: const MaterialApp(
          home: CounterUI()
      )
  );

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}

class CounterUI extends StatelessWidget {

  const CounterUI({super.key});

  @override
  Widget build(final BuildContext context) => AppScaffold(
      title: 'BlocProvider.value() --> StateConsumer: Children[build, didChangeDependencies, constructor]',
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<CounterBloc, CounterState>(
                          builder: (context, state) => Column(
                              children: [
                                TextView(switch(state) {
                                  Init() => '+/-',
                                  Increased() => '+',
                                  Decreased() => '-',
                                  Refreshed() => '!',
                                }),
                                TextView(switch(state) {
                                  Init() => 'Start count by clicking FAB',
                                  _ => '${state.count}'
                                }),
                                Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(RandomGen.string(10))
                                )
                              ]
                          )
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                    onPressed: () => context.read<CounterBloc>().add(const Decrement()),
                                    heroTag: null,
                                    child: const Icon(Icons.exposure_minus_1)
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                    onPressed: () => context.read<CounterBloc>().add(const Refresh()),
                                    heroTag: null,
                                    child: const Icon(Icons.refresh)
                                )
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                    onPressed: () => context.read<CounterBloc>().add(const Increment()),
                                    heroTag: null,
                                    child: const Icon(Icons.plus_one)
                                )
                            )
                          ]
                      )
                    ]
                )
            ),
            Expanded(
                child: Column(
                    children: [
                      AppButton(
                          text: 'Counter 1',
                          onTab: () => Navigation.push(context, const CounterScreen1())
                      ),
                      AppButton(
                          text: 'Counter 2',
                          onTab: () => Navigation.push(context, const CounterScreen2())
                      ),
                      AppButton(
                          text: 'Counter 3',
                          onTab: () => Navigation.push(context, CounterScreen3(context.read<CounterBloc>()))
                      )
                    ]
                )
            )
          ]
      )
  );
}