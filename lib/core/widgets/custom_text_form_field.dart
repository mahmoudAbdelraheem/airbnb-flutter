import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final IconData sufixIcon;
  final String? Function(String?) myValidator;
  final TextEditingController myController;
  final TextInputType myKeyboardType;
  final void Function()? showPassword;
  final bool? isPassword;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.myValidator,
    required this.myController,
    required this.sufixIcon,
    this.myKeyboardType = TextInputType.text,
    this.showPassword,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        cursorColor: Colors.pink[500],
        validator: myValidator,
        keyboardType: myKeyboardType,
        controller: myController,
        obscureText: isPassword!,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              labelText,
              style: TextStyle(color: Colors.pink[500]),
            ),
          ),
          suffixIcon: InkWell(
            onTap: showPassword,
            child: Icon(
              sufixIcon,
              color: Colors.pink[500],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
