import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({this.hintText,this.onChangerd,this.obscureText=false});
  String? hintText;
  Function(String)? onChangerd;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
      },
      onChanged: onChangerd,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}
