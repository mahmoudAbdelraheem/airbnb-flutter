import 'package:airbnb_flutter/core/functions/show_custom_snake_bar.dart';
import 'package:airbnb_flutter/core/widgets/custom_button.dart';
import 'package:airbnb_flutter/core/widgets/custom_text_form_field.dart';
import 'package:airbnb_flutter/core/widgets/loading.dart';
import 'package:airbnb_flutter/data/models/user_model.dart';
import 'package:airbnb_flutter/logic/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController preferredNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emergencyContactController = TextEditingController();
  TextEditingController governmentIDController = TextEditingController();
  TextEditingController phoneNumbersController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    displayNameController.dispose();
    preferredNameController.dispose();
    addressController.dispose();
    emailController.dispose();
    emergencyContactController.dispose();
    governmentIDController.dispose();
    phoneNumbersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        title: const Text('Pesonal Info'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state is HomeCurrentUserState &&
            state.user != null &&
            state.userModel != null) {
          nameController.text = state.userModel!.name;
          displayNameController.text = state.userModel!.displayName ?? '';
          preferredNameController.text = state.userModel!.preferredName ?? '';
          addressController.text = state.userModel!.address ?? '';
          emailController.text = state.userModel!.email;
          emergencyContactController.text =
              state.userModel!.emergencyContact ?? '';
          governmentIDController.text = state.userModel!.governmentId ?? '';
          phoneNumbersController.text = state.userModel!.phoneNumber ?? '';
        } else if (state is HomeUserDataSaveSuccessState) {
          showCustomSnakeBar(
            context: context,
            message: 'Your data saved successfully',
          );
        } else if (state is HomeErrorState) {
          showCustomSnakeBar(
            context: context,
            message: state.error,
          );
        }
      }, builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.all(15),
          children: [
            CustomTextFormField(
              labelText: 'name',
              myValidator: (value) {
                return null;
              },
              myController: nameController,
              sufixIcon: Icons.person,
            ),
            CustomTextFormField(
              labelText: 'preferred name',
              myValidator: (value) {
                return null;
              },
              myController: preferredNameController,
              sufixIcon: Icons.person,
            ),
            CustomTextFormField(
              labelText: 'display name',
              myValidator: (value) {
                return null;
              },
              myController: displayNameController,
              sufixIcon: Icons.person,
            ),
            CustomTextFormField(
              labelText: 'address',
              myValidator: (value) {
                return null;
              },
              myController: addressController,
              sufixIcon: Icons.home_rounded,
            ),
            CustomTextFormField(
              labelText: 'emergency contact',
              myValidator: (value) {
                return null;
              },
              myController: emergencyContactController,
              myKeyboardType: TextInputType.phone,
              sufixIcon: Icons.emergency_rounded,
            ),
            CustomTextFormField(
              labelText: 'phone number',
              myValidator: (value) {
                return null;
              },
              myKeyboardType: TextInputType.phone,
              myController: phoneNumbersController,
              sufixIcon: Icons.phone_android_rounded,
            ),
            CustomTextFormField(
              labelText: 'government ID',
              myValidator: (value) {
                return null;
              },
              myKeyboardType: TextInputType.number,
              myController: governmentIDController,
              sufixIcon: Icons.policy,
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return state is HomeLoadingState
                    ? const Loading()
                    : CustomButton(
                        text: 'Save',
                        onTap: () {
                          UserModel userData = UserModel(
                            id: context.read<HomeBloc>().user!.uid,
                            name: nameController.text,
                            email: emailController.text,
                            favoriteIds:
                                context.read<HomeBloc>().userModel!.favoriteIds,
                            preferredName: preferredNameController.text,
                            displayName: displayNameController.text,
                            emergencyContact: emergencyContactController.text,
                            governmentId: governmentIDController.text,
                            phoneNumber: phoneNumbersController.text,
                            address: addressController.text,
                            image: context.read<HomeBloc>().userModel!.image,
                          );

                          context.read<HomeBloc>().add(
                                SaveUserDataEvent(
                                  userModel: userData,
                                ),
                              );
                        },
                      );
              },
            ),
          ],
        );
      }),
    );
  }
}
