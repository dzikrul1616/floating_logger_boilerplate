import 'package:floating_logger_boilerplate/packages/packages.dart';

class LoginPage extends StatelessWidget {
  static const routeName = "/loginPage";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    final ValueNotifier<bool> isShow = ValueNotifier(true);
    final ValueNotifier<bool> isLoading = ValueNotifier(false);
    TextEditingController username = TextEditingController(text: 'mor_2314');
    TextEditingController password = TextEditingController(text: '83r5^_');
    return ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, loading, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: keyForm,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    _logo(context),
                    const LoginHeaderText(),
                    CustomTextFormField(
                      label: "Username",
                      hintText: "Enter your username",
                      controller: username,
                    ),
                    CustomTextFormField(
                      label: "Password",
                      hintText: "Enter your password",
                      controller: password,
                      isPassword: true,
                      isObscure: isShow,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _buttonLogin(
                      keyForm,
                      loading,
                      isLoading,
                      context,
                      username,
                      password,
                    ),
                    Spacer(),
                    const LoginBottomNotes(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _logo(
    BuildContext context,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Hero(
          tag: 'login',
          child: Image.asset(
            "assets/logo.gif",
            width: 250,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin(
    GlobalKey<FormState> keyForm,
    bool loading,
    ValueNotifier<bool> isLoading,
    BuildContext context,
    TextEditingController username,
    TextEditingController password,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (keyForm.currentState!.validate() && loading == false) {
          isLoading.value = true;
          LoginApi.submitLogin(
            isLoading,
            context,
            LoginPayload(
              username: username.text,
              password: password.text,
            ),
          );
        }
      },
      child: loading
          ? const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : const Text(
              "Login",
            ),
    );
  }
}
