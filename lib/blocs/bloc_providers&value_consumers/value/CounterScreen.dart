
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_and_cubit/core/DataGenerator.dart';
import '../../../../../core/TextView.dart';
import '../../bloc_providers&value_consumers/bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';

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
          child: AppScaffold(
              title: 'BlocProvider.value() -> ValueConsumer',
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<CounterBloc, CounterState>(
                        builder: (context, state) => TextView(switch(state) {
                          Init() => '+/-',
                          Increased() => '+',
                          Decreased() => '-',
                          Refreshed() => '!',
                        })
                    ),
                    BlocSelector<CounterBloc, CounterState, int>(
                        selector: (state) => state.count,
                        builder: (context, value) => Column(
                          children: [
                            TextView('$value'),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(RandomGen.string(10))
                            )
                          ]
                        )
                    )
                  ]
                ),
              ),
              fab: Builder(
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            onPressed: () => bloc.add(const Decrement()),
                            heroTag: null,
                            child: const Icon(Icons.exposure_minus_1)
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            onPressed: () => bloc.add(const Refresh()),
                            heroTag: null,
                            child: const Icon(Icons.refresh)
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            onPressed: () => bloc.add(const Increment()),
                            heroTag: null,
                            child: const Icon(Icons.plus_one)
                        )
                      )
                    ]
                  )
              )
          )
      );

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
