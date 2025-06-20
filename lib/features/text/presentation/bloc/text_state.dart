part of 'text_bloc.dart';

sealed class TextState {
  const TextState();
}

final class TextInitial extends TextState {
  const TextInitial();
}

final class TextLoaded extends TextState {
  final List<String> entries;
  const TextLoaded(this.entries);
}
