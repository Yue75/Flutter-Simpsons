import 'package:flutter/material.dart';

import 'services/auth_service.dart';
import 'views/admin/admin.dart';
import 'views/auth/login_page.dart';
import 'views/auth/register_page.dart';
import 'views/home.dart';
import 'views/personnage/personnages.dart';
import 'views/saison/saisons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simpsons Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/admin': (context) => AdminPage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _refreshAuthStatus();
  }

  Future<void> _refreshAuthStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    if (mounted) {
      setState(() {
        _isLoggedIn = isLoggedIn;
      });
    }
  }

  final List<Widget> _pages = [
    const Home(),
    const Personnages(),
    const Saisons(),
    const SizedBox(),
  ];

  void _onItemTapped(int index) async {
    if (index == 3) {
      if (_isLoggedIn) {
        await AuthService.logout();
        if (mounted) {
          setState(() {
            _isLoggedIn = false;
          });
        }
      } else {
        await Navigator.pushNamed(context, '/login');
        _refreshAuthStatus();
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text(
                'Accueil',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFFFFD521),
              elevation: 0,
              centerTitle: true,
              actions: [
                if (_isLoggedIn)
                  IconButton(
                    icon: const Icon(Icons.admin_panel_settings,
                        color: Colors.black),
                    onPressed: () => Navigator.pushNamed(context, '/admin'),
                  ),
              ],
            )
          : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Accueil'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Personnages'),
          const BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Saisons'),
          BottomNavigationBarItem(
            icon: Icon(_isLoggedIn ? Icons.logout : Icons.login),
            label: _isLoggedIn ? 'Déconnexion' : 'Connexion',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
