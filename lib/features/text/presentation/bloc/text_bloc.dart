import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/features/text/domain/entities/text_entry.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc_learn/features/text/domain/usecases/save_text_usecase.dart';
import 'package:flutter_bloc_learn/features/text/domain/repositories/text_repository.dart';
part 'text_event.dart';
part 'text_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  final SaveTextUsecase useCase;
  final TextRepository repository;
  TextBloc(this.useCase, this.repository) : super(TextInitial()) {
    on<AddTextEvent>((event, emit) async {
      final entry = TextEntry(id: const Uuid().v4(), text: event.text);
      await useCase(entry);
      emit(
        TextLoaded(
          repository.getSavedTexts().map((entry) => entry.text).toList(),
        ),
      );
    });
  }
}
