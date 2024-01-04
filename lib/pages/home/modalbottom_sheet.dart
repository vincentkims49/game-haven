import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/model/game_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:awesome_rating/awesome_rating.dart';

import '../../block/fetch_game_details/fetch_game_details_state_cubit.dart';

class ModalbottomSheet extends StatelessWidget {
  const ModalbottomSheet({
    Key? key,
    required this.screenHeight,
    required this.game,
    required this.screenWidth,
  }) : super(key: key);

  final Game game;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 21, 25, 78),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.04),
        child: BlocProvider(
          create: (context) => GameDetailsCubit()
            ..fetchGameDetails(gameName: game.slug.toString()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<GameDetailsCubit, GameState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      if (state is GameDetailsLoaded) {
                        final url = Uri.parse(state.gameDetails!.website);
                        await launchUrl(url);
                      }
                    },
                    child: Container(
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent),
                      child: Center(
                        child: Text(
                          "Buy",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.podkova(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BottomSheetHero(
                          screenHeight: screenHeight,
                          game: game,
                          screenWidth: screenWidth),
                      BlocBuilder<GameDetailsCubit, GameState>(
                        builder: (context, state) {
                          if (state is GameDetailsLoading) {
                            return SizedBox(
                              height: screenHeight * 0.5,
                              child: Center(
                                child: LoadingAnimationWidget.halfTriangleDot(
                                  color: Colors.white,
                                  size: screenHeight * 0.03,
                                ),
                              ),
                            );
                          } else if (state is GameError) {
                            return Center(
                              child: Text(state.error),
                            );
                          } else if (state is GameDetailsLoaded) {
                            final gameDetails = state.gameDetails;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Metascore",
                                            style: GoogleFonts.podkova(
                                              fontSize: 20,
                                              color: Colors.redAccent,
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.02,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.redAccent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                                right: 5,
                                              ),
                                              child: Text(
                                                gameDetails!.metacritic
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      AwesomeStarRating(
                                        starCount: 5,
                                        rating: gameDetails.rating.toDouble(),
                                        size: screenHeight * 0.03,
                                        color: Colors.orange,
                                        borderColor: Colors.orange,
                                        allowHalfRating: false,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  ExpandableText(
                                    gameDetails.description,
                                    style: GoogleFonts.robotoSerif(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    animation: true,
                                    animationCurve: Curves.bounceOut,
                                    animationDuration:
                                        const Duration(seconds: 3),
                                    expandText: 'Read More',
                                    collapseText: "Read Less",
                                    maxLines: 10,
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Released:",
                                        style: GoogleFonts.podkova(
                                          fontSize: 20,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.white12),
                                          color: Colors.transparent,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Text(
                                            gameDetails.released.toString(),
                                            style: GoogleFonts.roboto(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Platforms:',
                                        style: GoogleFonts.podkova(
                                          fontSize: 20,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: screenHeight * 0.03,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                gameDetails.platforms.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white12),
                                                  color: Colors.transparent,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Center(
                                                    child: Text(
                                                      gameDetails
                                                          .platforms[index]
                                                          .name,
                                                      maxLines: 1,
                                                      style:
                                                          GoogleFonts.podkova(
                                                        fontSize: 15,
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Genre:",
                                        style: GoogleFonts.podkova(
                                          fontSize: 20,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: screenHeight * 0.03,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: game.genres?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white12),
                                                  color: Colors.transparent,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                    right: 5,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      game.genres?[index]
                                                              ["name"] ??
                                                          "N/A",
                                                      maxLines: 1,
                                                      style:
                                                          GoogleFonts.podkova(
                                                        fontSize: 15,
                                                        color: Colors.white70,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No Data'),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetHero extends StatelessWidget {
  const BottomSheetHero({
    super.key,
    required this.screenHeight,
    required this.game,
    required this.screenWidth,
  });

  final double screenHeight;
  final Game game;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight * 0.4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: CachedNetworkImage(
              imageUrl: game.backgroundImage,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.008,
          right: screenWidth * 0.018,
          child: Container(
            height: screenHeight * 0.05,
            width: screenWidth * 0.1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: const Color.fromARGB(255, 21, 25, 78).withOpacity(.6),
            ),
            child: IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.05,
                width: screenWidth,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Color.fromARGB(255, 21, 25, 78),
                ),
                child: Center(
                  child: Text(
                    game.name,
                    maxLines: 1,
                    style: GoogleFonts.podkova(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
