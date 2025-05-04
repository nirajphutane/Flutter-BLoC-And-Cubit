
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/TextView.dart';
import '../../../../core/AppToast.dart';
import '../../../../core/DataGenerator.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';

class CounterScreen2 extends StatefulWidget {

  const CounterScreen2({super.key});

  @override
  State<CounterScreen2> createState() => _CounterScreen2();
}

class _CounterScreen2 extends State<CounterScreen2> {

  late CounterBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = context.read<CounterBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(final BuildContext context) => AppScaffold(
      title: 'child-2: didChangeDependencies',
      body: Center(
        child: BlocConsumer<CounterBloc, CounterState>(
            builder: (context, state) => Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            listener: (context, state) => AppToast.show(switch(state) {
              Init() => 'Initial State',
              _ => '${state.count}'
            })
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
