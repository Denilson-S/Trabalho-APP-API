import 'package:dotenv/dotenv.dart';

final env = DotEnv()..load();

class AppDefines {
  static String get apiUrl => env['API_URL'] ?? 'http://192.168.1.37:5000/api';
}