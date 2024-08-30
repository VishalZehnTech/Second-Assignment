import 'package:assignment_second/src/modules/Drawer/ui/Custom_InkWell_Widget.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                  height: 180,
                  color: Colors.orange,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 45.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.all_inclusive_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              'Coimbee',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel_presentation_rounded,
                              size: 30,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  )),
            ),
            Positioned(
              top: 110,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomInkWellWidget(
                          titleText: '  VerBeter Suggesties',
                          path: 'assets/images/image-icons/bulb_icon.png',
                        ),
                        CustomInkWellWidget(
                          titleText: 'Mijn acties',
                          path: 'assets/images/image-icons/action_icon.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomInkWellWidget(
                          titleText: 'Moondindicator',
                          path: 'assets/images/image-icons/graph_icon.png',
                        ),
                        CustomInkWellWidget(
                          titleText: 'Score',
                          path: 'assets/images/image-icons/score_icon.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomInkWellWidget(
                          titleText: 'Berichten',
                          path: 'assets/images/image-icons/msgs_icon.png',
                        ),
                        CustomInkWellWidget(
                          titleText: 'Instellingen',
                          path: 'assets/images/image-icons/settings_icon.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
