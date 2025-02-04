import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'folder_dashboard_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

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

    final List<Widget> widgetOptions = <Widget>[
      FolderDashboardPage(
        title: titles[0],
      ),
      Center(child: Text('Add Coupon')),
      Center(child: Text('Expiring Soon')),
      Center(child: Text('Settings')),
    ];

    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
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
