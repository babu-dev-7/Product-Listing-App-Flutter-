import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = "favorites";

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(boxName);
  }

  static Box<int> get box => Hive.box<int>(boxName);

  static void toggleFavorite(int id) {
    if (box.containsKey(id)) {
      box.delete(id);
    } else {
      box.put(id, id);
    }
  }

  static bool isFavorite(int id) {
    return box.containsKey(id);
  }
}
