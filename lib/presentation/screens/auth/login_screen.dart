import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/custom_text_form_field.dart';
import 'package:airbnb_flutter/presentation/widgets/auth/custom_auth_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
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
              text: 'Log in',
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
                  'Don\'t have an account?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppConstants.registerScreen,
                    );
                  },
                  child: const Text(
                    'Sign up',
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
              children: [
                Container(
                  width: screenSize.width * 0.4,
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('OR'),
                ),
                Container(
                  width: screenSize.width * 0.4,
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
