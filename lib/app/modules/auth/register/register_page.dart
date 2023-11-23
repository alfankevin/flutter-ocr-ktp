import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/input/password_input.dart';
import 'package:penilaian/app/core/widgets/input/text_input_component.dart';
import 'package:penilaian/app/core/widgets/text/header_title.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/widgets/base/base_scaffold.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final form = fb.group({
    'name': FormControl(validators: [Validators.required]),
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [Validators.required]),
    'password_confirm': FormControl(validators: [Validators.required]),
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
                60.verticalSpacingRadius,
                const HeaderTitle(
                  title: 'Daftar',
                ),
                60.verticalSpacingRadius,
                const TextInputComponent(
                  formControlName: 'name',
                  hint: 'Masukkan Nama Lengkap',
                  label: 'Nama Lengkap',
                  isRequiredText: true,
                  textInputType: TextInputType.emailAddress,
                  prefix: Icon(Icons.person_outline_rounded),
                ),
                16.verticalSpacingRadius,
                const TextInputComponent(
                  formControlName: 'email',
                  hint: 'Masukkan Email',
                  label: 'Email',
                  isRequiredText: true,
                  textInputType: TextInputType.emailAddress,
                  prefix: Icon(Icons.email_outlined),
                ),
                16.verticalSpacingRadius,
                const PasswordInput(
                  title: 'Password',
                  formControlName: 'password',
                  hint: "Masukkan Password",
                  prefix: Icon(Icons.lock_outline_rounded),
                ),
                16.verticalSpacingRadius,
                const PasswordInput(
                  title: 'Konfirmasi Password',
                  formControlName: 'password_confirm',
                  hint: "Masukkan Konfirmasi Password",
                  prefix: Icon(Icons.lock_outline_rounded),
                ),
                60.verticalSpacingRadius,
                ReactiveFormConsumer(
                  builder: (context, formGB, child) {
                    return ElevatedButton(
                      onPressed: formGB.valid
                          ? () {
                              Modular.to.pushNamed(AppRoutes.LOGIN);
                            }
                          : null,
                      child: const Text('Daftar'),
                    );
                  },
                ),
                50.verticalSpacingRadius,
                Text.rich(
                  TextSpan(text: 'Sudah Punya akun?', children: [
                    TextSpan(
                      text: ' Login',
                      style: const TextStyle(
                          color: ColorTheme.statusGreen, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Modular.to.pop();
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
