import 'package:hive/hive.dart';
import 'package:flutter_bloc_learn/core/hive_config.dart';
import 'package:flutter_bloc_learn/features/text/domain/entities/text_entry.dart';
import 'package:flutter_bloc_learn/features/text/domain/repositories/text_repository.dart';

final class TextRepositoryImpl implements TextRepository {
  final Box<String> _box;

  // Get the already opened box with the correct type
  TextRepositoryImpl() : _box = Hive.box<String>(HiveConfig.boxName);

  @override
  Future<void> saveText(TextEntry entry) async {
    await _box.put(entry.id, entry.text);
  }

  @override
  List<TextEntry> getSavedTexts() {
    return _box.keys
        .map(
          (key) =>
              TextEntry(id: key.toString(), text: _box.get(key.toString())!),
        )
        .toList();
  }
}
