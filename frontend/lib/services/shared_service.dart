import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<void> saveData(String key, dynamic value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      // Handle or log the exception
      print('Error saving data: $e');
    }
  }

  static Future<String?> getData(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      // Handle or log the exception
      print('Error retrieving data: $e');
      return null;
    }
  }
}
