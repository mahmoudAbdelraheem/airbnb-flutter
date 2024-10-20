import 'package:airbnb_flutter/presentation/screens/authentication/login_screen.dart';
import 'package:airbnb_flutter/presentation/widgets/round_gradient_button.dart';
import 'package:airbnb_flutter/presentation/widgets/round_text_field.dart';
import 'package:airbnb_flutter/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isObscure = true;
  bool _isCheck = false;
  final _formKey = GlobalKey<FormState>();

  // Future<User?> _signIn(
  //     BuildContext context, String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     User? user = userCredential.user;

  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     return user;
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Invalid email or password!')));
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.height * 0.1,
                ),
                SizedBox(
                  width: media.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.width * 0.03,
                      ),
                      Text(
                        'Hello Hello!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: media.width * 0.01,
                      ),
                      Text(
                        'Create a new account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                RoundTextField(
                  textEditingController: _firstNameController,
                  hintText: 'Enter your first name',
                  icon: "assets/images/person_icon.png",
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                RoundTextField(
                  textEditingController: _lastNameController,
                  hintText: 'Enter your last name',
                  icon: "assets/images/person_icon.png",
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                RoundTextField(
                  textEditingController: _emailController,
                  hintText: 'Email',
                  icon: "assets/images/message_icon.png",
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                RoundTextField(
                  textEditingController: _passController,
                  hintText: 'Password',
                  icon: "assets/images/lock.png",
                  textInputType: TextInputType.text,
                  isObsecureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  rightIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        _isObscure
                            ? "assets/images/visibility.png"
                            : "assets/images/visibility_off.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isCheck = !_isCheck;
                          });
                        },
                        icon: Icon(
                          _isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          color: AppColors.grayColor,
                        )),
                    Expanded(
                        child: Text(
                      'Agree to terms and services',
                      style:
                          TextStyle(color: AppColors.grayColor, fontSize: 10),
                    ))
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                            color: AppColors.secondaryColor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundGradientButton(
                    title: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_isCheck) {
                          try {
                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passController.text);

                            String uid = userCredential.user!.uid;

                            await _users.doc(uid).set({
                              'firstName': _firstNameController.text,
                              'lastName': _lastNameController.text,
                              'email': _emailController.text,
                            });

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Successfully Registered!')));

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        }
                      }
                    }),
                SizedBox(
                  height: media.width * 0.01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: 1,
                        color: AppColors.grayColor.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      'Or',
                      style: TextStyle(
                        color: AppColors.grayColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: 1,
                        color: AppColors.grayColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.5),
                                  width: 1)),
                          child: Image.asset(
                            'assets/images/google_icon.png',
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.5),
                                  width: 1)),
                          child: Image.asset(
                            'assets/images/google_icon.png',
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(text: 'Already have an account?'),
                            TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                    color: AppColors.secondaryColor1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400))
                          ]),
                    ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
