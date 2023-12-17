import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/input/password_input.dart';
import 'package:penilaian/app/core/widgets/input/text_input_component.dart';
import 'package:penilaian/app/core/widgets/text/header_title.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/modules/auth/cubit/auth_cubit.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final _cubit = Modular.get<AuthCubit>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.to
                  .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              context.showSnackbar(message: 'Registration successful.');
            } else if (state is AuthError) {
              context.showSnackbar(
                  message: state.message, error: true, isPop: true);
            } else if (state is AuthLoading) {
              context.showLoadingIndicator();
            }
          },
          child: ReactiveFormBuilder(
            form: () => form,
            builder: (context, formG, child) {
              return SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/img/user.svg',
                            height: 75.0,
                          ),
                          SizedBox(height: 20.0),
                          Text("Let's get you started.", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15.0),
                          Text("Sign up with your information to create a new account.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5, 
                              fontSize: 16,
                              color: Colors.grey
                            ),
                          ),
                        ]
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextInputComponent(
                                formControlName: 'name',
                                hint: 'username',
                                label: 'Username',
                                isRequiredText: true,
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 25.0),
                              TextInputComponent(
                                formControlName: 'email',
                                hint: 'username@example.com',
                                label: 'Email',
                                isRequiredText: true,
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 25.0),
                              PasswordInput(
                                title: 'Password',
                                formControlName: 'password',
                                hint: "example123",
                              ),
                              SizedBox(height: 25.0),
                              PasswordInput(
                                title: 'Confirm Password',
                                formControlName: 'password_confirm',
                                hint: "example123",
                              ),
                              SizedBox(height: 25.0),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ReactiveFormConsumer(
                            builder: (context, formGB, child) {
                              return ElevatedButton(
                                onPressed: formGB.valid
                                ? () {
                                    _cubit.registerEmail(formGB.rawValue);
                                  }
                                : null,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Color(0xFF2F4FCD),
                                  minimumSize: Size(double.infinity, 50.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                ),
                                child: Text("Sign up", style: TextStyle(fontSize: 16)),
                              );
                            },
                          ),
                          // SizedBox(height: 25.0),
                          // ElevatedButton(
                          //   onPressed: () {},
                          //   style: ElevatedButton.styleFrom(
                          //     elevation: 0.0,
                          //     backgroundColor: Colors.white,
                          //     side: BorderSide(width: 1.0, color: Colors.grey),
                          //     minimumSize: Size(double.infinity, 50.0),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(50),
                          //     )
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       SvgPicture.asset(
                          //         'assets/img/google.svg',
                          //         width: 25.0,
                          //         height: 25.0,
                          //       ),
                          //       SizedBox(width: 8.0),
                          //       Text(
                          //         "Sign in with Google",
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           color: Colors.grey[800]
                          //         ),
                          //       ),
                          //     ],
                          //   )
                          // ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ", style: TextStyle(fontSize: 16, color: Colors.grey)),
                              GestureDetector(
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.login);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: <Widget>[
                      //     60.verticalSpacingRadius,
                      //     const HeaderTitle(
                      //       title: 'Daftar',
                      //     ),
                      //     60.verticalSpacingRadius,
                      //     const TextInputComponent(
                      //       formControlName: 'name',
                      //       hint: 'Masukkan Nama Lengkap',
                      //       label: 'Nama Lengkap',
                      //       isRequiredText: true,
                      //       textInputType: TextInputType.emailAddress,
                      //       prefix: Icon(Icons.person_outline_rounded),
                      //     ),
                      //     16.verticalSpacingRadius,
                      //     const TextInputComponent(
                      //       formControlName: 'email',
                      //       hint: 'Masukkan Email',
                      //       label: 'Email',
                      //       isRequiredText: true,
                      //       textInputType: TextInputType.emailAddress,
                      //       prefix: Icon(Icons.email_outlined),
                      //     ),
                      //     16.verticalSpacingRadius,
                      //     const PasswordInput(
                      //       title: 'Password',
                      //       formControlName: 'password',
                      //       hint: "Masukkan Password",
                      //       prefix: Icon(Icons.lock_outline_rounded),
                      //     ),
                      //     16.verticalSpacingRadius,
                      //     const PasswordInput(
                      //       title: 'Konfirmasi Password',
                      //       formControlName: 'password_confirm',
                      //       hint: "Masukkan Konfirmasi Password",
                      //       prefix: Icon(Icons.lock_outline_rounded),
                      //     ),
                      //     60.verticalSpacingRadius,
                      //     ReactiveFormConsumer(
                      //       builder: (context, formGB, child) {
                      //         return ElevatedButton(
                      //           onPressed: formGB.valid
                      //               ? () {
                      //                   _cubit.registerEmail(formGB.rawValue);
                      //                 }
                      //               : null,
                      //           child: const Text('Daftar'),
                      //         );
                      //       },
                      //     ),
                      //     50.verticalSpacingRadius,
                      //     Text.rich(
                      //       TextSpan(text: 'Sudah Punya akun?', children: [
                      //         TextSpan(
                      //           text: ' Login',
                      //           style: const TextStyle(
                      //               color: ColorTheme.statusGreen,
                      //               fontWeight: FontWeight.bold),
                      //           recognizer: TapGestureRecognizer()
                      //             ..onTap = () {
                      //               Modular.to.pop();
                      //             },
                      //         ),
                      //       ]),
                      //       style: AppStyles.text14Px.copyWith(
                      //         color: ColorTheme.neutral.shade700,
                      //       ),
                      //     ),
                      //     60.verticalSpacingRadius,
                      //   ],
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
