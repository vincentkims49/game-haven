import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:game_app/model/game_model.dart';
import 'package:game_app/pages/home/modalbottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key? key,
    required this.game,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final Game game;
  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return ModalbottomSheet(
                    screenHeight: screenHeight,
                    game: game,
                    screenWidth: screenWidth,
                  );
                },
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: game.backgroundImage,
                height: screenHeight,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return ModalbottomSheet(
                    screenHeight: screenHeight,
                    game: game,
                    screenWidth: screenWidth,
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                  stops: const [
                    0.0,
                    0.6,
                    0.7,
                    0.9,
                  ],
                ),
                border: Border.all(
                  color: Colors.transparent,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      maxLines: 1,
                      style: GoogleFonts.podkova(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent.withOpacity(.6),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          'Genres:',
                          style: GoogleFonts.podkova(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 116, 151, 169),
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
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white12),
                                    color:
                                        const Color.fromARGB(0, 251, 191, 191),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      right: 4,
                                    ),
                                    child: Center(
                                      child: Text(
                                        game.genres?[index]["name"] ?? "N/A",
                                        maxLines: 1,
                                        style: GoogleFonts.podkova(
                                          fontSize: 12,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
