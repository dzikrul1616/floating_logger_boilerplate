import 'package:floating_logger_boilerplate/packages/packages.dart';

void main() {
  initInjection(Env.development);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}