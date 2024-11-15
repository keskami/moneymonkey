import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleRow extends StatelessWidget {
  TitleRow({
    super.key,
    required this.page,
    required this.selectedSymbol,
    required this.investmentValue,
    required this.changePercentage,
  });

  final String page;
  final String selectedSymbol;
  final Map<String, List<String>> investmentDataUrls = {
    'AAPL': ["Apple Inc", ""],
    'PG': ["Procter & Gamble Co", ""],
    'JNJ': ["Johnson & Johnson", ""],
    'JPM': ["JP Morgan Chase", ""],
    'SPY': ["SPDR S&P 500 ETF Trust", ""],
    'QQQ': ["Invesco QQQ Trust", ""],
    'VUG': ["Vanguard Growth Index Fund ETF", ""],
    'QUAL': ["VanEck MSCI International Quality ETF", ""],
  };
  final double investmentValue;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: selectedSymbol.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${page} Value",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                const Text(
                  "🍌3000",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "0.00 0.00% Today >",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(4, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 35,
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2Fapple_logo.png?alt=media&token=151b1835-0e40-4bf7-b6d2-61dc70de963b",
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          investmentDataUrls[selectedSymbol]![0],
                          style: GoogleFonts.baloo2().copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          page.toUpperCase(),
                          style: GoogleFonts.baloo2().copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "🍌$investmentValue",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              changePercentage >= 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: changePercentage >= 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text(
                              changePercentage >= 0
                                  ? "(+$changePercentage%)"
                                  : "(-$changePercentage%)",
                              style: GoogleFonts.baloo2().copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
