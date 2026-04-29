import 'package:app_quizz/models/history_model.dart';
import 'package:app_quizz/models/player_model.dart';
import 'package:app_quizz/models/settings_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;

  LocalStorage._internal();

  late final Isar isar;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _instance.isar = await Isar.open(
      [
        PlayerModelSchema,
        SettingsModelSchema,
        HistoryModelSchema,
      ],
      directory: dir.path,
    );
  }

  // Isar Abstrações
  Future<T> writeTxn<T>(Future<T> Function() callback) async {
    return await isar.writeTxn(callback);
  }

  Future<T> readTxn<T>(Future<T> Function() callback) async {
    return await isar.txn(callback);
  }

  Future<void> clearAll() async {
    await isar.writeTxn(() => isar.clear());
  }

  // Secure Storage Abstrações
  Future<void> writeSecure(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecure(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecure(String key) async {
    await _secureStorage.delete(key: key);
  }
}
