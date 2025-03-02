import 'package:coupon_place/constants.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/menu_item.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<String> userFolders = [];

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= AppConstants.tabletWidthThreshold;
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
                    leading: TextButton.icon(
                      icon: Icon(Icons.add_circle,
                          color: Theme.of(context).iconTheme.color),
                      label: Text(
                        localizations.addFolder,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color),
                      ),
                      onPressed: () {
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
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text(
                        localizations.addCoupon,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
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
          _topBar(),
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
