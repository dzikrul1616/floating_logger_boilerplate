import 'package:floating_logger_boilerplate/packages/packages.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/settingPage';
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final ValueNotifier<bool> isShowDebuggerNotifier = ValueNotifier<bool>(true);
  bool preferences = false;
  @override
  void initState() {
    getSettings();
    super.initState();
  }

  Future<void> getSettings() async {
    try {
      bool pref = await newMethod();
      setState(() {
        isShowDebuggerNotifier.value = pref;
        preferences = true;
      });
    } catch (e) {
      Exception(e);
    }
  }

  Future<bool> newMethod() async {
    return await getIt<CustomLocalPref>().getDebugger();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingLoggerControl(
      getPreference: newMethod,
      isShow: isShowDebuggerNotifier,
      child: PopScope(
        canPop: false,
        // ignore: deprecated_member_use
        onPopInvoked: (_) {
          Navigator.pushReplacementNamed(context, ProductListPage.routeName);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              "Setting",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: preferences
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Debugger API",
                                style: GoogleFonts.inter(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Deactivate Floating Debugger",
                                style: GoogleFonts.inter(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            activeTrackColor: Colors.blue,
                            value: isShowDebuggerNotifier.value,
                            onChanged: (value) {
                              setState(() {
                                isShowDebuggerNotifier.value = value;
                                getIt<CustomLocalPref>().saveDebugger(value);
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
