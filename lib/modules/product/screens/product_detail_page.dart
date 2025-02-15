import 'package:floating_logger_boilerplate/packages/packages.dart';

class ProductDetailPage extends StatefulWidget {
  static const routeName = "/itemPage";
  const ProductDetailPage({
    super.key,
    required this.param,
  });
  final DetailModel param;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductListDataResponse? data;
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  @override
  void initState() {
    ProductApi.fetchDetail(
      isLoading,
      context,
      widget.param.id,
    ).then((result) {
      if (mounted) {
        setState(() {
          data = result;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.param.off,
        builder: (context, value, child) {
          return ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, loading, c) {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'There is no action for this button',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Add To Cart",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _header(
                                  context,
                                  value,
                                ),
                                _body(),
                              ],
                            ),
                          ),
                        ),
                );
              });
        });
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data!.title!,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                '\$${data!.price.toString()}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Text(
                data!.category!,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data!.description!,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                "Rating : ",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "${data!.rating!.rate}",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(
                "(${data!.rating!.count} Person)",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, bool value) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Hero(
            tag: '${data!.id}',
            child: Image.network(
              data!.image!,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.param.off.value = !value;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        value ? Icons.favorite_border : Icons.favorite,
                        color: value ? Colors.grey[700] : Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
