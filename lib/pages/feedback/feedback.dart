import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:lottie/lottie.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => FeedbackPageState();
}

final GlobalKey<FeedbackPageState> feedbackPageKey =
    GlobalKey<FeedbackPageState>();

class FeedbackPageState extends State<FeedbackPage>
    with TickerProviderStateMixin {
  bool isDrawerOpen = false;

  double xOffset = 0;
  double yOffset = 0;

  late AnimationController _menuController;

  void handleFeedbackPageTransition() {
    isDrawerOpen
        ? {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              isDrawerOpen = false;
            }),
          }
        : {
            setState(() {
              xOffset = MediaQuery.of(context).size.width * 0.85;
              yOffset = MediaQuery.of(context).size.width * 0.2;
              isDrawerOpen = true;
            }),
          };

    if (_menuController.status == AnimationStatus.dismissed) {
      _menuController.reset();
      _menuController.animateTo(0.6);
    } else {
      _menuController.reverse();
    }
  }

  @override
  void dispose() {
    _menuController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 25, 129),
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(20) : BorderRadius.circular(0),
      ),
      child: Padding(
        padding: EdgeInsets.all(isDrawerOpen ? 8 : 0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 25, 129),
            elevation: 0,
            title: const Text(
              'Feedback',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.05,
                width: screenWidth * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 21, 25, 78).withOpacity(0.6),
                ),
                child: IconButton(
                  onPressed: () {
                    handleFeedbackPageTransition();
                  },
                  icon: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: Lottie.asset(Useanimations.menuV3,
                        controller: _menuController,
                        height: screenHeight * 0.028,
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const Center(
            child: Text(
              'Feedback',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
