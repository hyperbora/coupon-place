import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final int _tabletWidth = 600;
  final List<String> userFolders = ['쇼핑', '음식', '식당', '취미'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= _tabletWidth;
  }

  Widget _searchField() {
    return Padding(
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
          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _menuList() {
    return Expanded(
      child: ListView(
        children: [
          MenuItem(icon: Icons.list, title: '전체', count: 0),
          MenuItem(icon: Icons.access_time, title: '만료 임박', count: 0),
          MenuItem(icon: Icons.check_circle_outline, title: '사용한 쿠폰', count: 0),
          MenuItem(icon: Icons.favorite, title: '즐겨찾기', count: 0),
          Divider(color: Colors.white24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('내 폴더',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
          ),
          ...userFolders
              .map((folder) => MenuItem(icon: Icons.folder, title: folder))
              .toList(),
        ],
      ),
    );
  }

  Widget _bottomMenu() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 폴더 추가 버튼 (아이콘 + 텍스트)
          Expanded(
            child: ListTile(
              leading: Icon(Icons.add, color: Colors.white),
              title: Text('폴더 추가', style: TextStyle(color: Colors.white)),
              onTap: () {
                // 폴더 추가 화면으로 이동하는 로직
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('폴더 추가'),
                      content: TextField(
                        decoration: InputDecoration(hintText: '새 폴더 이름'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // 폴더 추가 로직
                            Navigator.pop(context);
                          },
                          child: Text('확인'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('취소'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // 설정 화면으로 이동하는 로직
            },
            icon: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _sidePanel() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        children: [
          _searchField(),
          _menuList(),
          _bottomMenu(),
        ],
      ),
    );
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
              child: _sidePanel(),
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
    return SafeArea(
      child: Scaffold(
        body: _sidePanel(),
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
