import 'package:floating_logger_boilerplate/packages/packages.dart';

class RouteGenerator {
  static MaterialPageRoute<dynamic> pageRoute(
    Widget page, {
    bool isWithoutTest = false,
  }) =>
      MaterialPageRoute(builder: (_) {
        bool show = getIt<EnvServer>().isShowFloatingLogger;
        return isWithoutTest && show
            ? page
            : FloatingLoggerControl(
                getPreference: () async =>
                    await getIt<CustomLocalPref>().getDebugger(),
                child: page,
              );
      });

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    final args = settings.arguments;
    switch (settings.name) {
      case ProductListPage.routeName:
        return pageRoute(
          const ProductListPage(),
        );
      case SplashPage.routeName:
        return pageRoute(
          const SplashPage(),
        );
      case LoginPage.routeName:
        return pageRoute(
          const LoginPage(),
        );
      case ProductDetailPage.routeName:
        if (args is DetailModel) {
          return pageRoute(
            ProductDetailPage(
              param: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (context) {
          return const SplashPage();
        });
      case SettingPage.routeName:
        return pageRoute(
          isWithoutTest: true,
          const SettingPage(),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return const SplashPage();
        });
    }
  }
}
