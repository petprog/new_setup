import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:new_setup/common/buttons.dart';
import 'package:new_setup/common/input_field.dart';
import 'package:new_setup/core/core.dart';
import 'package:new_setup/models/auth/login_request_model.dart';
import 'package:new_setup/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    final provider = context.read<LoginProvider>();

    if (_formKey.currentState!.validate()) {
      provider.login(
        LoginRequestModel(
          email: _emailController.text,
          password: _passwordController.text,
        ),
        onSuccess: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successful")));
        },
        onError: (error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.help_outline_rounded, color: AppColors.textGrey),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 40),
        height: screenHeight * .15,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<LoginProvider>(
              builder: (context, provider, _) {
                return AppButton(
                  title: "Log in",
                  loading: provider.isLoading,
                  onTap: () => _handleLogin(context),
                );
              },
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "Dont't have an account? "),
                  TextSpan(
                    text: "Register",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Login to your Account",
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  "Enter your Email Address and Password",
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 30),
                AppInputField(
                  title: "Email Address",
                  compulsoryField: true,
                  hintText: "hello@ensake.com",
                  icon: Icons.email,
                  controller: _emailController,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 20),
                AppInputField(
                  title: "Password",
                  compulsoryField: true,
                  controller: _passwordController,
                  hintText: "• • • • • • • • • • ",
                  passwordField: true,
                  icon: Icons.lock,
                  validator: Validators.validateField,
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Forget Password ?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
