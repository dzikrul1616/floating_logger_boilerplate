import 'package:floating_logger_boilerplate/packages/packages.dart';

class LoginBottomNotes extends StatelessWidget {
  const LoginBottomNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "*Note :\nYou can login with this account :\nusername : mor_2314\npass : 83r5^_'",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Floating Logger v.0.1.2",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
