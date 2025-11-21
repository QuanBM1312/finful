import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

const _kDefaultLocale = Locale('en');

///
/// To load data from local:
/// Create folder at "root/l10n"
/// Add json file named [languageCode].json to l10n folder
/// Add l10n folder to assets field at pubpec.yaml
///   assets:
///    - l10n/
///
class L10n {
  final Locale locale;
  static final L10n _instance = L10n(_kDefaultLocale);

  L10n(this.locale);

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n) ?? _instance;
  }

  Map<String, String> _loadedTranslations = {};

  Future<bool> loadFromLocal(Locale locale) async {
    final jsonString =
        await rootBundle.loadString('l10n/${locale.languageCode}.json');
    final jsonMap = json.decode(jsonString);

    _loadedTranslations = Map<String, String>.from(jsonMap);

    return true;
  }

  Future<bool> loadFromData({
    required Locale locale,
    required Map<String, String> loadedTranslations,
  }) async {
    _loadedTranslations = loadedTranslations;

    return true;
  }

  String translate(String key, {List<dynamic>? params}) {
    final result = _loadedTranslations[key] ?? key;
    if (params != null) {
      return sprintf(result, params);
    }
    return result;
  }

  String dateTimeFormat(DateTime dateTime, {String? format}) {
    return DateFormat(format, locale.countryCode).format(dateTime);
  }
}

class L10nDelegate extends LocalizationsDelegate<L10n> {
  /// The initial translations, often use to load localized strings from server.
  /// The translations must follow this format:
  /// {
  ///   "[languageCode]": {
  ///     "[key]": "[value]",
  ///   }
  /// }
  /// Eg:
  /// {
  ///   "en": {
  ///     "helloWorld": "Hello world",
  ///   },
  ///   "vi": {
  ///     "helloWorld": "Xin chào thế giới"
  ///   }
  /// }
  Map<String, Map<String, String>>? translations;

  L10nDelegate({
    this.translations,
  });

  @override
  bool isSupported(Locale locale) {
    // always return true for any locale from MaterialApp
    return true;
  }

  @override
  Future<L10n> load(Locale locale) async {
    final l10n = L10n(locale);
    if (translations?[locale.languageCode] != null) {
      await l10n.loadFromData(
        locale: locale,
        loadedTranslations: translations![locale.languageCode]!,
      );
    } else {
      await l10n.loadFromLocal(locale);
    }
    return l10n;
  }

  @override
  bool shouldReload(L10nDelegate old) {
    return old.translations != translations;
  }
}
