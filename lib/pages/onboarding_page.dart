import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);
  static const nameRoute = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBgColor.withOpacity(0.5),
        child: Column(
          children: [
            SafeArea(
              child: Image(
                image: AssetImage('assets/images/onboard1.png'),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.all(26),
              constraints: BoxConstraints.expand(
                height: 300,
                width: 315,
              ),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome!',
                    style: kHeading5.copyWith(color: kBlack),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Welcome to Crypto Super App, the easy way to improve your finances and help you control expenses and income',
                    style: kSubtitle2.copyWith(color: kSuvaGray),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ).then((_) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/auth', (route) => false);
                      });
                    },
                    child: Text(
                      'Get Started',
                      style: kButton1.copyWith(color: kWhite),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: kBlueRibbon,
                      padding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 36,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
