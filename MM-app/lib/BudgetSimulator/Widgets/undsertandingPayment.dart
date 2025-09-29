import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderstandingPayment extends StatelessWidget {
  const UnderstandingPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeightUnit = MediaQuery.of(context).size.height / 1920;
    double screenWidthUnit = MediaQuery.of(context).size.width / 1607;

    return Stack(
      children: [
        Container(
            height: screenHeightUnit * 1000,
            width: screenWidthUnit * 700,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidthUnit * 0, top: screenHeightUnit * 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidthUnit * 46,
                              top: screenHeightUnit * 36),
                          child: Text(
                            "Understanding Payment History",
                            style: GoogleFonts.baloo2(
                              fontSize: screenHeightUnit * 65,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeightUnit * 27),
                        Container(
                          height: screenHeightUnit * 1,
                          width: screenWidthUnit * 700,
                          color: Color.fromRGBO(106, 114, 128, 1),
                        ),
                        SizedBox(height: screenHeightUnit * 41),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidthUnit * 46),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "What is Payment History? ",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 50,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(106, 114, 128, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "Payment history tracks whether you've\npaid your bills on time. It's the single most important factor in your\ncredit score.",
                                  style: GoogleFonts.baloo2(
                                    fontSize: screenHeightUnit * 50,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(106, 114, 128, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeightUnit * 18),
                        Center(
                            child: Container(
                          height: screenHeightUnit * 150,
                          width: screenWidthUnit * 600,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(233, 244, 255, 1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Color.fromRGBO(0, 127, 255, 1),
                                width: 1,
                              )),
                          child: Center(
                            child: Text(
                              "Payment History = 35% of your Credit Score",
                              style: GoogleFonts.baloo2(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 127, 255, 1),
                                fontSize: screenHeightUnit * 65,
                              ),
                            ),
                          ),
                        )),
                        SizedBox(height: screenHeightUnit * 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PaymentInfoBox(textColor: Color.fromRGBO(0, 199, 129, 1), title: 'Perfect Payment\nHistory', backColor: Color.fromRGBO(242, 255, 245, .7), effect: '+10',),
                            PaymentInfoBox(textColor: Color.fromRGBO(255, 176, 0, 1), title: 'Missed One\nPayment', backColor: Color.fromRGBO(255, 247, 233, .7), effect: '-10',),
                            PaymentInfoBox(textColor: Color.fromRGBO(255, 0, 0, 1), title: 'Missed All\nPayments', backColor: Color.fromRGBO(255, 243, 243, .7), effect: '-50',)

                          ],
                        )

                      ],
                    ),
                  ),
                ])),
        Positioned(
          top: screenHeightUnit * 26,
          right: screenWidthUnit * 31,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.close,
              size: screenHeightUnit * 80,
              color: Color.fromRGBO(106, 114, 128, 1),
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentInfoBox extends StatelessWidget {
  final Color textColor;
  final Color backColor;
  final String title;
  final String effect;

  const PaymentInfoBox({
    Key? key,
    required this.textColor,
    required this.title,
    required this.backColor,
    required this.effect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeightUnit = MediaQuery.of(context).size.height / 1920;
    double screenWidthUnit = MediaQuery.of(context).size.width / 1607;

    return Container(
        height: screenHeightUnit * 264,
        width: screenWidthUnit * 180,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black)),
        child: Padding(
          padding: EdgeInsets.only(
              left: screenWidthUnit * 18, top: screenHeightUnit * 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.baloo2(
                    fontSize: screenHeightUnit * 40,
                    fontWeight: FontWeight.w600,
                    color: textColor),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: screenHeightUnit * 25,
              ),
              Container(
                height: screenHeightUnit * 75,
                width: screenWidthUnit * 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: textColor,
                  ),
                  color: backColor,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: screenWidthUnit * 30, top: screenHeightUnit * 0),
                  child: Center(
                    child:  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Credit Score: ",
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: effect,
                          style: GoogleFonts.baloo2(
                            fontSize: screenHeightUnit * 30,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                  
                 
                ),
              )
            ],
          ),
        ));
  }
}
