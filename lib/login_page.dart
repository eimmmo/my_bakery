import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    print("LoginPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("LoginPage: didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    print("LoginPage: build");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bakery_dining, size: 90, color: Colors.brown.shade700),
            const SizedBox(height: 12),
            Text(
              "My Bakery",
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 4),
            const Text("Fresh bread, cakes and pastries"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/products', arguments: "Guest");

                context.goNamed('products', queryParameters: {'user': 'Guest'});
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    print("LoginPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("LoginPage: dispose");
    super.dispose();
  }
}