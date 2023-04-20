import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, required this.onTap});

  String? text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: double.maxFinite,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(16.0)),
          ),
          child: Text(
            text!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
