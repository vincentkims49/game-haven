

import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 21, 25, 78).withOpacity(0.4),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: screenHeight * 0.023,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(screenWidth * 0.026),
          hintText: 'Search...',
          hintStyle: TextStyle(
              color: Colors.white60,
              fontSize: screenHeight * 0.023,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
