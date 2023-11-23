import 'package:convo/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_button.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({Key? key, this.onTap}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "Welcome to Convo!",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(
                  onTap: signIn,
                  text: 'Login',
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}