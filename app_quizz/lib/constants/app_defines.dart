import 'package:dotenv/dotenv.dart';

final env = DotEnv()..load();

class AppDefines {
  static String get apiUrl => env['API_URL'] ?? 'http://localhost:5000/api';
}