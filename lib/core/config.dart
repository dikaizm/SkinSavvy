import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final String serverAddress = dotenv.get('SERVER_ADDRESS');
}
