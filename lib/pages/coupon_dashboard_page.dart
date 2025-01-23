import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../widgets/coupon_grid.dart';
import '../l10n/app_localizations.dart';

class CouponDashboardPage extends StatefulWidget {
  const CouponDashboardPage({super.key});

  @override
  _CouponDashboardPageState createState() => _CouponDashboardPageState();
}

class _CouponDashboardPageState extends State<CouponDashboardPage> {
  int _selectedIndex = 0;

  final List<Coupon> _coupons = List.generate(
    20,
    (index) => Coupon(
      title: 'Coupon $index',
      description: 'Description for coupon $index',
      expiryDate: DateTime.now().add(Duration(days: index)),
    ),
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('My Coupons')),
    Center(child: Text('Add Coupon')),
    Center(child: Text('Expiring Soon')),
    Center(child: Text('Settings')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final List<String> titles = [
      localizations.myCoupons,
      localizations.addCoupon,
      localizations.expiringSoon,
      localizations.settings,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
      ),
      body: _selectedIndex == 0
          ? CouponGrid(coupons: _coupons)
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: localizations.myCoupons,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: localizations.addCoupon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: localizations.expiringSoon,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: localizations.settings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
