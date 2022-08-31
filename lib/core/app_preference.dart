import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'models/localization_model.dart';

class RPreferenceHelper{
  static const selectedLocalizationKey = 'SELECTED_LOCALIZATION_KEY';
  static const allLocalizedKey = 'ALL_LOCALIZED_KEY';


  /// a default selected localization key that is used in the application
  static setSelectedLocalizationKey(key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(selectedLocalizationKey, key);
  }

  static Future<String?> getSelectedLocalizationKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(selectedLocalizationKey);
  }

  /// setting and getting all the localized data in the app
  static setAllLocalizedKey(List<LocalizationBody> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(allLocalizedKey, jsonEncode(data));
  }

  static Future<List<LocalizationBody>?> getAllLocalizedKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      var stringKey = preferences.getString(allLocalizedKey);
      if (stringKey == null) {
        return null;
      }
      List<dynamic>? mapKeys = jsonDecode(stringKey);
      if (mapKeys == null) {
        return null;
      }
      List<LocalizationBody> allLocalizedBody = [];
      for (var element in mapKeys) {
        final locals = LocalizationBody.fromJson(element);
        allLocalizedBody.add(locals);
      }
      return allLocalizedBody;
    } catch (e) {
      print('localization error $e');
      return null;
    }
  }
}