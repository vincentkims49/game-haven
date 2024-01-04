import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedContainerRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnimatedContainerRow({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: isSelected
                    ? Colors.redAccent.withOpacity(.2)
                    : Colors.transparent.withOpacity(0.1),
                blurRadius: 30,
                spreadRadius: isSelected ? screenWidth * 0.05 : 0,
                offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.04,
              height: screenHeight * 0.05,
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.redAccent : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                duration: const Duration(milliseconds: 500),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            FaIcon(
              icon,
              size: 20,
              color:
                  isSelected ? Colors.yellow : Colors.yellow.withOpacity(0.6),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: GoogleFonts.podkova(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
