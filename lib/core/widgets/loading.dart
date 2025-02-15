import 'dart:async';
import 'package:floating_logger_boilerplate/packages/packages.dart';

class LoadingCustom extends StatefulWidget {
  const LoadingCustom({super.key});

  @override
  State<LoadingCustom> createState() => _LoadingCustomState();
}

class _LoadingCustomState extends State<LoadingCustom> {
  Timer? _timer;
  bool _showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 2), () {
      setState(() {
        _showCheckIcon = true;
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        crossFadeState: _showCheckIcon
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Icon(
          Icons.check,
          color: Color(0xff689F81),
          size: 30,
        ),
        secondChild: CircularProgressIndicator(
          key: Key('circularProgressIndicator'),
          strokeWidth: 8,
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xff689F81),
          ),
        ),
      ),
    );
  }
}
