import 'package:flutter_bloc_learn/features/text/domain/entities/text_entry.dart';

abstract interface class TextRepository {
  Future<void> saveText(TextEntry entry);
  List<TextEntry> getSavedTexts();
}
