import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:crypto_saving_app/pages/auth/screen/auth_page.dart';
import 'package:crypto_saving_app/pages/auth/screen/register_page.dart';
import 'package:crypto_saving_app/pages/coin/coin_details_page.dart';
import 'package:crypto_saving_app/pages/main_page.dart';
import 'package:crypto_saving_app/pages/onboarding_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  // Note the $ before AppRouter
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnBoardingRoute.page, initial: true),
        AutoRoute(page: AuthenticationRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: MainRoute.page, path: '/main'),
        AutoRoute(page: CoinDetailsRoute.page, path: '/coin-details'),
        // AutoRoute(page: CoinRoute.page, path: '/coin'), // Uncomment this line if you have a CoinPage
        // AutoRoute(page: OrdersRoute.page, path: '/orders'), // Uncomment this line if you have an OrdersPage
        // AutoRoute(page: ProfileRoute.page, path: '/profile'), // Uncomment this line if you have a ProfilePage
      ];
}
