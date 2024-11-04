import 'package:airbnb_flutter/core/constants/app_constants.dart';
import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:airbnb_flutter/presentation/widgets/profile/log_out_widget.dart';
import 'package:airbnb_flutter/presentation/widgets/profile/profile_bottons_bar.dart';
import 'package:airbnb_flutter/presentation/widgets/screens_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLogoutSuccessState) {
          Navigator.pushReplacementNamed(
            context,
            AppConstants.homeScreen,
          );
        } else if (state is HomeErrorState) {
          showCustomSnakeBar(
            context: context,
            message: 'something went wrong! please try agin.',
          );
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const SizedBox(height: 20),
          if (homeBloc.user == null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ScreensHeader(
                  mainTitle: 'Your Profile',
                  title: "",
                  subtitle: "Log in to start planning your next trip.",
                  btnWidth: double.infinity,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('don\'t have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppConstants.registerScreen);
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          if (homeBloc.user != null)
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppConstants.pesonalInfoScreen,
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(15),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        size: 60,
                        Icons.person_2_outlined,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Info',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Wrap(
                            children: [
                              Text(
                                'Provide personal details\nand how we can reach you.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const SizedBox(height: 20),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.settings_outlined,
            lable: 'Setting',
          ),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.accessibility_new_outlined,
            lable: 'Accessibility',
          ),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.help_outline,
            lable: 'Get Help',
          ),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.menu_book_rounded,
            lable: 'Terms of Service',
          ),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.menu_book_rounded,
            lable: 'Privacy Policy',
          ),
          ProfileBottonsBar(
            onPressed: () {},
            prefixIcon: Icons.menu_book_rounded,
            lable: 'Open Source Licenses',
          ),
          LogOutWidget(
            onPressed: () {
              homeBloc.add(
                HomeLogoutEvent(),
              );
            },
          ),
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   AppConstants.homeScreen,
          //   (route) => false,
          // );
          const Text(
            'Version 1.0.0',
          ),
        ],
      ),
    );
  }
}
