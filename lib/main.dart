import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haven7_flutterweb/firebase_options.dart';
import 'package:haven7_flutterweb/ui/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const LoginPage());
}

//Platform  Firebase App Id
//web       1:390273009411:web:e758fdb95322b3bf0f8b36

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> signInWithEmailAndPassword() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        _navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => Websitelayout(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Handle errors, e.g., show error messages to the user
        print(e.message);
      }
    }

    return MaterialApp(
      navigatorKey: _navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: signInWithEmailAndPassword,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
