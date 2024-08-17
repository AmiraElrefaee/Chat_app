

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  CustomTextFormFiled({super.key,required this.hint,required this.onChanged,required this.obscure});
  String ?hint;
Function (String)? onChanged;
bool obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10),
      child: TextFormField(
        obscureText: obscure,
        validator: (data){

          if(data!.isEmpty){
            return 'field is require' ;

          }
        },

         onChanged: onChanged,
        style: TextStyle(
            fontSize: 25
        ),
        decoration: InputDecoration(
          hintText:hint,

          focusedBorder: OutlineInputBorder(

              borderSide: BorderSide(



              )
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //
          //       color: Colors.black,
          //       width: 2
          //   ),
          //
          // ),

        ),
      ),
    );
  }
}
