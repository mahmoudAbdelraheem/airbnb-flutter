import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/custom_text_form_field.dart';
import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/logic/auth/auth_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/auth/custom_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedInState ||
              state is AuthLoggedInWithGoogleState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Form(
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
                        } else if (value.contains('@') == false) {
                          return 'Invalid email';
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
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      myKeyboardType: TextInputType.visiblePassword,
                    ),
                    CustomButton(
                      text: 'Log in',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthLoginEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
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
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginGoogleEvent(),
                        );
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
              state is AuthLoadingState
                  ? Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      color: Colors.black45,
                      child: const Loading())
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
