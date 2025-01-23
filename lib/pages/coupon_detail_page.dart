import 'package:flutter/material.dart';
import '../models/coupon.dart';

class CouponDetailPage extends StatelessWidget {
  final Coupon coupon;

  const CouponDetailPage({Key? key, required this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coupon.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coupon.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Expiry Date: ${coupon.expiryDate.toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
