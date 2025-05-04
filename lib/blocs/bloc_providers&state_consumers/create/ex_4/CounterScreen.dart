
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Button.dart';
import '../../../../../core/Navigation.dart';
import '../../../../../core/TextView.dart';
import '../../../../core/DataGenerator.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';
import 'CounterScreen_1.dart';
import 'CounterScreen_2.dart';

class CounterScreen extends StatelessWidget {

  const CounterScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CounterBloc>(
    create: (context) => CounterBloc(),
    child: const MaterialApp(
        home: CounterUI()
    )
  );
}

class CounterUI extends StatelessWidget {

  const CounterUI({super.key});

  @override
  Widget build(final BuildContext context) => AppScaffold(
    title: 'BlocProvider.create() -Nav-> StateConsumer: Children[BlocProvider.create(child-1), child-2: BlocProvider.create()]',
    body: Column(
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
                                padding: const EdgeInsets.all(16),
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
                    onTab: () => Navigation.push(
                        context,
                        BlocProvider<CounterBloc>(
                            create: (context) => CounterBloc(),
                            child: const CounterScreen1()
                        )
                    )
                ),
                AppButton(
                    text: 'Counter 2',
                    onTab: () => Navigation.push(context, const CounterScreen2())
                )
              ]
            )
          )
        ]
    )
  );
}