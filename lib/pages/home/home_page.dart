import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/useanimations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/pages/home/category_title.dart';
import 'package:game_app/pages/home/games_widget.dart';
import 'package:game_app/pages/home/header_title.dart';
import 'package:game_app/pages/home/hero_slider.dart';
import 'package:game_app/pages/home/search_input.dart';
import 'package:lottie/lottie.dart';
import '../../block/fetch_games/fetch_games_state_cubit.dart';

import '../category/category_names_row_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageContentState createState() => HomePageContentState();
}

final GlobalKey<HomePageContentState> homePageKey =
    GlobalKey<HomePageContentState>();

class HomePageContentState extends State<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  late AnimationController _menuController;
  late AnimationController _searchController;

  bool isDrawerOpen = false;

  late AnimationController _bellController;
  double xOffset = 0;
  double yOffset = 0;

  bool _isSearching = false;
  void handleHomePageTransition() {
    isDrawerOpen
        ? setState(() {
            xOffset = 0;
            yOffset = 0;
            isDrawerOpen = false;
          })
        : setState(() {
            xOffset = MediaQuery.of(context).size.width * 0.85;
            yOffset = MediaQuery.of(context).size.width * 0.2;
            isDrawerOpen = true;
          });

    if (_menuController.status == AnimationStatus.dismissed) {
      _menuController.reset();
      _menuController.animateTo(0.6);
    } else {
      _menuController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    topAlignmentAnimation();

    bottomAlignmentAnimation();
    _animationController.repeat();

    _menuController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    _searchController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    context.read<GameCubit>().fetchGames();
  }

  Animation<Alignment> bottomAlignmentAnimation() {
    return _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
  }

  Animation<Alignment> topAlignmentAnimation() {
    return _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _menuController.dispose();
    _bellController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
          body: Center(
            child: AnimatedBuilder(
              builder: (context, _) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: _topAlignmentAnimation.value,
                      end: _bottomAlignmentAnimation.value,
                      colors: isDrawerOpen
                          ? [
                              const Color.fromARGB(255, 18, 25, 129),
                              const Color.fromARGB(255, 18, 25, 129),
                            ]
                          : [
                              const Color.fromARGB(255, 18, 25, 129),
                              const Color.fromARGB(255, 27, 32, 100),
                              const Color.fromARGB(255, 6, 8, 30),
                            ],
                    ),
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        actions: [
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 21, 25, 78)
                                  .withOpacity(0.6),
                            ),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isSearching = !_isSearching;
                                });
                              },
                              icon: _isSearching
                                  ? ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      child: Lottie.asset(
                                          Icons8.icons8_search_6_,
                                          controller: _searchController,
                                          height: screenHeight * 0.023,
                                          fit: BoxFit.fitHeight),
                                    )
                                  : const Icon(Icons.search_sharp,
                                      color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: CachedNetworkImageProvider(
                                  "https://variety.com/wp-content/uploads/2023/06/MCDSPMA_SP062.jpg?w=1000&h=563&crop=1&resize=1000%2C563",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 21, 25, 78)
                                  .withOpacity(0.6),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                        ],
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(255, 21, 25, 78)
                                  .withOpacity(0.6),
                            ),
                            child: IconButton(
                              onPressed: () {
                                handleHomePageTransition();
                              },
                              icon: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                                child: Lottie.asset(Useanimations.menuV3,
                                    controller: _menuController,
                                    height: screenHeight * 0.028,
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ),
                        ),
                        centerTitle: true,
                        title: _isSearching
                            ? const SearchInput()
                            : HeaderTitle(
                                screenWidth: screenWidth,
                                screenHeight: screenHeight),
                        elevation: 0,
                        stretch: true,
                        pinned: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(255, 21, 25, 78),
                        expandedHeight: screenHeight * 0.3,
                        flexibleSpace: HeroSlider(
                            screenHeight: screenHeight,
                            screenWidth: screenWidth),
                      ),
                      CategoryTitle(
                        title: 'Categories',
                        function: () {},
                        description: 'See all',
                      ),
                      const CategoryNamesRowWidget(),
                      CategoryTitle(
                        title: 'Top Games',
                        function: () {},
                        description: '',
                      ),
                      GamesWidget(
                          screenWidth: screenWidth, screenHeight: screenHeight),
                    ],
                  ),
                );
              },
              animation: _animationController,
            ),
          ),
        ),
      ),
    );
  }
}
