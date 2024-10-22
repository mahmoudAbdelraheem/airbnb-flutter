import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/custom_text_form_field.dart';
import 'package:airbnb_flutter/presentation/widgets/auth/custom_auth_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20).copyWith(top: 50),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Log in or sign up to Airbnb',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              sufixIcon: Icons.person_outlined,
              labelText: 'Name',
              myController: _nameController,
              myValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              myKeyboardType: TextInputType.text,
            ),
            CustomTextFormField(
              sufixIcon: Icons.email_outlined,
              labelText: 'Email',
              myController: _emailController,
              myValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              myKeyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              isPassword: _isObscure,
              sufixIcon: _isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              showPassword: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              labelText: 'Passwrod',
              myController: _passwordController,
              myValidator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              myKeyboardType: TextInputType.visiblePassword,
            ),
            CustomButton(
              text: 'Sign up',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  //TODO: login using email and password
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppConstants.loginScreen,
                    );
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: screenSize.width * 0.35,
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                Container(
                  width: screenSize.width * 0.15,
                  alignment: Alignment.center,
                  child: const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width * 0.35,
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
            CustomAuthButton(
              imagePath: 'assets/images/google_icon.png',
              bottonText: 'Continue with Google',
              onPressed: () {
                //TODO: login with google account
              },
            ),
            CustomAuthButton(
              imagePath: 'assets/images/github.png',
              bottonText: 'Continue with Github',
              onPressed: () {
                //TODO: login with github account
              },
            ),
          ],
        ),
      ),
    );
  }
}
