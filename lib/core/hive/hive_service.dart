import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String favoritesBoxName = "favorites";
  static const String cartBoxName = "cart";

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<int>(favoritesBoxName);
    await Hive.openBox<int>(cartBoxName);
  }

  // ── Favorites ──
  static Box<int> get _favBox => Hive.box<int>(favoritesBoxName);

  static void toggleFavorite(int id) {
    if (_favBox.containsKey(id)) {
      _favBox.delete(id);
    } else {
      _favBox.put(id, id);
    }
  }

  static bool isFavorite(int id) {
    return _favBox.containsKey(id);
  }

  // ── Cart ──
  static Box<int> get _cartBox => Hive.box<int>(cartBoxName);

  static void toggleCart(int id) {
    if (_cartBox.containsKey(id)) {
      _cartBox.delete(id);
    } else {
      _cartBox.put(id, id);
    }
  }

  static bool isInCart(int id) {
    return _cartBox.containsKey(id);
  }
}
