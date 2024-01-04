import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:game_app/pages/category/categories.dart';
import 'package:game_app/pages/drawer/animated_container_row.dart';
import 'package:google_fonts/google_fonts.dart';

import '../feedback/feedback.dart';
import '../help/help.dart';
import '../home/home_page.dart';
import '../settings/settings.dart';

class DrawerScreen extends StatefulWidget {
  final void Function(String) onRowSelectionChanged;

  const DrawerScreen({Key? key, required this.onRowSelectionChanged})
      : super(key: key);

  @override
  DrawerScreenState createState() => DrawerScreenState();
}

final GlobalKey<DrawerScreenState> drawerPageKey =
    GlobalKey<DrawerScreenState>();

class DrawerScreenState extends State<DrawerScreen> {
  String selectedRow = 'Games';
  void _handleRowSelection(String newSelectedRow) {
    setState(() {
      selectedRow = newSelectedRow;
    });
    widget.onRowSelectionChanged(selectedRow);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(255, 21, 25, 78),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.05,
                  left: screenHeight * 0.03,
                ),
                child: Row(
                  children: [
                    Container(
                      height: screenHeight * 0.06,
                      width: screenHeight * 0.06,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: CachedNetworkImageProvider(
                            "https://variety.com/wp-content/uploads/2023/06/MCDSPMA_SP062.jpg?w=1000&h=563&crop=1&resize=1000%2C563",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John\'s',
                          style: GoogleFonts.podkova(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'john@gmail.com',
                          style: GoogleFonts.podkova(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  AnimatedContainerRow(
                    text: 'Games',
                    icon: FontAwesomeIcons.gamepad,
                    isSelected: selectedRow == 'Games',
                    onTap: () {
                      homePageKey.currentState?.handleHomePageTransition();

                      _handleRowSelection('Games');
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AnimatedContainerRow(
                    text: 'Category',
                    icon: FontAwesomeIcons.shapes,
                    isSelected: selectedRow == 'Category',
                    onTap: () {
                      categoryPageKey.currentState?.handleCategoryPageTransition();

                      _handleRowSelection('Category');
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AnimatedContainerRow(
                    text: 'Feedback',
                    icon: FontAwesomeIcons.commentDots,
                    isSelected: selectedRow == 'Feedback',
                    onTap: () {
                      feedbackPageKey.currentState
                          ?.handleFeedbackPageTransition();
                      _handleRowSelection('Feedback');
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AnimatedContainerRow(
                    text: 'Settings',
                    icon: FontAwesomeIcons.screwdriverWrench,
                    isSelected: selectedRow == 'Settings',
                    onTap: () {
                      settingsPageKey.currentState
                          ?.handleSettingsPageTransition();
                      _handleRowSelection('Settings');
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AnimatedContainerRow(
                    text: 'Help',
                    icon: FontAwesomeIcons.circleQuestion,
                    isSelected: selectedRow == 'Help',
                    onTap: () {
                      helpPageKey.currentState?.handleHelpPageTransition();
                      _handleRowSelection('Help');
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenHeight * 0.03,
                  bottom: screenHeight * 0.07,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.rightFromBracket,
                                color: Colors.red,
                                size: 22,
                              ),
                              SizedBox(
                                width: screenHeight * 0.01,
                              ),
                              Text(
                                'LogOut',
                                style: GoogleFonts.podkova(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        // This is the  container on the leftside
        // of the drawer
        AnimatedContainer(
          transform: Matrix4.translationValues(
              MediaQuery.of(context).size.width * 0.77,
              MediaQuery.of(context).size.width * 0.28,
              0)
            ..scale(0.85)
            ..rotateZ(-50),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 18, 25, 129).withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          height: screenHeight * 0.88,
        ),
      ],
    );
  }
}
