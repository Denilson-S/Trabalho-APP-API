import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
class SettingsModel {
  Id id = 0; // Fixed ID for single settings object
  bool isDarkMode = true;
  String language = 'English';

  SettingsModel({
    this.isDarkMode = true,
    this.language = 'English',
  });
}