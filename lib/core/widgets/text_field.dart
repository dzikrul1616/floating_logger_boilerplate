import 'package:floating_logger_boilerplate/packages/packages.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final ValueNotifier<bool>? isObscure;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
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
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 5.0),
              isPassword
                  ? ValueListenableBuilder<bool>(
                      valueListenable: isObscure!,
                      builder: (context, show, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller,
                                obscureText: show,
                                validator: (e) {
                                  if (e!.isEmpty) {
                                    return "$label cannot be empty!";
                                  }
                                  return null;
                                },
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: hintText,
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => isObscure!.value = !show,
                              child: Icon(
                                show
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye,
                              ),
                            ),
                          ],
                        );
                      })
                  : TextFormField(
                      controller: controller,
                      validator: (e) {
                        if (e!.isEmpty) {
                          return "$label cannot be empty!";
                        }
                        return null;
                      },
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        filled: true,
                        fillColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
