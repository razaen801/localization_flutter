import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:r_localization/core/localization/r_localization_helper.dart';

class RLocalizations{
  RLocalizations(this.locale);

  final Locale locale;

  static RLocalizations of(BuildContext context) {
    return Localizations.of<RLocalizations>(
        context, RLocalizations)!;
  }

  static List<String> languages() => RLocalizationHelper().getLanguageList();

  /// Gets value from saved values
  String getValue(String localizationKey){
    return RLocalizationHelper().getValue(localizationKey);
  }

}

class RLocalizationDelegate extends LocalizationsDelegate<RLocalizations> {
  const RLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      RLocalizations.languages().contains(locale.languageCode);

  @override
  Future<RLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<RLocalizations>(
        RLocalizations(locale));
  }

  @override
  bool shouldReload(RLocalizationDelegate old) => false;
}