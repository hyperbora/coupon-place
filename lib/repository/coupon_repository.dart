import 'dart:io';
import 'package:drift/drift.dart';
import '../data/database.dart';
import '../data/image_storage.dart';

Future<int> insertCouponWithImage(Coupon coupon, File imageFile) async {
  final imagePath = await saveImage(imageFile);
  final newCoupon = coupon.copyWith(imagePath: Value(imagePath));
  return AppDatabase().insertCoupon(newCoupon);
}
