import 'package:http/http.dart' as http;

class HttpClientManager {
  static final http.Client _client = http.Client();

  static http.Client get client => _client;

  static void dispose() {
    _client.close();
  }
}