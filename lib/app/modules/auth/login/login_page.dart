import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/widgets/input/password_input.dart';
import 'package:penilaian/app/core/widgets/input/text_input_component.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/routes/app_routes.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/base/base_scaffold.dart';
import '../../../core/widgets/text/header_title.dart';
import '../cubit/auth_cubit.dart';

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
                .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
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
                          Text("Let's sign you in.", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                          SizedBox(height: 15.0),
                          Text("Sign in with your data that you have\nentered during your registration.",
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
                                formControlName: 'email',
                                hint: 'username@example.com',
                                label: 'Email',
                                isRequiredText: true,
                                textInputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 30.0),
                              PasswordInput(
                                title: 'Password',
                                formControlName: 'password',
                                hint: "example123",
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          Text("Forgot password?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold, 
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ReactiveFormConsumer(
                            builder: (context, formGB, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  _cubit.loginEmail(formGB.rawValue);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Color(0xFF2F4FCD),
                                  minimumSize: Size(double.infinity, 50.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )
                                ),
                                child: Text("Sign in", style: TextStyle(fontSize: 16)),
                              );
                            },
                          ),
                          SizedBox(height: 25.0),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              side: BorderSide(width: 1.0, color: Colors.grey),
                              minimumSize: Size(double.infinity, 50.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/img/google.svg',
                                  width: 25.0,
                                  height: 25.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800]
                                  ),
                                ),
                              ],
                            )
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ", style: TextStyle(fontSize: 16, color: Colors.grey)),
                              GestureDetector(
                                onTap: () {
                                  Modular.to.pushNamed(AppRoutes.register);
                                },
                                child: Text(
                                  "Register",
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
