import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApisPath {
  static String BASE_URL = dotenv.env['BASE_URL']!;
}
