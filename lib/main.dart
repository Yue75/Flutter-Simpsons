import 'package:flutter/material.dart';

import 'services/auth_service.dart';
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
    _isLoggedIn = AuthService.isLoggedIn();
  }

  final List<Widget> _pages = [
    const Home(),
    const Personnages(),
    const Saisons(),
    const SizedBox(),
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      if (_isLoggedIn) {
        // Déconnexion
        AuthService.logout().then((_) {
          setState(() {
            _isLoggedIn = false;
          });
        });
      } else {
        // Navigation vers la page de connexion
        Navigator.pushNamed(context, '/login').then((_) {
          // Mise à jour de l'état de connexion au retour
          setState(() {
            _isLoggedIn = AuthService.isLoggedIn();
          });
        });
      }
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Accueil'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personnages',
          ),
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
