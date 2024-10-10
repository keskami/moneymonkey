import 'package:flutter/material.dart';
import 'package:money_monkey/themes/color_themes.dart';

class TradeButton extends StatefulWidget {
  const TradeButton({
    super.key,
  });

  @override
  State<TradeButton> createState() => _TradeButtonState();
}

class _TradeButtonState extends State<TradeButton> {
  bool isExpanded = false;
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full-screen GestureDetector to detect taps outside the button
        if (isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = false;
                  showOptions = false;
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

        // The TradeButton itself
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              if (isExpanded) {
                // Collapse action
                setState(() {
                  isExpanded = false;
                  showOptions = false;
                });
              } else {
                // Expand action
                setState(() {
                  isExpanded = true;
                });
                // Delay showing options until the expansion animation is complete
                Future.delayed(const Duration(milliseconds: 200), () {
                  setState(() {
                    showOptions = true;
                  });
                });
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: MediaQuery.of(context).size.width / 3,
              height: isExpanded
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    LightTheme().primaryBlue,
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isExpanded && showOptions
                        ? [
                            GestureDetector(
                              onTap: () {
                                // Action for Buy
                              },
                              child: const Text(
                                'Buy',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Action for Sell
                              },
                              child: const Text(
                                'Sell',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]
                        : [
                            const Text(
                              'Trade',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
