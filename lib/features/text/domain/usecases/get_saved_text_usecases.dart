import 'package:flutter_bloc_learn/features/text/domain/entities/text_entry.dart';
import 'package:flutter_bloc_learn/features/text/domain/repositories/text_repository.dart';

final class GetSavedTextUsecases {
  final TextRepository repository;
  const GetSavedTextUsecases(this.repository);
  List<TextEntry> call() => repository.getSavedTexts();
}
