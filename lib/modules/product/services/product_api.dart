import 'package:floating_logger_boilerplate/packages/packages.dart';

class ProductApi {
  static Future<List<ProductListDataResponse>?> fetchList(
    ValueNotifier<bool> isLoading,
    BuildContext context,
  ) async {
    try {
      final response = await DioLogger.instance.get(
        'https://fakestoreapi.com/products',
        options: Options(headers: {
          "content-type": "application/json",
          "Authorization":
              "Bearer ${await getIt<CustomLocalPref>().getToken()}",
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        final data = jsonData
            .map((item) => ProductListDataResponse.fromJson(item))
            .toList();
        return data;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed fetch'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch facts')),
        );
      }
    }
    return null;
  }

  static Future<ProductListDataResponse?> fetchDetail(
    ValueNotifier<bool> isLoading,
    BuildContext context,
    int id,
  ) async {
    try {
      final response = await DioLogger.instance.get(
        'https://fakestoreapi.com/products/$id',
        options: Options(headers: {
          "content-type": "application/json",
          "Authorization":
              "Bearer ${await getIt<CustomLocalPref>().getToken()}",
        }),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = ProductListDataResponse.fromJson(response.data);
        return data;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed fetch'),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch facts')),
        );
      }
    }
    return null;
  }
}
