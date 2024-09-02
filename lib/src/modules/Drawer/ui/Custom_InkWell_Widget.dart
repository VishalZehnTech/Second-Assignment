import 'package:flutter/material.dart';

// A reusable InkWell widget that provides a tappable card with an image and text.
// When tapped, it navigates to a specified destination widget if provided.
class CustomInkWellWidget extends StatelessWidget {
  const CustomInkWellWidget({
    super.key,
    required this.titleText,
    required this.path,
    this.onTapDestination,
  });

  // The text to display below the image in the card.
  final String titleText;

  // The path to the image asset to display in the card.
  final String path;

  // The widget to navigate to when the card is tapped. If null, no navigation occurs.
  final Widget? onTapDestination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // If a destination widget is provided, navigate to it when the card is tapped.
        if (onTapDestination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => onTapDestination!,
            ),
          );
        }
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 4.0, // Adds a shadow effect to the card.
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adds padding inside the card.
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centers content vertically.
            children: [
              // Displays the image asset with a fixed width and height.
              Image.asset(path, width: 60, height: 60),
              const SizedBox(
                  height: 10), // Adds space between the image and the text.
              // Displays the title text below the image, centered.
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
