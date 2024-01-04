import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromARGB(255, 21, 25, 78)
              .withOpacity(0.4),
        ),
        child: SizedBox(
          width: screenWidth * 0.45,
          height: screenHeight * 0.05,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                'GAME',
                style: GoogleFonts.aboreto(
                  color: Colors.red[600],
                  fontSize: screenHeight * 0.028,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'HAVEN',
                style: GoogleFonts.aclonica(
                  color: Colors.white,
                  fontSize: screenHeight * 0.028,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
