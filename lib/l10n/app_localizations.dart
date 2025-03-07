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
  String get searchHint => Intl.message('Search', name: 'searchHint');
  String get menuAllCoupons => Intl.message(
        'All Coupons',
        name: 'menuAllCoupons',
      );

  String get menuExpiringSoon => Intl.message(
        'Expiring Soon',
        name: 'menuExpiringSoon',
      );

  String get menuUsedCoupons => Intl.message(
        'Used Coupons',
        name: 'menuUsedCoupons',
      );

  String get menuFavorites => Intl.message(
        'Favorites',
        name: 'menuFavorites',
      );

  String get menuRecentlyDeleted => Intl.message(
        'Recently Deleted',
        name: 'menuRecentlyDeleted',
      );

  String get myFolder => Intl.message('My Folder', name: 'myFolder');

  String get addFolder => Intl.message('Add Folder', name: 'addFolder');

  String get newFolderNameHint => Intl.message(
        'New Folder Name',
        name: 'newFolderNameHint',
      );

  String get confirm => Intl.message(
        'confirm',
        name: 'confirm',
      );

  String get cancel => Intl.message(
        'cancel',
        name: 'cancel',
      );

  String get list => Intl.message(
        'list',
        name: 'list',
      );
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
