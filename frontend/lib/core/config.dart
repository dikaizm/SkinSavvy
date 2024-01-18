import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String serverAddress = dotenv.get('SERVER_ADDRESS');
  static final String googleClientId = dotenv.get('GOOGLE_CLIENT_ID');
  static final String googleClientSecret = dotenv.get('GOOGLE_CLIENT_SECRET');
}
