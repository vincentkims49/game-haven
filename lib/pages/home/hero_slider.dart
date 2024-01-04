import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game_app/images/appbar_images.dart';
import 'package:google_fonts/google_fonts.dart';


class HeroSlider extends StatelessWidget {
   const HeroSlider({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Stack(
        children: [
          CarouselSlider(
            items: AppBarImages.images.map((imageUrl) {
              return CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: imageUrl,
              );
            }).toList(),
            options: CarouselOptions(
              height: screenHeight,
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay:  true,
              autoPlayInterval: const Duration(seconds: 15),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.01,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 21, 25, 78).withOpacity(0.4),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi, ',
                            style: GoogleFonts.roboto(
                              color: Colors.yellow,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          Text(
                            'John!',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Ready to play?',
                            style: GoogleFonts.roboto(
                              color: Colors.white54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
