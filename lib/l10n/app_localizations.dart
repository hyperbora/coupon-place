import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String get myCoupons => Intl.message('My Coupons', name: 'myCoupons');
  String get addCoupon => Intl.message('Add Coupon', name: 'addCoupon');
  String get expiringSoon =>
      Intl.message('Expiring Soon', name: 'expiringSoon');
  String get settings => Intl.message('Settings', name: 'settings');
  String get searchHint => Intl.message('Search Hint', name: 'searchHint');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ko'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final String name = locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);
    await initializeMessages(localeName);
    Intl.defaultLocale = localeName;
    return AppLocalizations();
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
