
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final String postText;
  final String id;
  final DateTime timestamp;
  const CustomContainer(
      {super.key,
      required this.postText,
      required this.id,
      required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              id,
              style: GoogleFonts.playfairDisplay(
                fontSize: 10,
              ),
              textAlign: TextAlign.left,
            ),
            Center(
              child: Text(
                postText,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                ),
              ),
            ),
            Text(
              timestamp.toString(),
              style: GoogleFonts.playfairDisplay(
                fontSize: 10,
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
