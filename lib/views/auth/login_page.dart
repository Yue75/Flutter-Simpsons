// views/auth/login_page.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await AuthService.login(_usernameController.text, _passwordController.text);
        Navigator.pop(context);
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text('Se connecter')),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text("Pas de compte ? S'inscrire"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
