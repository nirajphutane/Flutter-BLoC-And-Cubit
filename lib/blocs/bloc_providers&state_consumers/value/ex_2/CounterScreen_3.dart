
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_and_cubit/core/TextView.dart';
import '../../../../core/DataGenerator.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';

class CounterScreen3 extends StatelessWidget {

  final CounterBloc bloc;

  const CounterScreen3(this.bloc, {super.key});

  @override
  Widget build(final BuildContext context) =>
      AppScaffold(
          title: 'child-3: constructor',
          showBackAction: false,
          body: Center(
            child: BlocBuilder<CounterBloc, CounterState>(
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
          ),
          fab: Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
      );
}
