import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/app_router.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

@RoutePage()
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

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
            const SizedBox(height: 70),
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
                  const SizedBox(height: 15),
                  Text(
                    'Welcome to Crypto Super App, the easy way to improve your finances and help you control expenses and income',
                    style: kSubtitle2.copyWith(color: kSuvaGray),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 70),
                  TextButton(
                    onPressed: () {
                      context.router.push(
                        const AuthenticationRoute(),
                      );
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
