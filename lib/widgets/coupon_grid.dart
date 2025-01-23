import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../pages/coupon_detail_page.dart';

class CouponGrid extends StatelessWidget {
  final List<Coupon> coupons;

  const CouponGrid({Key? key, required this.coupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final gridView = GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CouponDetailPage(coupon: coupon),
              ),
            );
          },
          child: Card(
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coupon.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    coupon.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Expiry: ${coupon.expiryDate.toLocal()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDarkMode ? Colors.white54 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return isLandscape ? SafeArea(child: gridView) : gridView;
  }
}
