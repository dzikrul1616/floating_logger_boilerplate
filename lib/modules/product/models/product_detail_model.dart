import 'package:floating_logger_boilerplate/packages/packages.dart'
    show ValueNotifier;

class DetailModel {
  const DetailModel({
    required this.id,
    required this.off,
  });
  final int id;
  final ValueNotifier<bool> off;
}
