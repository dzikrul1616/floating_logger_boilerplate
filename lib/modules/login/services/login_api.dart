import 'package:floating_logger_boilerplate/packages/packages.dart';

class LoginApi {
  static Future<String?> submitLogin(
    ValueNotifier<bool> isLoading,
    BuildContext context,
    LoginPayload payload,
  ) async {
    try {
      final response = await DioLogger.instance.post(
        'https://fakestoreapi.com/auth/login',
        data: {
          "username": payload.username,
          "password": payload.password,
        },
      );

      isLoading.value = false;
      if (response.statusCode == 200) {
        isLoading.value = false;
        final data = response.data["token"];
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Success login'),
            ),
          );
          Navigator.pushNamed(
            context,
            ProductListPage.routeName,
          );
        }
        getIt<CustomLocalPref>().saveToken(data);
        return data;
      } else {
        isLoading.value = false;
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed login'),
            ),
          );
        }
      }
    } catch (e) {
      isLoading.value = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to login'),
          ),
        );
      }
    }
    return null;
  }
}
