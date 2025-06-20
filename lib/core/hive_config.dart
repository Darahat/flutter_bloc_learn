import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const boxName = 'text_box';
  static Future<void> init() async {
    /// initialize hive
    await Hive.initFlutter();

    /// open the box text_box;
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<String>(boxName);
    }
    ;
  }

  /// close all boxes when app is terminated
  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
