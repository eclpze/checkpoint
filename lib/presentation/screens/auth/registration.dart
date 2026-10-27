import 'package:checkpoint/domain/globals.dart';
import 'package:checkpoint/domain/prefs.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/customButton.dart';
import 'package:checkpoint/presentation/uikit/components/customTextField.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vize/vize.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isPasswordVisible = false;
  bool isAgreementChecked = false;

  @override
  void initState() {
    super.initState();
    if (nameController != null) nameController.addListener(updateTextField);
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
    if (nameController != null) nameController.removeListener(updateTextField);
    if (emailController != null) emailController.removeListener(updateTextField);
    if (passwordController != null) passwordController.removeListener(updateTextField);
    super.dispose();
  }

  // Функция для показа SnackBar
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

  void handleRegistration() {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (name.isEmpty) {
      showErrorSnackBar('Введите ваше имя');
      return;
    }

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

    if (!isAgreementChecked) {
      showErrorSnackBar('Необходимо принять соглашение с политикой приложения');
      return;
    }

    Prefs.saveRegistration(name: name, email: email, password: password);
    print('Регистрация выполнена: $name, $email');
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
                    Text('Добро пожаловать!', style: AppTypography.title1Semibold),
                    SizedBox(height: 12.fh),
                    Text('Описание приложения', style: AppTypography.text2Bold),
                    SizedBox(height: 42.fh),
                    Form(
                      key: regKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Имя',
                            keyboardType: TextInputType.text,
                            prefixIcon: Padding(padding: ps(h: 17.5, v: 15), child: SvgPicture.asset('assets/icons/user.svg')),
                          ),
                          SizedBox(height: 22.fh),
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
                          SizedBox(height: 35.fh),

                          // Чекбокс соглашения
                          Row(
                            children: [
                              SizedBox(width: 5.fw),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAgreementChecked = !isAgreementChecked;
                                  });
                                },
                                child: Container(
                                  width: 20.fw,
                                  height: 20.fh,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.active, width: 2.fw),
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: isAgreementChecked ? AppColors.active : Colors.transparent,
                                  ),
                                  child: isAgreementChecked ? Icon(Icons.check, color: Colors.white, size: 14.fw) : null,
                                ),
                              ),
                              SizedBox(width: 11.fw),
                              Expanded(child: Text('Согласие с политикой приложения', style: AppTypography.textMeduim)),
                            ],
                          ),
                          SizedBox(height: 38.fh),
                          CustomButton(colorButton: hasReg ? AppColors.active : AppColors.inactive, onPressed: handleRegistration, textButton: 'Регистрация'),
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
                  Text('Есть аккаунт? ', style: AppTypography.textMeduim),
                  GestureDetector(
                    onTap: () {
                      navToOnSign(context);
                    },
                    child: Text('Войти', style: AppTypography.textMeduim.copyWith(color: AppColors.active)),
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
