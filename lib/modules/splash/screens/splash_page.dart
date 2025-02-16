import 'package:floating_logger_boilerplate/packages/packages.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final customPreferences = getIt<CustomLocalPref>();

  Future<String> toPage() async {
    String routes;
    String token = await customPreferences.getToken();
    if (token.isEmpty) {
      routes = LoginPage.routeName;
    } else {
      routes = ProductListPage.routeName;
    }
    return routes;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        toPage().then((value) {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              value,
              (route) => false,
            );
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'login',
              child: Image.asset(
                "assets/logo.gif",
                width: 250,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const LoadingCustom(),
        ],
      ),
    );
  }
}
