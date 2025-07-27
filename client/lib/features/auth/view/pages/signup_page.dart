import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/widgets/loader.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/cor/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showToast(String message, {bool isError = false}) {
    ShadToaster.of(context).show(ShadToast(
      title: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.check_circle,
            color: isError ? Colors.red : Colors.green,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            isError ? 'Lỗi' : 'Thành công',
            style: TextStyle(
              color: isError ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      description: Text(
        message,
        style: TextStyle(
          color: isError ? Colors.red.shade300 : Colors.green.shade300,
        ),
      ),
      action: ShadButton.outline(
        size: ShadButtonSize.sm,
        onPressed: () => ShadToaster.of(context).hide(),
        child: const Text('Đóng'),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    //Lắng nghe sự thay đổi của provider nhận vào prev và next nhưng ở đây xử lý sau khi mà có sự thay đổi provider
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            // Hiển thị thông báo đăng ký thành công
            _showToast('Tài khoản đã được tạo thành công! Vui lòng đăng nhập.');

            // Navigate to Login Page sau khi hiển thị thông báo
            Future.delayed(const Duration(milliseconds: 2000), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            });
          },
          error: (error, stackTrace) {
            // Hiển thị thông báo đăng ký thất bại
            _showToast('Đăng ký thất bại: ${error.toString()}', isError: true);
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomField(
                      controller: nameController,
                      hintText: 'Name',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomField(
                      controller: passwordController,
                      hintText: 'Password',
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      Text_Button: 'Sign up',
                      onTap: () async {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                  name: name, email: email, password: password);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                      color: Pallete.gradient2,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
