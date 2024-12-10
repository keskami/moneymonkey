import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_monkey/themes/color_themes.dart';

class CustomStatFriends extends StatelessWidget {
  const CustomStatFriends({
    super.key,
    required this.accent,
    required this.title,
    required this.number,
    required this.iconURL,
  });
  final Color accent;
  final String number;
  final String title;
  final String iconURL;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent),
          color: LightTheme().primaryBackgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            iconURL,
            width: 35,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // If loadingProgress is null, the image has fully loaded
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          RichText(
            text: TextSpan(
                text: "$number\n",
                style: GoogleFonts.fredoka().copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: GoogleFonts.fredoka().copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
