// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthenticationPage(),
      );
    },
    CoinBuyDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CoinBuyDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoinBuyDetailsPage(
          key: args.key,
          coinId: args.coinId,
        ),
      );
    },
    CoinSellDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CoinSellDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoinSellDetailsPage(
          key: args.key,
          coinId: args.coinId,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    OnBoardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnBoardingPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [AuthenticationPage]
class AuthenticationRoute extends PageRouteInfo<void> {
  const AuthenticationRoute({List<PageRouteInfo>? children})
      : super(
          AuthenticationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoinBuyDetailsPage]
class CoinBuyDetailsRoute extends PageRouteInfo<CoinBuyDetailsRouteArgs> {
  CoinBuyDetailsRoute({
    Key? key,
    required int coinId,
    List<PageRouteInfo>? children,
  }) : super(
          CoinBuyDetailsRoute.name,
          args: CoinBuyDetailsRouteArgs(
            key: key,
            coinId: coinId,
          ),
          initialChildren: children,
        );

  static const String name = 'CoinBuyDetailsRoute';

  static const PageInfo<CoinBuyDetailsRouteArgs> page =
      PageInfo<CoinBuyDetailsRouteArgs>(name);
}

class CoinBuyDetailsRouteArgs {
  const CoinBuyDetailsRouteArgs({
    this.key,
    required this.coinId,
  });

  final Key? key;

  final int coinId;

  @override
  String toString() {
    return 'CoinBuyDetailsRouteArgs{key: $key, coinId: $coinId}';
  }
}

/// generated route for
/// [CoinSellDetailsPage]
class CoinSellDetailsRoute extends PageRouteInfo<CoinSellDetailsRouteArgs> {
  CoinSellDetailsRoute({
    Key? key,
    required int coinId,
    List<PageRouteInfo>? children,
  }) : super(
          CoinSellDetailsRoute.name,
          args: CoinSellDetailsRouteArgs(
            key: key,
            coinId: coinId,
          ),
          initialChildren: children,
        );

  static const String name = 'CoinSellDetailsRoute';

  static const PageInfo<CoinSellDetailsRouteArgs> page =
      PageInfo<CoinSellDetailsRouteArgs>(name);
}

class CoinSellDetailsRouteArgs {
  const CoinSellDetailsRouteArgs({
    this.key,
    required this.coinId,
  });

  final Key? key;

  final int coinId;

  @override
  String toString() {
    return 'CoinSellDetailsRouteArgs{key: $key, coinId: $coinId}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnBoardingPage]
class OnBoardingRoute extends PageRouteInfo<void> {
  const OnBoardingRoute({List<PageRouteInfo>? children})
      : super(
          OnBoardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnBoardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
