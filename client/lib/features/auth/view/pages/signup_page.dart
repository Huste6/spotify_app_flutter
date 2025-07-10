import 'package:client/cor/theme/app_pallete.dart';
import 'package:client/cor/utils.dart';
import 'package:client/cor/widgets/loader.dart';
import 'package:client/features/auth/view/pages/login_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    //Lắng nghe sự thay đổi của provider nhận vào prev và next nhưng ở đây xử lý sau khi mà có sự thay đổi provider
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackBar(
                context, 'Account created successfully! Please Login.');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          error: (error, stackTrace) {
            showSnackBar(context, error.toString());
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
