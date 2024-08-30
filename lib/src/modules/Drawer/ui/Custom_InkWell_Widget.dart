// ignore_for_file: file_names

import 'package:assignment_second/src/modules/verbersuggesties/ui/verbeter_suggesties_screen.dart'
    show VerbeterSuggestiesPage;
import 'package:flutter/material.dart';

class CustomInkWellWidget extends StatelessWidget {
  const CustomInkWellWidget(
      // String title,
      // String path,
      {
    super.key,
    required this.titleText,
    required this.path,
  });
  final String titleText;
  final String path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerbeterSuggestiesPage(),
          ),
        );
      },
      child: SizedBox(
        height: 170,
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0), //
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(path, width: 50, height: 50),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    titleText,
                    // style: const TextStyle(
                    //     fontWeight: FontWeight.bold, fontSize: 14)
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
