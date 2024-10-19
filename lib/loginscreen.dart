import 'package:flutter/material.dart';
import 'package:shoreguard/widgets/gradient_button.dart';
import 'package:shoreguard/widgets/loginfield.dart';
import 'package:shoreguard/widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40), // Add some top padding
                Image.asset(
                  'assets/Image.jpg',
                  height: 200, // Adjust the height as needed
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 20),
                const SocialButton(
                    iconpath: 'assets/google.jpeg',
                    label: 'Continue with Google'),
                const SizedBox(height: 15),
                const Text(
                  'or',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 15),
                const Loginfield(hintText: 'Email'),
                const SizedBox(height: 15),
                const Loginfield(hintText: 'Password'),
                const SizedBox(height: 20),
                const GradientButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}