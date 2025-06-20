part of 'text_bloc.dart';

@immutable
sealed class TextEvent {
  const TextEvent();
}

final class AddTextEvent extends TextEvent {
  const AddTextEvent(this.text);
  final String text;
}
