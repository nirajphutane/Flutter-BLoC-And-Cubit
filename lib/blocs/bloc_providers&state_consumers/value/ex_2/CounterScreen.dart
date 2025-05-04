
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/TextView.dart';
import '../../../../core/DataGenerator.dart';
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

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final CounterBloc bloc = CounterBloc();

  @override
  Widget build(final BuildContext context) =>
      BlocProvider.value(
          value: bloc,
          child: AppScaffold(
            title: 'BlocProvider.value() --> StateConsumer: Children[build, didChangeDependencies, constructor]',
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
                                    onPressed: () => bloc.add(const Increment()),
                                    heroTag: null,
                                    child: const Icon(Icons.plus_one)
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
                                    onPressed: () => bloc.add(const Decrement()),
                                    heroTag: null,
                                    child: const Icon(Icons.exposure_minus_1)
                                )
                              )
                            ]
                        )
                      ]
                    )
                ),
                Expanded(
                    child: ValueListenableBuilder<int>(
                        valueListenable: selectedIndex,
                        builder: (context, index, child) => [const CounterScreen1(), const CounterScreen2(), CounterScreen3(bloc)][index]
                    )
                )
              ]
            ),
            bottomNavigationBar: ValueListenableBuilder<int>(
                valueListenable: selectedIndex,
                builder: (context, index, child) => NavigationBar(
                    selectedIndex: selectedIndex.value,
                    onDestinationSelected: (i) => selectedIndex.value = i,
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.looks_one_outlined), label: '1', selectedIcon: Icon(Icons.looks_one_sharp, color: Colors.deepPurpleAccent)),
                      NavigationDestination(icon: Icon(Icons.looks_two_outlined), label: '2', selectedIcon: Icon(Icons.looks_two_sharp, color: Colors.deepPurpleAccent)),
                      NavigationDestination(icon: Icon(Icons.looks_3_outlined), label: '3', selectedIcon: Icon(Icons.looks_3_sharp, color: Colors.deepPurpleAccent))
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
