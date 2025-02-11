// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'addCoupon': MessageLookupByLibrary.simpleMessage('추가하기'),
    'addFolder': MessageLookupByLibrary.simpleMessage('폴더 추가'),
    'cancel': MessageLookupByLibrary.simpleMessage('취소'),
    'confirm': MessageLookupByLibrary.simpleMessage('확인'),
    'expiringSoon': MessageLookupByLibrary.simpleMessage('만료 예정'),
    'list': MessageLookupByLibrary.simpleMessage('목록'),
    'menuAllCoupons': MessageLookupByLibrary.simpleMessage('전체'),
    'menuExpiringSoon': MessageLookupByLibrary.simpleMessage('만료 임박'),
    'menuFavorites': MessageLookupByLibrary.simpleMessage('즐겨찾기'),
    'menuUsedCoupons': MessageLookupByLibrary.simpleMessage('사용한 쿠폰'),
    'myCoupons': MessageLookupByLibrary.simpleMessage('내 쿠폰'),
    'myFolder': MessageLookupByLibrary.simpleMessage('내 폴더'),
    'newFolderNameHint': MessageLookupByLibrary.simpleMessage('새 폴더 이름'),
    'searchHint': MessageLookupByLibrary.simpleMessage('검색'),
    'settings': MessageLookupByLibrary.simpleMessage('설정')
  };
}
