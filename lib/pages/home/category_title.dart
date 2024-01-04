import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({
    super.key,
    required this.title,
    required this.description,
    required this.function,
  });
  final String title;
  final String description;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.podkova(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent),
            ),
            GestureDetector(
              onTap: function(),
              child: Text(
                description,
                style: GoogleFonts.podkova(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
