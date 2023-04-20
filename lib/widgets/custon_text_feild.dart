import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({required this.labelText , this.onChange , this.obSecure = false});

  String? labelText;
  bool? obSecure;
  Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data)
      {
        if(data!.isEmpty)
          {
            return 'Field required';
          }
      },
      obscureText: obSecure!,
      onChanged: onChange,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        label: Text(
          labelText!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

      ),
    );
  }
}
