import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
sealed class CounterState {
  final int count;
  const CounterState(this.count);
}

final class Init extends CounterState {
  const Init(): super(0);
}

final class Increased extends CounterState {
  final int count;
  const Increased(this.count): super(count);
}

final class Decreased extends CounterState {
  final int count;
  const Decreased(this.count): super(count);
}

final class Refreshed extends CounterState {
  final int count;
  const Refreshed(this.count): super(count);
}

@immutable
sealed class CounterEvent {
  const CounterEvent();
}

final class Increment extends CounterEvent {
  const Increment();
}

final class Decrement extends CounterEvent {
  const Decrement();
}

final class Refresh extends CounterEvent {
  const Refresh();
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const Init()) {
    on<Increment>((event, emit) {
      emit(Increased(switch (state) {
        Init(:final count) => count-1,
        Increased(:final count) => count,
        Decreased(:final count) || Refreshed(:final count) => count-1
      } + 1));
    });

    on<Decrement>((event, emit) {
      emit(Decreased(switch (state) {
        Init(:final count) => count+1,
        Increased(:final count) || Refreshed(:final count) => count+1,
        Decreased(:final count) => count
      } - 1));
    });
  }
}
