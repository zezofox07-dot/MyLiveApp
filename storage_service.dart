import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  Future<bool> saveString(String key, String value) async => await prefs.setString(key, value);

  String? getString(String key) => prefs.getString(key);

  Future<bool> saveInt(String key, int value) async => await prefs.setInt(key, value);

  int? getInt(String key) => prefs.getInt(key);

  Future<bool> saveBool(String key, bool value) async => await prefs.setBool(key, value);

  bool? getBool(String key) => prefs.getBool(key);

  Future<bool> saveJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await saveString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic>? getJson(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString == null) return null;
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveJsonList(String key, List<Map<String, dynamic>> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await saveString(key, jsonString);
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> getJsonList(String key) {
    try {
      final jsonString = getString(key);
      if (jsonString == null) return [];
      final decoded = jsonDecode(jsonString);
      if (decoded is! List) return [];
      final validItems = <Map<String, dynamic>>[];
      for (var item in decoded) {
        if (item is Map<String, dynamic>) {
          validItems.add(item);
        }
      }
      return validItems;
    } catch (e) {
      return [];
    }
  }

  Future<bool> remove(String key) async => await prefs.remove(key);

  Future<bool> clear() async => await prefs.clear();
}
