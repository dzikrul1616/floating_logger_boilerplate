import 'package:floating_logger_boilerplate/packages/packages.dart';

class ListProductEmpty extends StatelessWidget {
  const ListProductEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopify,
            size: 50,
          ),
          Text(
            'Not found item!',
            style: GoogleFonts.oswald(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'There is no item available for now!',
            style: GoogleFonts.oswald(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
