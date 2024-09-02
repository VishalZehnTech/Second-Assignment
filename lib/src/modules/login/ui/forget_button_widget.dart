import 'package:flutter/material.dart';

// A widget representing a "Forget Password" link
class ForgetButtonWidget extends StatelessWidget {
  const ForgetButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.end, // Aligns the widget to the end of the row
      children: [
        InkWell(
          onTap: () {},
          child: const Text(
            "Forget Password",
            style: TextStyle(
              decoration: TextDecoration.underline, // Underlines the text
              decorationColor: Colors.deepPurple, // Color of the underline
              decorationThickness: 2, // Thickness of the underline
              color: Colors.deepPurpleAccent, // Color of the text
            ),
          ),
        ),
      ],
    );
  }
}
