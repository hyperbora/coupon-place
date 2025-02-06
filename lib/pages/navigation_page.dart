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
  final int _tabletWidth = 600;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    FolderDashboardPage(
      title: 'My Coupons',
    ),
    Center(child: Text('Add Coupon')),
    Center(child: Text('Expiring Soon')),
    Center(child: Text('Settings')),
  ];

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= _tabletWidth;
  }

  Widget tabletLayout(
    List<String> titles,
  ) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.local_offer),
                label: Text(titles[0]),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add),
                label: Text(titles[1]),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.access_time),
                label: Text(titles[2]),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text(titles[3]),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }

  Widget smartPhoneLayout(
    List<String> titles,
  ) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: titles[0],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: titles[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: titles[2],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: titles[3],
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
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

    return LayoutBuilder(builder: (context, constraints) {
      if (_isTablet(constraints)) {
        return tabletLayout(titles);
      } else {
        return smartPhoneLayout(titles);
      }
    });
  }
}
