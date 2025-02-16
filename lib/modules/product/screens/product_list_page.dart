import 'package:floating_logger_boilerplate/packages/packages.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = "/productListPage";
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<ProductListDataResponse>? data;
  List<ProductListDataResponse>? filteredData;
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isSearch = ValueNotifier(false);
  @override
  void initState() {
    ProductApi.fetchList(isLoading, context).then((result) {
      if (mounted) {
        setState(() {
          data = result;
          filteredData = List.from(data ?? []);
        });
      }
    });
    super.initState();
  }

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() => filteredData = data);
      return;
    }
    setState(() {
      filteredData = data!
          .where(
              (item) => item.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isSearch,
      builder: (context, search, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: _actionAppbar(search, context),
            title: _titleAppbar(search),
          ),
          backgroundColor: const Color(0xffF0F0F0),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, loading, child) {
                return loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomRefresh(
                        onRefresh: () async =>
                            ProductApi.fetchList(isLoading, context)
                                .then((result) {
                          if (mounted) {
                            setState(() {
                              data = result;
                              filteredData = List.from(data ?? []);
                            });
                          }
                        }),
                        child: ListView(
                          children: [
                            const ProductHeader(),
                            filteredData!.isEmpty
                                ? const ListProductEmpty()
                                : ProductBody(
                                    filteredData: filteredData,
                                  ),
                          ],
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }

  List<Widget> _actionAppbar(bool search, BuildContext context) {
    return [
      search
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: () => isSearch.value = !search,
              icon: const Icon(Icons.search),
            ),
      getIt<EnvServer>().isShowFloatingLogger
          ? IconButton(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                SettingPage.routeName,
              ),
              icon: Icon(
                Icons.settings,
              ),
            )
          : const SizedBox.shrink(),
      IconButton(
        onPressed: () => CustomDialog.dialogInfo(
          context,
          "Are you sure want to logout?",
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Success logout'),
              ),
            );
            getIt<CustomLocalPref>().clearToken().then(
              (value) {
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.routeName,
                    (route) => false,
                  );
                }
              },
            );
          },
        ),
        icon: Icon(
          Icons.logout,
          color: Colors.red,
        ),
      ),
    ];
  }

  Widget _titleAppbar(bool search) {
    return Row(
      children: [
        search
            ? Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.grey[300]!,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          onChanged: filterSearch,
                          initialValue: null,
                          decoration: const InputDecoration.collapsed(
                            filled: true,
                            fillColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            hintText: "Search Product",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            isSearch.value = !search;
                            filterSearch('');
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.grey[800],
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Image.asset(
                "assets/logo.gif",
                width: 100,
                fit: BoxFit.fill,
              ),
      ],
    );
  }
}
