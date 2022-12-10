import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:um_mobile/component/custom_navbar_style.dart';
import 'package:um_mobile/component/keep_page_alive.dart';
import 'package:um_mobile/page/absen_element.dart';
import 'package:um_mobile/page/home_element.dart';
import 'package:um_mobile/page/jadwal_element.dart';
import 'package:um_mobile/page/login_page.dart';
import 'package:um_mobile/page/neraca_element.dart';
import 'package:um_mobile/page/profile_element.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //make material color from #A10302
    final MaterialColor primaryColor = const MaterialColor(
      0xFFA10302,
      const <int, Color>{
        50: const Color(0xFFA10302),
        100: const Color(0xFFA10302),
        200: const Color(0xFFA10302),
        300: const Color(0xFFA10302),
        400: const Color(0xFFA10302),
        500: const Color(0xFFA10302),
        600: const Color(0xFFA10302),
        700: const Color(0xFFA10302),
        800: const Color(0xFFA10302),
        900: const Color(0xFFA10302),
      },
    );
    return MaterialApp(
      title: 'SIAM Mobile',
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyBottomNavBar(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  final PageController _pageController = PageController();
  int indexTitle = 0;
  List<String> titles = [
    "Home",
    "Jadwal",
    "Absen",
    "Neraca",
    "Profile",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(6),
            child: Image.asset(
              'assets/images/logo_um.png',
            ),
          ),
          title: Transform.translate(
            offset: Offset(-38, 0),
            child: Center(
              child: Text("${titles[indexTitle]}"),
            ),
          ),
        ),
        body: PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: _pageController,
          children: <Widget>[
            KeepAlivePage(child: HomeElement()),
            KeepAlivePage(child: JadwalElement()),
            KeepAlivePage(child: AbsenElement()),
            KeepAlivePage(child: NeracaElement()),
            KeepAlivePage(child: ProfileElement()),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.schedule, title: 'Jadwal'),
            TabItem(icon: Icons.camera_alt, title: 'Absen'),
            TabItem(icon: Icons.attach_money, title: 'Neraca'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          onTap: (int i) {
            setState(() {
              indexTitle = i;
            });
            _pageController.jumpToPage(i);
          },
        ));
  }
}
