import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'category_names.dart';

class CategoryNamesRowWidget extends StatelessWidget {
  const CategoryNamesRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            CategoryNames().categoryNames.length,
            (index) => Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8,),
                child: Text(
                  CategoryNames().categoryNames[index],
                  style:  GoogleFonts.podkova(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}