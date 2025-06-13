part of 'home_bloc.dart';

/// Base class for all events related to the Home feature.
/// This class is immutable and sealed, meaning no other classes
/// can extend it outside of this file.
@immutable
sealed class HomeEvent {}

/// Event triggered when the counter increment button is pressed.
/// This extends the base `HomeEvent` class.
class CounterIncrementPressed extends HomeEvent {
  final int counter;

  CounterIncrementPressed({required this.counter});
}
