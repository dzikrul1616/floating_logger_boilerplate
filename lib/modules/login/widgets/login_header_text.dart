import 'package:floating_logger_boilerplate/packages/packages.dart';

class LoginHeaderText extends StatelessWidget {
  const LoginHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 30,
      ),
      child: Text(
        'Hi, Welcome back!\nto floating logger example apps',
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
