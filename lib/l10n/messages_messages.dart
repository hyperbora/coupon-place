// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'messages';

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'addCoupon': MessageLookupByLibrary.simpleMessage('Add Coupon'),
    'addFolder': MessageLookupByLibrary.simpleMessage('Add Folder'),
    'cancel': MessageLookupByLibrary.simpleMessage('cancel'),
    'confirm': MessageLookupByLibrary.simpleMessage('confirm'),
    'expiringSoon': MessageLookupByLibrary.simpleMessage('Expiring Soon'),
    'list': MessageLookupByLibrary.simpleMessage('list'),
    'menuAllCoupons': MessageLookupByLibrary.simpleMessage('All Coupons'),
    'menuExpiringSoon': MessageLookupByLibrary.simpleMessage('Expiring Soon'),
    'menuFavorites': MessageLookupByLibrary.simpleMessage('Favorites'),
    'menuRecentlyDeleted': MessageLookupByLibrary.simpleMessage('Recently Deleted'),
    'menuUsedCoupons': MessageLookupByLibrary.simpleMessage('Used Coupons'),
    'myCoupons': MessageLookupByLibrary.simpleMessage('My Coupons'),
    'myFolder': MessageLookupByLibrary.simpleMessage('My Folder'),
    'newFolderNameHint': MessageLookupByLibrary.simpleMessage('New Folder Name'),
    'searchHint': MessageLookupByLibrary.simpleMessage('Search'),
    'settings': MessageLookupByLibrary.simpleMessage('Settings')
  };
}
