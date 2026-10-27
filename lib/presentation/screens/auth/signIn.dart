import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/customButton.dart';
import 'package:checkpoint/presentation/uikit/components/customTextField.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    if (emailController != null) emailController.addListener(updateTextField);
    if (passwordController != null) passwordController.addListener(updateTextField);
  }

  void updateTextField() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    if (emailController != null) emailController.removeListener(updateTextField);
    if (passwordController != null) passwordController.removeListener(updateTextField);
    super.dispose();
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppColors.white, fontSize: 14.fh, fontFamily: 'Inter', fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(),
        duration: Duration(milliseconds: 1200),
      ),
    );
  }

  void handleSignIn() {
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email.isEmpty) {
      showErrorSnackBar('Введите адрес электронной почты');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      showErrorSnackBar('Некорректный формат электронной почты');
      return;
    }

    if (password.isEmpty) {
      showErrorSnackBar('Введите пароль');
      return;
    }

    if (password.length < 6) {
      showErrorSnackBar('Пароль должен содержать минимум 6 символов');
      return;
    }

    print('Вход выполнен: $email');
    navToMainScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: ps(h: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 140.fh),
                    Text('Вход в аккаунт', style: AppTypography.title1Semibold),
                    SizedBox(height: 12.fh),
                    Text('Описание приложения', style: AppTypography.text2Bold),
                    SizedBox(height: 52.fh),
                    Form(
                      key: signKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Почта',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Padding(padding: ps(h: 17.5, v: 15), child: SvgPicture.asset('assets/icons/message.svg')),
                          ),
                          SizedBox(height: 22.fh),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Пароль',
                            obscureText: !isPasswordVisible,
                            prefixIcon: Padding(padding: ps(h: 20, v: 15), child: SvgPicture.asset('assets/icons/lock.svg')),
                            suffixIcon: GestureDetector(
                              child: Padding(
                                padding: po(r: 15),
                                child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.grey, size: 20.fw),
                              ),
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 17.fh),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('Забыли пароль?', style: AppTypography.textMeduim),
                            ),
                          ),
                          SizedBox(height: 40.fh),
                          CustomButton(colorButton: hasSign ? AppColors.active : AppColors.inactive, onPressed: handleSignIn, textButton: 'Вход'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: po(b: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Нет аккаунта? ', style: AppTypography.textMeduim),
                  GestureDetector(
                    onTap: () {
                      navToReg(context);
                    },
                    child: Text('Зарегистрироваться', style: AppTypography.textMeduim.copyWith(color: AppColors.active)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
