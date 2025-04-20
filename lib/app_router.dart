import 'package:auto_route/auto_route.dart';
import 'package:crypto_saving_app/pages/auth/screen/auth_page.dart';
import 'package:crypto_saving_app/pages/auth/screen/register_page.dart';
import 'package:crypto_saving_app/pages/main_page.dart';
import 'package:crypto_saving_app/pages/onboarding_page.dart'; // Ensure this import exists

part 'app_router.gr.dart'; // Add this line

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnBoardingRoute.page, initial: true),
        AutoRoute(page: AuthenticationRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: MainRoute.page),
      ];
}
