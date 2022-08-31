import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:r_localization/core/app_preference.dart';
import 'package:r_localization/core/datasets/default_localization_data.dart';

import '../../main.dart';
import '../models/localization_model.dart';


/// This is the singleton class that provides value to all application
class RLocalizationHelper{
  static final RLocalizationHelper _instance = RLocalizationHelper._internal();

  factory RLocalizationHelper() => _instance;

  RLocalizationHelper._internal();


  /// The selected localization data that is to be used in all the application
  late LocalizationBody selectedLocalization;

  /// All the localized data that are to be supported in the application
  late List<LocalizationBody> allLocalizationList;

  /// Initial selected locale of the application
  late Locale selectedLocale;


  initializeLocalizationValues() async{

    /// Setting default localization key as 'en' and it is also applicable
    /// for future on updating the localized key
    if (await RPreferenceHelper.getSelectedLocalizationKey() == null) {
      await RPreferenceHelper.setSelectedLocalizationKey('en');
    }
    final localKey = await RPreferenceHelper.getSelectedLocalizationKey();
    selectedLocale = Locale(localKey!);


    /// This method loads the default values saved in the application also we
    /// can update from anywhere and call this method again to setup the values
    if (await RPreferenceHelper.getAllLocalizedKey() == null) {
      await RPreferenceHelper.setAllLocalizedKey(getDefaultEnglishLocals());
      print("default english loaded");
    }
    final selectedLocalizedList = await RPreferenceHelper.getAllLocalizedKey();
    allLocalizationList = selectedLocalizedList!;



    /// Set selected language by sorting with the saved localized key
    for (var element in selectedLocalizedList) {
      if (element.languageKey == localKey) {
        selectedLocalization = element;
        print('${element.languageName} Language LOADED');
      }
    }


  }


  /// This is the default localization that is used in the application
  /// 'localizationModel' has initial data and update the data there to
  /// update on all application

  static List<LocalizationBody> getDefaultEnglishLocals() {
    List<LocalizationBody> allLocals = [];
    for (Map<String, dynamic> advice in localizationModel) {
      final extractedLocals = LocalizationBody.fromJson(advice);
      allLocals.add(extractedLocals);
    }
    return allLocals;
  }



  /// add all the supported locale to the app
  List<Locale> getLocalsList() {
    List<Locale> locals = [];
    /// All available delegates
    for(var element in kMaterialSupportedLanguages){
      locals.add(Locale(element));
    }
    return locals;
  }


  updateLocalizationKey(String localizationKey, BuildContext context) async {
    await RPreferenceHelper.setSelectedLocalizationKey(localizationKey);
    await initializeLocalizationValues();
    // ignore: use_build_context_synchronously
    InitApp.setLocale(context, selectedLocale);
  }

  getLanguageList() {
    List<String> languageKeys = [];
    for(final locale in allLocalizationList){
      languageKeys.add(locale.languageKey!);
    }
    return languageKeys;
  }


  /// This gets the value for localized keys
  String getValue(String name) {
    try {
      for (final locals in selectedLocalization.localizationData!) {
        if (locals.localizationKey! == name) {
          return locals.localizationLabel!;
        }
      }
      print('LOCALIZATION KEY----------> $name \t not found');
      return getCapitalizedCamelCase(name.split(".").last);
    } catch (e) {
      print('$name not found $e');
      return getCapitalizedCamelCase(name.split(".").last);
    }
  }

  /// Getting camelcase to titled String if no value found
  /// Only used if the value is not found
  static getCapitalizedCamelCase(String camelCase) {
    return camelCase.replaceAllMapped(RegExp(r'^([a-z])|[A-Z]'),
            (Match m) => m[1] == null ? " ${m[0]}" : m[1]!.toUpperCase());
  }
}