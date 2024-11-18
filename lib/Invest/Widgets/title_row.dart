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
    'AAPL': [
      "Apple Inc",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FappleStock.png?alt=media&token=6cd5e50e-3123-40e2-a64c-b45081930a49",
    ],
    'PG': [
      "Procter & Gamble Co",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FpgStock.jpeg?alt=media&token=28c86f64-2c02-4f89-8f87-5a2e37a7a3f0"
    ],
    'JNJ': [
      "Johnson & Johnson",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FjnjStock.jpg?alt=media&token=c6d3d307-5971-4b2a-b220-831f7a5b9b99",
    ],
    'JPM': [
      "JP Morgan Chase",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FjpmStock.png?alt=media&token=d323754e-8b03-43dc-8dd4-2c74392b035b",
    ],
    'SPY': [
      "SPDR S&P 500 ETF Trust",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FspyETF.webp?alt=media&token=caf7945f-67d0-4f29-9147-69677e000009",
    ],
    'QQQ': [
      "Invesco QQQ Trust",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FqqqETF.png?alt=media&token=af23d36f-0bc0-48ab-ae15-ecca1a9b2fcc"
    ],
    'VUG': [
      "Vanguard Growth Index Fund ETF",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FvugETF.png?alt=media&token=201a7005-188b-4567-a616-9819610296a5",
    ],
    'QUAL': [
      "VanEck MSCI International Quality ETF",
      "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2FqualETF.jpg?alt=media&token=614bc14e-95fd-4611-98e8-3d8fcfb1b1a8",
    ],
  };
  final double investmentValue;
  final double changePercentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.13,
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
                      child: ClipOval(
                        child: Image.network(
                          investmentDataUrls[selectedSymbol]![1],
                          fit: BoxFit
                              .cover, // This ensures the image covers the entire circle
                          width:
                              70, // Ensure the width and height are the same to maintain a circular image
                          height: 70,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
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
