import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String validSegament;
  Icon icon;
  TextEditingController controller;
  TextFieldWidget(this.validSegament, this.icon, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(
        vertical: 7,
      ),
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(3)),
      child: Row(
        children: [
          Container(
            width: 330,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null) {
                  return 'please enter $validSegament';
                }
              },
              cursorHeight: 30,
              cursorColor: Color.fromARGB(255, 57, 57, 57),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: icon,
                  labelText: validSegament,
                  focusColor: Color.fromARGB(255, 57, 57, 57)),
            ),
          ),
        ],
      ),
    );
  }
}
