
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/TextView.dart';
import '../../../../core/AppLog.dart';
import '../../../../core/AppToast.dart';
import '../../../../core/DataGenerator.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';

class CounterScreen2 extends StatelessWidget {

  const CounterScreen2({super.key});

  @override
  Widget build(final BuildContext context) =>
      AppScaffold(
          title: 'child-2',
          showBackAction: false,
          body: Center(
              child: BlocConsumer<CounterBloc, CounterState>(
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
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(RandomGen.string(10))
                        )
                      ]
                  ),
                  listener: (context, state) => AppToast.show(switch(state) {
                    Init() => 'Initial State',
                    _ => '${state.count}'
                  })
              )
          ),
          fab: Row(
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
      );
}
