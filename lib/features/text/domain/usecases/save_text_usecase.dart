import 'package:flutter_bloc_learn/features/text/domain/entities/text_entry.dart';
import 'package:flutter_bloc_learn/features/text/domain/repositories/text_repository.dart';

final class SaveTextUsecase {
  final TextRepository repository;
  const SaveTextUsecase(this.repository);
  Future<void> call(TextEntry entry) => repository.saveText(entry);
}
