import 'package:assignment_second/src/modules/Drawer/ui/Custom_InkWell_Widget.dart';
import 'package:assignment_second/src/modules/verbersuggesties/ui/verbeter_suggesties_screen.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // Number of grid columns, initially set to 2.
  int crossAxisCount = 2;

  // List of titles for each grid item.
  List titleText = [
    "Verbeter- \nsuggesties",
    "Mijn acties",
    "Moondindicator",
    "Scores",
    "Berichten",
    "Instellingen",
  ];

  // List of image paths for each grid item.
  List pathText = [
    "assets/images/image-icons/bulb_icon.png",
    "assets/images/image-icons/action_icon.png",
    "assets/images/image-icons/graph_icon.png",
    "assets/images/image-icons/score_icon.png",
    "assets/images/image-icons/msgs_icon.png",
    "assets/images/image-icons/settings_icon.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Positioned widget for the header section with an orange background.
            Positioned(
              child: Container(
                height: 190,
                color: Colors.orange,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Coimbee logo with text in the header.
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Icon(Icons.all_inclusive_rounded,
                                color: Colors.white, size: 35),
                            Text('Coimbee',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white))
                          ],
                        ),
                      ),
                      // Close button to exit the drawer.
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Positioned widget for the grid of options, starting below the header.
            Positioned(
              top: 120,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // Dynamic number of columns.
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10.0, // Space between columns.
                        mainAxisSpacing: 10.0, // Space between rows.
                      ),

                      // Number of grid items.
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        // Adjust the number of columns based on screen width.
                        double screenWidth = MediaQuery.of(context).size.width;
                        crossAxisCount = (screenWidth / 200).floor();
                        return CustomInkWellWidget(
                          titleText:
                              titleText.elementAt(index), // Grid item title.
                          path: pathText.elementAt(index), // Grid item image.
                          onTapDestination:
                              const VerbeterSuggestiesPage(), // Destination page on tap.
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
