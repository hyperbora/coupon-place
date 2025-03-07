import 'package:coupon_place/constants.dart';
import 'package:coupon_place/data/database.dart';
import 'package:coupon_place/repository/folder_repository.dart';
import 'package:coupon_place/models/folder.dart' as model;
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
  late final AppDatabase appDatabase = AppDatabase();
  late final FolderRepository folderRepository =
      FolderRepository(appDatabase: appDatabase);
  final TextEditingController _folderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (_isTablet(constraints)) {
        return _tabletLayout();
      } else {
        return _smartPhoneLayout();
      }
    });
  }

  bool _isTablet(BoxConstraints constraints) {
    return constraints.maxWidth >= AppConstants.tabletWidthThreshold;
  }

  Widget _tabletLayout() {
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

  Widget _smartPhoneLayout() {
    return SafeArea(
      child: Scaffold(
        body: _sidePanel(),
      ),
    );
  }

  Widget _sidePanel() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          _topBar(),
          _searchField(),
          _menuList(),
          Flexible(child: _folderList()),
          _bottomMenu(),
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
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
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
            icon: Icons.favorite, title: localizations.menuFavorites, count: 0),
        MenuItem(
            icon: Icons.delete_outline,
            title: localizations.menuRecentlyDeleted,
            count: 0),
      ],
    );
  }

  Widget _folderList() {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: Theme.of(context).dividerColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            localizations.myFolder,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<model.Folder>>(
            stream: folderRepository.watchFolders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SizedBox.shrink();
              }

              List<model.Folder> folders = snapshot.data!;

              return ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  final List<model.Folder> reorderedFolders =
                      List.from(folders);
                  final movedFolder = reorderedFolders.removeAt(oldIndex);
                  reorderedFolders.insert(newIndex, movedFolder);

                  folderRepository.updateFolderOrder(reorderedFolders);
                },
                children: List.generate(
                  folders.length,
                  (index) {
                    final folder = folders[index];
                    return MenuItem(
                      key: ValueKey(folder.id),
                      icon: Icons.folder,
                      title: folder.name,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _bottomMenu() {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Theme.of(context).dividerColor),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: TextButton.icon(
                    icon: Icon(Icons.add_circle,
                        color: Theme.of(context).iconTheme.color),
                    label: Text(
                      localizations.addFolder,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color),
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
                              controller: _folderNameController,
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
                                onPressed: () {
                                  final folderName = _folderNameController.text;
                                  if (folderName.isEmpty) {
                                    return;
                                  }
                                  folderRepository.insertFolder(
                                      model.Folder.fromMap(
                                          {'name': folderName}));
                                  setState(() {
                                    userFolders.add(folderName);
                                    _folderNameController.clear();
                                  });
                                  Navigator.pop(context);
                                },
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
    );
  }
}
