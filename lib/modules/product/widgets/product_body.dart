import 'package:floating_logger_boilerplate/packages/packages.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({
    super.key,
    required this.filteredData,
  });
  final List<ProductListDataResponse>? filteredData;
  @override
  Widget build(BuildContext context) {
    var crossAxisCount = MediaQuery.of(context).size.width > 900 &&
            MediaQuery.of(context).size.width < 1200
        ? 3
        : MediaQuery.of(context).size.width >= 1200 &&
                MediaQuery.of(context).size.width < 1600
            ? 4
            : MediaQuery.of(context).size.width >= 1600
                ? 5
                : 2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.0,
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          mainAxisExtent: 230,
        ),
        itemCount: filteredData?.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final item = filteredData![index];
          final ValueNotifier<bool> off = ValueNotifier(true);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              ProductDetailPage.routeName,
              arguments: DetailModel(
                id: item.id!,
                off: off,
              ),
            ),
            child: ValueListenableBuilder(
                valueListenable: off,
                builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  10,
                                ),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      item.image!,
                                    )),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                onPressed: () {
                                  off.value = !value;
                                },
                                icon: Icon(
                                  value
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: value ? Colors.grey[700] : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                item.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${item.price.toString()}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item.rating!.rate.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
