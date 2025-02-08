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
  final double _tabBarWidth = 500;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    FolderDashboardPage(),
    Center(child: Text('Add Coupon')),
    Center(child: Text('Expiring Soon')),
    Center(child: Text('Settings')),
  ];

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= _tabletWidth;
  }

  Widget tabletLayout(
    AppLocalizations localizations,
  ) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            // 좌측 패널
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[900],
                child: Column(
                  children: [
                    // 검색창
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '검색',
                          hintStyle: TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.white54),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // 메뉴 리스트
                    Expanded(
                      child: ListView(
                        children: [
                          MenuItem(icon: Icons.today, title: '오늘', count: 0),
                          MenuItem(
                              icon: Icons.calendar_today,
                              title: '예정',
                              count: 27),
                          MenuItem(icon: Icons.list, title: '전체', count: 31),
                          MenuItem(icon: Icons.flag, title: '깃발 표시', count: 1),
                          Divider(color: Colors.white24),
                          MenuItem(icon: Icons.check, title: '완료됨'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 우측 패널
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    '모든 미리 알림이 완료됨',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smartPhoneLayout(
    AppLocalizations localizations,
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
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return LayoutBuilder(builder: (context, constraints) {
      if (_isTablet(constraints)) {
        return tabletLayout(localizations);
      } else {
        return smartPhoneLayout(localizations);
      }
    });
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int? count;

  const MenuItem({required this.icon, required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: count != null
          ? CircleAvatar(
              backgroundColor: Colors.grey[700],
              radius: 12,
              child: Text('$count',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
          : null,
    );
  }
}
