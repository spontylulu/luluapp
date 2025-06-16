import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const _endpointKey = 'ia_endpoint';
  static const defaultEndpoint = 'https://lulu-ai.loca.lt';

  static Future<String> getEndpoint() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_endpointKey) ?? defaultEndpoint;
  }

  static Future<void> setEndpoint(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_endpointKey, url);
  }
}
