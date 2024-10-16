import 'package:flutter/material.dart';

class BuyPopUp extends StatelessWidget {
  const BuyPopUp({
    super.key,
    required this.selectedSymbol,
  });

  final String selectedSymbol;
  final Map<String, String> imageUrl = const {
    "AAPL":
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2Fapple.png?alt=media&token=ad6a644b-60a7-48ef-adc9-e4e865589d50",
    "PG":
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2Fgrapes.png?alt=media&token=49c7e8d0-7c38-4323-b87c-ddd53aa4954c",
    "JNJ":
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2Favocado.png?alt=media&token=f24f255d-963b-4410-be52-e8c7389fbc7c",
    "JPM":
        "https://firebasestorage.googleapis.com/v0/b/money-monkey-f4d73.appspot.com/o/Images%20and%20Vectors%2FInvest%20Section%2Fapricot.png?alt=media&token=4e321c69-8e3d-404f-900f-f23bd8115966",
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
                Image.network(
                  imageUrl[selectedSymbol]!,
                  height: MediaQuery.of(context).size.width *
                      0.5, // Adjust the image size as needed
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromARGB(
                  255,
                  137,
                  220,
                  142,
                ),
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Buy",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
