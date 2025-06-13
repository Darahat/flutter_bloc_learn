part of 'home_bloc.dart';

/// Base class for all states in the Home feature.
/// This class is immutable and sealed, meaning no other classes
/// outside this file can extend it.
@immutable
sealed class HomeState {}

/// Initial state of the Home feature.
/// Represents the default state when no specific state is set.
final class HomeInitial extends HomeState {}

/// State representing the counter value.
/// Extends [HomeInitial] and holds the current counter value.
final class CounterState extends HomeInitial {
  /// The current value of the counter.
  final int counter;

  /// Constructor for [CounterState].
  /// Requires the [counter] value to be provided.
  CounterState({required this.counter});
}
