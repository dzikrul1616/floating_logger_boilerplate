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
                    _usernameForm(
                      username,
                    ),
                    _passwordForm(
                      isShow,
                      password,
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

  Widget _usernameForm(
    TextEditingController username,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            TextFormField(
              controller: username,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Username Tidak Boleh Kosong!";
                }
                return null;
              },
              decoration: const InputDecoration.collapsed(
                hintText: "Username",
                filled: true,
                fillColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordForm(
    ValueNotifier<bool> isShow,
    TextEditingController password,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              ValueListenableBuilder(
                  valueListenable: isShow,
                  builder: (context, show, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: password,
                            obscureText: show,
                            validator: (e) {
                              if (e!.isEmpty) {
                                return "Password Tidak Boleh Kosong!";
                              }
                              return null;
                            },
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => isShow.value = !show,
                          icon: Icon(
                            show ? Icons.visibility_off : Icons.remove_red_eye,
                          ),
                        )
                      ],
                    );
                  }),
            ],
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
