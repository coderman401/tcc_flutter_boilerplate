// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tcc_flutter_boilerplate/core/components/app_text_field.dart';
import 'package:tcc_flutter_boilerplate/core/routes/app_route_name.dart';
import 'package:tcc_flutter_boilerplate/modules/auth/validators/auth_form_validators.dart';

import 'login_presenter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginViewContract {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool isObscure = true;
  bool isLoading = false;

  late LoginPresenter _presenter;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  loginProcess() async {
    FocusManager.instance.primaryFocus?.unfocus();
    _autoValidate = AutovalidateMode.always;
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      setState(() {
        isLoading = true;
      });
      final Map<String, String> payload = {
        'email': email,
        'password': password
      };
      print(payload);
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRouteName.home, (route) => false);
      });
      // _presenter.postLogin(payload);
    }
  }

  void _redirectTo(String path) {
    Navigator.pushNamed(
      context,
      path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _loginHeaderImage(),
            Text('Login',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0)),
            const SizedBox(height: 32),
            _loginForm(),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () => _redirectTo(AppRouteName.forgotPassword),
                child: const Text('Forgot Password ?'),
              ),
            ),
            const SizedBox(height: 8),
            _registerActionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _loginHeaderImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: const Center(
        child: FlutterLogo(size: 80),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            prefix: const Icon(Icons.alternate_email_rounded),
            hint: 'Email Address',
            textInputAction: TextInputAction.done,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: AuthFormValidators.emailValidator,
          ),
          const SizedBox(height: 16),
          AppTextField(
            obscureText: isObscure,
            prefix: const Icon(Icons.lock_outline_rounded),
            suffix: IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                }),
            hint: 'Password',
            textInputAction: TextInputAction.done,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: AuthFormValidators.passwordValidator,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: !isLoading ? loginProcess : null,
              style: ElevatedButton.styleFrom(
                // Foreground color
                // ignore: deprecated_member_use
                onPrimary: Theme.of(context).colorScheme.onPrimary,
                // Background color
                // ignore: deprecated_member_use
                primary: Theme.of(context).colorScheme.primary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              child: Text(
                isLoading ? 'Logging In...' : 'Login'.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerActionWidget() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account ? ',
              style: Theme.of(context).textTheme.button,
            ),
            TextSpan(
              text: 'Register here!',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _redirectTo(AppRouteName.register),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void loginError(error) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  void loginSuccess(dynamic data) {
    if (data['token']!.isNotEmpty) {
      _presenter.setSharedPreferences(data);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.pushNamedAndRemoveUntil(
        context, AppRouteName.home, (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login Successful!')),
    );
  }
}
