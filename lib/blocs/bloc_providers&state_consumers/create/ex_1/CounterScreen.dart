
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_and_cubit/core/DataGenerator.dart';
import '../../../../../core/TextView.dart';
import '../../bloc/counter_bloc.dart';
import '/core/AppScaffold.dart';
import 'CounterScreen_1.dart';
import 'CounterScreen_2.dart';

class CounterScreen extends StatelessWidget {

  CounterScreen({super.key});

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(final BuildContext context) =>
      BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
          child: AppScaffold(
            title: 'BlocProvider.create() --> StateConsumer: Children',
            body: Column(
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text(RandomGen.string(10))
                                  )
                                ]
                            )
                        ),
                        Builder(
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
                      ]
                    )
                ),
                Expanded(
                  child: ValueListenableBuilder<int>(
                      valueListenable: _selectedIndex,
                      builder: (context, index, child) => [const CounterScreen1(), const CounterScreen2()][index],
                  ),
                )
              ]
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex.value,
              onDestinationSelected: (i) => _selectedIndex.value = i,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.looks_one_outlined), label: '1', selectedIcon: Icon(Icons.looks_one_sharp, color: Colors.deepPurpleAccent)),
                NavigationDestination(icon: Icon(Icons.looks_two_outlined), label: '2', selectedIcon: Icon(Icons.looks_two_sharp, color: Colors.deepPurpleAccent))
              ]
            )
          )
      );
}
