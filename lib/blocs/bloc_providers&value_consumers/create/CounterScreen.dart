
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/TextView.dart';
import '../../../core/DataGenerator.dart';
import '../../bloc_providers&value_consumers/bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';

class CounterScreen extends StatelessWidget {

  const CounterScreen({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
          child: AppScaffold(
              title: 'BlocProvider.create() -> ValueConsumer',
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
              )
          )
      );
}
