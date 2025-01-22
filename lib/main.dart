import 'package:coupon_place/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? flavor =
      await const MethodChannel('flavor').invokeMethod<String>('getFlavor');
  FlavorConfig.setFlavor(flavor!);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''),
      ],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('My Coupons')),
    Center(child: Text('Add Coupon')),
    Center(child: Text('Expiring Soon')),
    Center(child: Text('Settings')),
  ];

  static const List<String> _titles = <String>[
    'My Coupons',
    'Add Coupon',
    'Expiring Soon',
    'Settings',
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_offer),
            label: localizations.myCoupons,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: localizations.addCoupon,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_time),
            label: localizations.expiringSoon,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
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
