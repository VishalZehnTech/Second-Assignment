import 'package:assignment_second/src/modules/verbersuggesties/bloc/verber_bloc.dart';
import 'package:assignment_second/src/modules/verbersuggesties/bloc/verber_state.dart';
import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerbeterSuggestiesPage extends StatefulWidget {
  const VerbeterSuggestiesPage({super.key});

  @override
  State<VerbeterSuggestiesPage> createState() => _VerbeterSuggestiesPageState();
}

class _VerbeterSuggestiesPageState extends State<VerbeterSuggestiesPage> {
  final ScrollController _scrollController = ScrollController();
  bool _hasMoreData = true;
  Set<MaterialColor> colorName = {
    Colors.orange,
    Colors.blue,
    Colors.green,
  };

  Set<IconData> iconsName = {
    Icons.circle_outlined,
    Icons.rounded_corner_sharp,
    Icons.check_circle_outline_rounded
  };
  @override
  void initState() {
    super.initState();
    context.read<VerberBloc>().add(FetchUsers());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _hasMoreData) {
        Future.delayed(const Duration(seconds: 1), () {
          // ignore: use_build_context_synchronously
          context.read<VerberBloc>().add(FetchUsers());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 180,
            alignment: Alignment.topLeft,
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _commonIconButton(iconsName: Icons.menu),
                      SizedBox(
                        child: Row(
                          children: [
                            _commonIconButton(iconsName: Icons.search),
                            _commonIconButton(
                                iconsName: Icons.equalizer_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    ' Vebetersuggesties',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40, top: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _createStatusIndicatorRow(
                  titleText: "Open",
                  iconsName: Icons.circle_outlined,
                  colorName: Colors.orange,
                ),
                _createStatusIndicatorRow(
                  titleText: "Loopt",
                  iconsName: Icons.rounded_corner_sharp,
                  colorName: Colors.blue,
                ),
                _createStatusIndicatorRow(
                  titleText: "Gereed",
                  iconsName: Icons.check_circle_outline_rounded,
                  colorName: Colors.green,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<VerberBloc, VerberState>(
              builder: (context, state) {
                if (state is VerberLoaded) {
                  _hasMoreData = state.isMoreData;
                  List<Datum> userList = state.newUserList;

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 15),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: userList.length + 1,
                      itemBuilder: (context, index) {
                        if (index < userList.length) {
                          final user = userList[index];
                          return Card(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListTile(
                                    
                                    leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user.avatar)),
                                    title: Text(user.email,
                                        style: _commonTextStyleForUser()
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    subtitle: Text(
                                      "${user.firstName} ${user.lastName}",
                                      style: _commonTextStyleForUser(),
                                    ),
                                  ),
                                ),
                                userInformationWidget(index: index),
                              ],
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: !_hasMoreData
                                    ? const Text("No More Data")
                                    : const CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return const Text("");
                  //const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add),
      ),
    );
  }

  IconButton _commonIconButton({required IconData iconsName}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        iconsName,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  TextStyle _commonTextStyleForUser() {
    return const TextStyle(
      color: Colors.white,
    );
  }

  Container userInformationWidget({required int index}) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Start Date", style: _cardTextSmallStyle()),
                  Text("01-02-2012       ", style: _cardTextBoldStyle()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("End Date", style: _cardTextSmallStyle()),
                  Text("11-02-2012", style: _cardTextBoldStyle()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(
                      color: Colors.grey, style: BorderStyle.solid))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.thumb_up_alt, size: 30),
                    const SizedBox(width: 20),
                    const Icon(Icons.share_sharp, size: 30),
                    const SizedBox(width: 20),
                    const Icon(Icons.supervised_user_circle, size: 30),
                    const SizedBox(width: 20),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.message_outlined, size: 30)),
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more,
                          size: 30,
                        )),
                  ],
                ),
                Icon(
                  iconsName.elementAt(index % 3),
                  color: colorName.elementAt(index % 3),
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _createStatusIndicatorRow({
    required String titleText,
    required IconData iconsName,
    required MaterialColor colorName,
  }) {
    return Row(
      children: [
        Icon(
          iconsName,
          color: colorName,
          size: 25,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(titleText, style: fontSize5())
      ],
    );
  }

  TextStyle fontSize5() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
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
}
