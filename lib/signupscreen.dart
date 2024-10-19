import 'package:flutter/material.dart';
import 'package:shoreguard/homescreen.dart';
import 'package:shoreguard/widgets/gradient_button.dart';
import 'package:shoreguard/widgets/loginfield.dart';
import 'package:shoreguard/widgets/social_button.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40), // Add some top padding
                  Image.asset(
                    'assets/images/REvan_logo-01.png',
                    height: 250, // Adjust the height as needed
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SocialButton(
                      iconpath: 'assets/svgs/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Loginfield(hintText: 'Name'),
                  const SizedBox(height: 15),
                  const Loginfield(hintText: 'Phone No.'),
                  const SizedBox(height: 15),
                  const Loginfield(hintText: 'Location'),
                  const SizedBox(height: 15),
                  const Loginfield(hintText: 'Email'),
                  const SizedBox(height: 15),
                  const Loginfield(hintText: 'Password'),
                  const SizedBox(height: 20),
                  GradientButton(onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}