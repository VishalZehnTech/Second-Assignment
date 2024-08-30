import 'package:assignment_second/src/modules/Drawer/ui/Drawer_Page.dart';
import 'package:assignment_second/src/modules/home/bloc/home_bloc.dart';
import 'package:assignment_second/src/modules/home/model/Home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchUserList());
  }

  TextStyle _cardTextSmallStyle() {
    return const TextStyle(
      fontSize: 15,
      color: Color.fromARGB(255, 66, 63, 63),
    );
  }

  TextStyle _cardTextBoldStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build");

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              alignment: Alignment.topLeft,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DrawerPage(),
                                ));
                          },
                          icon: const Icon(Icons.menu),
                          iconSize: 35,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notification_add),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Team Details",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _decorateTextBottomBorder(
                            titleName: "VerbeterSuggesties"),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_circle,
                            size: 35,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  /*
                  Container(
                    decoration: _applyCardStyle(),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is UserListLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is UserListLoaded) {
                          final userList = state.homeModel.data;
                          final user = userList[0];
                          return Column(
                            children: [
                              UserListDetailsWidget(user: user),
                              userInfromationContainer()
                            ],
                          );
                        }
                        return const Text("SomeThing Want Wrong");
                      },
                    ),
                  ),
                  */

                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is UserListLoaded) {
                        final userList = state.homeModel.data;
                        return Container(
                          decoration: _applyCardStyle(),
                          child: Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: userList.length,
                                itemBuilder: (context, index, realIndex) {
                                  final user = userList[index];
                                  return Column(
                                    children: [
                                      UserListDetailsWidget(user: user),
                                      userInfromationContainer(),
                                    ],
                                  );
                                },
                                options: CarouselOptions(
                                  height: 280.0,
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                    child: _decorateTextBottomBorder(titleName: "Score"),
                  ),
                  Container(
                    decoration: _applyCardStyle(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                  'assets/images/image-icons/score_icon.png',
                                  width: 50,
                                  height: 50),
                              const Text(
                                "65",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.orange,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            " Goed Bezig, #1Emma Green",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 15),
                    child:
                        _decorateTextBottomBorder(titleName: "Moodindicator"),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: _applyCardStyle(),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hoeveel plezier heb je momenteel \nin je werk? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.keyboard_arrow_left_outlined,
                                  size: 20),
                              _commonEmojiColumnAsset(
                                  imagePath: "assets/images/emoji/06.png",
                                  emojiNumber: "6"),
                              _commonEmojiColumnAsset(
                                  imagePath: "assets/images/emoji/07.png",
                                  emojiNumber: "7"),
                              _commonEmojiColumnAsset(
                                  imagePath: "assets/images/emoji/08.png",
                                  emojiNumber: "8"),
                              _commonEmojiColumnAsset(
                                  imagePath: "assets/images/emoji/09.png",
                                  emojiNumber: "9"),
                              _commonEmojiColumnAsset(
                                  imagePath: "assets/images/emoji/10.png",
                                  emojiNumber: "10"),
                              const Icon(Icons.keyboard_arrow_right_outlined,
                                  size: 20),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _commonEmojiColumnAsset(
      {required String imagePath, required String emojiNumber}) {
    return Column(
      children: [
        Image.asset(imagePath, width: 45, height: 50),
        Text(emojiNumber),
      ],
    );
  }

  Container _decorateTextBottomBorder({required String titleName}) {
    return Container(
      decoration: _decorateWithBottomBorder(),
      child: Text(
        titleName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Container userInfromationContainer() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date", style: _cardTextSmallStyle()),
                  Text("01-02-2012", style: _cardTextBoldStyle()),
                ],
              ),
              const SizedBox(width: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Date", style: _cardTextSmallStyle()),
                  Text("11-02-2012", style: _cardTextBoldStyle()),
                ],
              )
            ],
          ),
          const SizedBox(height: 11),
          Row(
            children: [
              Text("Status", style: _cardTextSmallStyle()),
              const SizedBox(width: 45),
              Text("Lopend", style: _cardTextBoldStyle()),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("OK Status", style: _cardTextSmallStyle()),
              const SizedBox(width: 20),
              Text("IN Order", style: _cardTextBoldStyle()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Analyseer lange doorlooptijd",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 30,
                  ))
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration _decorateWithBottomBorder() {
    return const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 3,
          color: Colors.blue,
        ),
      ),
    );
  }

  BoxDecoration _applyCardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
        ),
      ],
    );
  }
}

class UserListDetailsWidget extends StatelessWidget {
  const UserListDetailsWidget({
    super.key,
    required this.user,
  });

  final Datum user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 6),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text(
          user.email,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        subtitle: Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.blue,
              border: Border.all(width: 2, color: Colors.white)),
          child: const Icon(
            Icons.done,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
