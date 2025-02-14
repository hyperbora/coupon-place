import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/menu_item.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final int _tabletWidth = 600;
  final List<String> userFolders = [];

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= _tabletWidth;
  }

  Widget _searchField() {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: localizations.searchHint,
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon:
              Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
        ),
        style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
    );
  }

  Widget _menuList() {
    final localizations = AppLocalizations.of(context)!;
    return Expanded(
      child: ListView(
        children: [
          MenuItem(
              icon: Icons.list, title: localizations.menuAllCoupons, count: 0),
          MenuItem(
              icon: Icons.access_time,
              title: localizations.menuExpiringSoon,
              count: 0),
          MenuItem(
              icon: Icons.check_circle_outline,
              title: localizations.menuUsedCoupons,
              count: 0),
          MenuItem(
              icon: Icons.favorite,
              title: localizations.menuFavorites,
              count: 0),
          Divider(color: Theme.of(context).dividerColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(localizations.myFolder,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 14)),
          ),
          ...userFolders
              .map((folder) => MenuItem(icon: Icons.folder, title: folder)),
        ],
      ),
    );
  }

  Widget _bottomMenu() {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Divider(color: Theme.of(context).dividerColor),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.add,
                        color: Theme.of(context).iconTheme.color),
                    title: Text(localizations.addFolder,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(localizations.addFolder,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color)),
                            content: TextField(
                              decoration: InputDecoration(
                                  hintText: localizations.newFolderNameHint),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(localizations.cancel),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(localizations.confirm),
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
                  icon: Icon(Icons.settings,
                      color: Theme.of(context).iconTheme.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidePanel() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          _searchField(),
          _menuList(),
          _bottomMenu(),
        ],
      ),
    );
  }

  Widget tabletLayout() {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: _sidePanel(),
            ),
            VerticalDivider(
              color: Theme.of(context).dividerColor,
              width: 1,
              thickness: 1,
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    localizations.list,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget smartPhoneLayout() {
    return SafeArea(
      child: Scaffold(
        body: _sidePanel(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (_isTablet(constraints)) {
        return tabletLayout();
      } else {
        return smartPhoneLayout();
      }
    });
  }
}
