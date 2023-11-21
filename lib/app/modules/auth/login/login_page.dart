import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/widgets/input/password_input.dart';
import 'package:penilaian/app/core/widgets/input/text_input_component.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/base/base_scaffold.dart';
import '../../../core/widgets/text/header_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final authCubit =
  final form = fb.group({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: ReactiveFormBuilder(
        form: () => form,
        builder: (context, formG, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                80.verticalSpacingRadius,
                const HeaderTitle(
                  title: 'Login',
                ),
                60.verticalSpacingRadius,
                const TextInputComponent(
                  formControlName: 'email',
                  hint: 'Masukkan Email',
                  label: 'Email',
                  isRequiredText: true,
                  textInputType: TextInputType.emailAddress,
                  prefix: Icon(Icons.person_outline_rounded),
                ),
                16.verticalSpacingRadius,
                const PasswordInput(
                  title: 'Password',
                  formControlName: 'password',
                  hint: "Masukkan Password",
                  prefix: Icon(Icons.lock_outline_rounded),
                ),
                18.verticalSpacingRadius,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    const TextSpan(
                      text: 'Lupa kata sandi?',
                      children: [
                        TextSpan(
                          text: ' Ganti',
                          style: TextStyle(
                            color: ColorTheme.statusGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: CustomTextTheme.paragraph1,
                  ),
                ),
                50.verticalSpacingRadius,
                ReactiveFormConsumer(
                  builder: (context, formGB, child) {
                    return ElevatedButton(
                      onPressed: formGB.valid
                          ? () {
                              Modular.to.pushNamed(AppRoutes.LOGIN);
                            }
                          : null,
                      child: const Text('Login'),
                    );
                  },
                ),
                50.verticalSpacingRadius,
                Text(
                  "- Atau masuk dengan -",
                  style: AppStyles.text14Px.copyWith(
                    color: ColorTheme.neutral.shade400,
                  ),
                ),
                20.verticalSpacingRadius,
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: 30.rounded,
                      border: Border.all(
                        color: ColorTheme.placeholder,
                        width: 1,
                      ),
                    ),
                    child: Image.asset('assets/img/google.png'),
                  ),
                ),
                20.verticalSpacingRadius,
                Text.rich(
                  TextSpan(text: 'Belum punya akun?', children: [
                    TextSpan(
                      text: ' Daftar',
                      style: const TextStyle(
                          color: ColorTheme.statusGreen, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Modular.to.pushNamed(AppRoutes.REGISTER);
                        },
                    ),
                  ]),
                  style: AppStyles.text14Px.copyWith(
                    color: ColorTheme.neutral.shade700,
                  ),
                ),
                60.verticalSpacingRadius,
              ],
            ),
          );
        },
      ),
    );
  }
}
